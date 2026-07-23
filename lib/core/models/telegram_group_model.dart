import 'package:freezed_annotation/freezed_annotation.dart';

part 'telegram_group_model.freezed.dart';
part 'telegram_group_model.g.dart';

@freezed
class TelegramGroupModel with _$TelegramGroupModel {
  const factory TelegramGroupModel({
    required String id,
    required String groupId,
    required String name,
    required bool isChannel,
    required DateTime addedAt,
    required bool isActive,
  }) = _TelegramGroupModel;

  factory TelegramGroupModel.fromJson(Map<String, dynamic> json) =>
      _$TelegramGroupModelFromJson(json);
}
