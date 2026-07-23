import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/settings_repository.dart';
import '../../data/models/settings_dto.dart';
import '../../data/local/database/app_database.dart';

final settingsRepositoryProvider = Provider((ref) {
  final database = ref.watch(databaseProvider);
  return SettingsRepository(database);
});

final settingsProvider = FutureProvider((ref) async {
  final repo = ref.watch(settingsRepositoryProvider);
  return repo.getSettings();
});

final darkModeProvider = StateProvider<bool>((ref) {
  return false;
});

final languageProvider = StateProvider<String>((ref) {
  return 'en';
});

final notificationsEnabledProvider = StateProvider<bool>((ref) {
  return true;
});

final backgroundMonitoringProvider = StateProvider<bool>((ref) {
  return true;
});

final syncIntervalProvider = StateProvider<int>((ref) {
  return 15;
});

final updateSettingsProvider = FutureProvider.family<void, SettingsDTO>((ref, settings) async {
  final repo = ref.watch(settingsRepositoryProvider);
  await repo.saveSettings(settings);
  ref.invalidate(settingsProvider);
});

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
