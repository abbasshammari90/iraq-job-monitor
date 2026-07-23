import '../../models/settings_dto.dart';
import '../database/app_database.dart';
import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';

class SettingsRepository {
  final AppDatabase _database;
  static const String _defaultSettingsId = 'default';

  SettingsRepository(this._database);

  Future<SettingsDTO> getSettings() async {
    final settings = await _database.getSettings();
    if (settings == null) {
      final defaultSettings = SettingsDTO(
        id: _defaultSettingsId,
        isDarkMode: false,
        languageCode: 'en',
        notificationsEnabled: true,
        backgroundMonitoringEnabled: true,
        autoUpdateEnabled: true,
        syncIntervalMinutes: 15,
        updatedAt: DateTime.now(),
      );
      await saveSettings(defaultSettings);
      return defaultSettings;
    }
    return _mapToDTO(settings);
  }

  Future<void> saveSettings(SettingsDTO settings) async {
    final existing = await _database.getSettings();
    if (existing == null) {
      await _database.insertSettings(
        SettingsTableCompanion(
          id: drift.Value(settings.id),
          isDarkMode: drift.Value(settings.isDarkMode),
          languageCode: drift.Value(settings.languageCode),
          notificationsEnabled: drift.Value(settings.notificationsEnabled),
          backgroundMonitoringEnabled:
              drift.Value(settings.backgroundMonitoringEnabled),
          autoUpdateEnabled: drift.Value(settings.autoUpdateEnabled),
          syncIntervalMinutes: drift.Value(settings.syncIntervalMinutes),
          updatedAt: drift.Value(DateTime.now()),
        ),
      );
    } else {
      await _database.updateSettings(
        SettingsTableCompanion(
          id: drift.Value(settings.id),
          isDarkMode: drift.Value(settings.isDarkMode),
          languageCode: drift.Value(settings.languageCode),
          notificationsEnabled: drift.Value(settings.notificationsEnabled),
          backgroundMonitoringEnabled:
              drift.Value(settings.backgroundMonitoringEnabled),
          autoUpdateEnabled: drift.Value(settings.autoUpdateEnabled),
          syncIntervalMinutes: drift.Value(settings.syncIntervalMinutes),
          updatedAt: drift.Value(DateTime.now()),
        ),
      );
    }
  }

  SettingsDTO _mapToDTO(SettingsTableData settings) {
    return SettingsDTO(
      id: settings.id,
      isDarkMode: settings.isDarkMode,
      languageCode: settings.languageCode,
      notificationsEnabled: settings.notificationsEnabled,
      backgroundMonitoringEnabled: settings.backgroundMonitoringEnabled,
      autoUpdateEnabled: settings.autoUpdateEnabled,
      syncIntervalMinutes: settings.syncIntervalMinutes,
      updatedAt: settings.updatedAt,
    );
  }
}
