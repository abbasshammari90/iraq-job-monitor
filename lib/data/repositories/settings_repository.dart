import '../../local/database/app_database.dart';
import '../../models/settings_dto.dart';

class SettingsRepository {
  final AppDatabase _database;
  static const String _settingsId = 'default_settings';

  SettingsRepository(this._database);

  Future<SettingsDTO> getSettings() async {
    final all = await _database.select(_database.settingsEntity).get();
    if (all.isEmpty) {
      return const SettingsDTO(
        isDarkMode: false,
        languageCode: 'en',
        notificationsEnabled: true,
        backgroundMonitoringEnabled: true,
        autoUpdateEnabled: true,
        syncIntervalMinutes: 15,
      );
    }
    return SettingsDTO.fromEntity(all.first);
  }

  Future<void> updateSettings(SettingsDTO settings) async {
    final companion = SettingsEntityCompanion(
      id: const Value(_settingsId),
      isDarkMode: Value(settings.isDarkMode),
      languageCode: Value(settings.languageCode),
      notificationsEnabled: Value(settings.notificationsEnabled),
      backgroundMonitoringEnabled: Value(settings.backgroundMonitoringEnabled),
      autoUpdateEnabled: Value(settings.autoUpdateEnabled),
      syncIntervalMinutes: Value(settings.syncIntervalMinutes),
      createdAt: Value(DateTime.now()),
    );

    await _database.into(_database.settingsEntity).insertOnConflictUpdate(companion);
  }
}
