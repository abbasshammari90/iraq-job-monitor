import '../local/database/app_database.dart';

class TelegramGroupDTO {
  final String id;
  final String groupId;
  final String name;
  final bool isChannel;
  final DateTime addedAt;
  final bool isActive;

  TelegramGroupDTO({
    required this.id,
    required this.groupId,
    required this.name,
    required this.isChannel,
    required this.addedAt,
    required this.isActive,
  });

  factory TelegramGroupDTO.fromEntity(TelegramGroupEntity entity) {
    return TelegramGroupDTO(
      id: entity.id,
      groupId: entity.groupId,
      name: entity.name,
      isChannel: entity.isChannel,
      addedAt: entity.addedAt,
      isActive: entity.isActive,
    );
  }
}
