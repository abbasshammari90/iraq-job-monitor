import '../local/database/app_database.dart';

class SettingsDTO {
  final bool isDarkMode;
  final String languageCode;
  final bool notificationsEnabled;
  final bool backgroundMonitoringEnabled;
  final bool autoUpdateEnabled;
  final int syncIntervalMinutes;

  const SettingsDTO({
    required this.isDarkMode,
    required this.languageCode,
    required this.notificationsEnabled,
    required this.backgroundMonitoringEnabled,
    required this.autoUpdateEnabled,
    required this.syncIntervalMinutes,
  });

  factory SettingsDTO.fromEntity(SettingsEntity entity) {
    return SettingsDTO(
      isDarkMode: entity.isDarkMode,
      languageCode: entity.languageCode,
      notificationsEnabled: entity.notificationsEnabled,
      backgroundMonitoringEnabled: entity.backgroundMonitoringEnabled,
      autoUpdateEnabled: entity.autoUpdateEnabled,
      syncIntervalMinutes: entity.syncIntervalMinutes,
    );
  }

  SettingsDTO copyWith({
    bool? isDarkMode,
    String? languageCode,
    bool? notificationsEnabled,
    bool? backgroundMonitoringEnabled,
    bool? autoUpdateEnabled,
    int? syncIntervalMinutes,
  }) {
    return SettingsDTO(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      languageCode: languageCode ?? this.languageCode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      backgroundMonitoringEnabled:
          backgroundMonitoringEnabled ?? this.backgroundMonitoringEnabled,
      autoUpdateEnabled: autoUpdateEnabled ?? this.autoUpdateEnabled,
      syncIntervalMinutes: syncIntervalMinutes ?? this.syncIntervalMinutes,
    );
  }
}
