import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:anymex_extension_runtime_bridge/Services/Shared/ProtoReader.dart';
import 'package:shonenx/features/extensions/providers/extension_service_provider.dart';
import 'package:shonenx/source_engine/matchmaker/match_service.dart';
import 'package:shonenx/features/offline/offline_catalog.dart';

void main() {
  test('user supplied GitHub raw protobuf URL stays a protobuf URL', () {
    expect(
      ExtensionAdapter.normalizeRepoUrl(
        'https://github.com/keiyoushi/extensions/raw/repo/index.pb',
        'aniyomi',
      ),
      'https://raw.githubusercontent.com/keiyoushi/extensions/repo/index.pb',
    );
  });
  test(
    'real Keiyoushi catalog retains Kagane/Atsumaru 64-bit source identities',
    () {
      var bytes = File('test/fixtures/keiyoushi-index.pb').readAsBytesSync();
      if (bytes[0] == 31 && bytes[1] == 139)
        bytes = Uint8List.fromList(gzip.decode(bytes));
      final store = ProtoMessage.decode(bytes);
      final extensions = store.readMessage(101)!.readMessages(1);
      expect(extensions.length, greaterThan(1000));
      for (final pair in [
        ('Kagane', '4024736764982024684'),
        ('Atsumaru', '2327480808438768017'),
      ]) {
        final extension = extensions.firstWhere(
          (e) => e.readString(1) == pair.$1,
        );
        expect(extension.readMessages(8).first.readInt(1).toString(), pair.$2);
        expect(extension.readString(4), '1.6');
        expect(
          Uri.parse(extension.readMessage(3)!.readString(1)!).scheme,
          'https',
        );
      }
    },
  );
  test(
    'a truncated catalog fails rather than presenting an incomplete index',
    () {
      expect(
        () => ProtoMessage.decode(Uint8List.fromList([10, 8, 1, 2])),
        throwsFormatException,
      );
      expect(
        () => ProtoMessage.decode(Uint8List.fromList([8, 128])),
        throwsFormatException,
      );
    },
  );
  test('matching preserves non-Latin titles and rejects different seasons', () {
    expect(MediaMatchService.similarity('進撃の巨人', '進撃の巨人'), 1);
    expect(MediaMatchService.similarity('One Piece', 'Unrelated manga'), 0);
    expect(
      MediaMatchService.similarity('Example Season 2', 'Example Season 3'),
      0,
    );
  });
  test('imported manga page numbers sort naturally', () {
    final pages = ['10.webp', '2.webp', '1.webp']
      ..sort(OfflineCatalog.naturalCompare);
    expect(pages, ['1.webp', '2.webp', '10.webp']);
  });
}
