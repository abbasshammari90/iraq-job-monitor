import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/settings_dto.dart';
import 'providers.dart';

final settingsProvider = FutureProvider<SettingsDTO>((ref) async {
  final settingsRepo = ref.watch(settingsRepositoryProvider);
  return settingsRepo.getSettings();
});

final darkModeProvider = StateProvider<bool>((ref) {
  ref.listen(settingsProvider, (previous, next) {
    next.whenData((settings) {
      ref.state = settings.isDarkMode;
    });
  });
  return false;
});

final languageProvider = StateProvider<String>((ref) {
  ref.listen(settingsProvider, (previous, next) {
    next.whenData((settings) {
      ref.state = settings.languageCode;
    });
  });
  return 'en';
});

final updateSettingsProvider = FutureProvider.family<void, SettingsDTO>((ref, settings) async {
  final settingsRepo = ref.watch(settingsRepositoryProvider);
  await settingsRepo.updateSettings(settings);
  ref.invalidate(settingsProvider);
  ref.invalidate(darkModeProvider);
  ref.invalidate(languageProvider);
});
