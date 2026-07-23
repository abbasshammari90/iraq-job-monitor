import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_model.freezed.dart';
part 'settings_model.g.dart';

@freezed
class SettingsModel with _$SettingsModel {
  const factory SettingsModel({
    required bool isDarkMode,
    required String languageCode,
    required bool notificationsEnabled,
    required bool backgroundMonitoringEnabled,
    required bool autoUpdateEnabled,
    required int syncIntervalMinutes,
  }) = _SettingsModel;

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);
}
