import '../../local/database/app_database.dart';
import '../../models/telegram_group_dto.dart';

class TelegramGroupRepository {
  final AppDatabase _database;

  TelegramGroupRepository(this._database);

  Future<void> addGroup(TelegramGroupDTO group) async {
    await _database.insertTelegramGroup(
      TelegramGroupEntityCompanion.insert(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        groupId: group.groupId,
        name: group.name,
        isChannel: group.isChannel,
        addedAt: DateTime.now(),
      ),
    );
  }

  Future<List<TelegramGroupDTO>> getAllGroups() async {
    final entities = await _database.getAllTelegramGroups();
    return entities.map((e) => TelegramGroupDTO.fromEntity(e)).toList();
  }

  Future<List<TelegramGroupDTO>> getActiveGroups() async {
    final all = await getAllGroups();
    return all.where((g) => g.isActive).toList();
  }

  Future<int> getGroupCount() async {
    final groups = await getAllGroups();
    return groups.length;
  }
}
