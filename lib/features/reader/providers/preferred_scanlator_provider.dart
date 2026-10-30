import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shonenx/shared/providers/storage_provider.dart';

class PreferredScanlatorNotifier extends Notifier<String?> {
  final String mangaId;

  PreferredScanlatorNotifier(this.mangaId);

  @override
  String? build() {
    return ref.read(sharedPreferencesProvider).getString('scanlator:$mangaId');
  }

  void setPreferred(String? scanlator) {
    state = scanlator;
    final storage = ref.read(sharedPreferencesProvider);
    if (scanlator == null) {
      storage.remove('scanlator:$mangaId');
    } else {
      storage.setString('scanlator:$mangaId', scanlator);
    }
  }
}

final preferredScanlatorProvider =
    NotifierProvider.family<PreferredScanlatorNotifier, String?, String>(
      PreferredScanlatorNotifier.new,
    );
