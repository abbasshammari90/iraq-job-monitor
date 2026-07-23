import '../../models/telegram_group_dto.dart';
import '../database/app_database.dart';
import 'package:drift/drift.dart' as drift;

class TelegramGroupRepository {
  final AppDatabase _database;

  TelegramGroupRepository(this._database);

  Future<List<TelegramGroupDTO>> getAllGroups() async {
    final groups = await _database.getAllGroups();
    return groups.map(_mapToDTO).toList();
  }

  Future<List<TelegramGroupDTO>> getActiveGroups() async {
    final groups = await _database.getActiveGroups();
    return groups.map(_mapToDTO).toList();
  }

  Future<void> addGroup(TelegramGroupDTO group) async {
    await _database.insertGroup(
      TelegramGroupsTableCompanion(
        id: drift.Value(group.id),
        name: drift.Value(group.name),
        username: drift.Value(group.username),
        isChannel: drift.Value(group.isChannel),
        isActive: drift.Value(group.isActive),
        addedAt: drift.Value(group.addedAt),
        memberCount: drift.Value(group.memberCount),
      ),
    );
  }

  Future<void> updateGroup(TelegramGroupDTO group) async {
    await _database.updateGroup(
      TelegramGroupsTableCompanion(
        id: drift.Value(group.id),
        name: drift.Value(group.name),
        username: drift.Value(group.username),
        isChannel: drift.Value(group.isChannel),
        isActive: drift.Value(group.isActive),
        addedAt: drift.Value(group.addedAt),
        memberCount: drift.Value(group.memberCount),
      ),
    );
  }

  Future<void> deleteGroup(String id) => _database.deleteGroup(id);

  TelegramGroupDTO _mapToDTO(TelegramGroupsTableData group) {
    return TelegramGroupDTO(
      id: group.id,
      name: group.name,
      username: group.username,
      isChannel: group.isChannel,
      isActive: group.isActive,
      addedAt: group.addedAt,
      memberCount: group.memberCount,
    );
  }
}
