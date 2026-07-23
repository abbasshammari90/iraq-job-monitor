class SettingsDTO {
  final String id;
  final bool isDarkMode;
  final String languageCode;
  final bool notificationsEnabled;
  final bool backgroundMonitoringEnabled;
  final bool autoUpdateEnabled;
  final int syncIntervalMinutes;
  final DateTime updatedAt;

  SettingsDTO({
    required this.id,
    required this.isDarkMode,
    required this.languageCode,
    required this.notificationsEnabled,
    required this.backgroundMonitoringEnabled,
    required this.autoUpdateEnabled,
    required this.syncIntervalMinutes,
    required this.updatedAt,
  });

  SettingsDTO copyWith({
    String? id,
    bool? isDarkMode,
    String? languageCode,
    bool? notificationsEnabled,
    bool? backgroundMonitoringEnabled,
    bool? autoUpdateEnabled,
    int? syncIntervalMinutes,
    DateTime? updatedAt,
  }) {
    return SettingsDTO(
      id: id ?? this.id,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      languageCode: languageCode ?? this.languageCode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      backgroundMonitoringEnabled:
          backgroundMonitoringEnabled ?? this.backgroundMonitoringEnabled,
      autoUpdateEnabled: autoUpdateEnabled ?? this.autoUpdateEnabled,
      syncIntervalMinutes: syncIntervalMinutes ?? this.syncIntervalMinutes,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isDarkMode': isDarkMode,
      'languageCode': languageCode,
      'notificationsEnabled': notificationsEnabled,
      'backgroundMonitoringEnabled': backgroundMonitoringEnabled,
      'autoUpdateEnabled': autoUpdateEnabled,
      'syncIntervalMinutes': syncIntervalMinutes,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory SettingsDTO.fromJson(Map<String, dynamic> json) {
    return SettingsDTO(
      id: json['id'] ?? '',
      isDarkMode: json['isDarkMode'] ?? false,
      languageCode: json['languageCode'] ?? 'en',
      notificationsEnabled: json['notificationsEnabled'] ?? true,
      backgroundMonitoringEnabled: json['backgroundMonitoringEnabled'] ?? true,
      autoUpdateEnabled: json['autoUpdateEnabled'] ?? true,
      syncIntervalMinutes: json['syncIntervalMinutes'] ?? 15,
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}
