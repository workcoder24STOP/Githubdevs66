import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shonenx/shared/providers/storage_provider.dart';
import 'package:shonenx/features/reader/providers/preferred_scanlator_provider.dart';

void main() {
  test(
    'preferred scanlator survives provider recreation and remains title-specific',
    () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      var container = ProviderContainer(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      );
      container
          .read(preferredScanlatorProvider('title-a').notifier)
          .setPreferred('Group A');
      expect(container.read(preferredScanlatorProvider('title-b')), isNull);
      container.dispose();
      container = ProviderContainer(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      );
      expect(container.read(preferredScanlatorProvider('title-a')), 'Group A');
      container
          .read(preferredScanlatorProvider('title-a').notifier)
          .setPreferred(null);
      expect(prefs.getString('scanlator:title-a'), isNull);
      container.dispose();
    },
  );
}
