// Small, dependency-free probe of a real catalog using the application's decoder.
// dart run scripts/verify-manga-catalog.dart /path/to/index.pb
import 'dart:io';
import 'dart:typed_data';
import '../packages/anymex_extension_bridge/lib/Services/Shared/ProtoReader.dart';
void main(List<String> args) {
  if (args.length != 1) throw ArgumentError('Pass a downloaded index.pb path');
  var bytes = File(args.single).readAsBytesSync();
  if (bytes.length > 1 && bytes[0] == 31 && bytes[1] == 139) {
    bytes = Uint8List.fromList(gzip.decode(bytes));
  }
  final store = ProtoMessage.decode(bytes);
  final extensions = store.readMessage(101)?.readMessages(1);
  if (extensions == null) throw FormatException('Catalog uses external list: ${store.readString(102)}');
  stdout.writeln('${extensions.length} extension packages');
  for (final extension in extensions) {
    if (!{'Kagane','Atsumaru'}.contains(extension.readString(1))) continue;
    stdout.writeln('${extension.readString(1)} API${extension.readString(4)}');
    for (final source in extension.readMessages(8)) {
      stdout.writeln('  ${source.readString(3)}: ${source.readInt(1)} ${source.readString(4)}');
    }
  }
}
