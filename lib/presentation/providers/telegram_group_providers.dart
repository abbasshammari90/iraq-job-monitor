import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/telegram_group_repository.dart';
import '../../data/models/telegram_group_dto.dart';
import '../../data/local/database/app_database.dart';

final telegramGroupRepositoryProvider = Provider((ref) {
  final database = ref.watch(databaseProvider);
  return TelegramGroupRepository(database);
});

final telegramGroupsProvider = FutureProvider((ref) async {
  final repo = ref.watch(telegramGroupRepositoryProvider);
  return repo.getAllGroups();
});

final activeGroupsProvider = FutureProvider((ref) async {
  final repo = ref.watch(telegramGroupRepositoryProvider);
  return repo.getActiveGroups();
});

final addGroupProvider = FutureProvider.family<void, TelegramGroupDTO>((ref, group) async {
  final repo = ref.watch(telegramGroupRepositoryProvider);
  await repo.addGroup(group);
  ref.invalidate(telegramGroupsProvider);
  ref.invalidate(activeGroupsProvider);
});

final removeGroupProvider = FutureProvider.family<void, String>((ref, groupId) async {
  final repo = ref.watch(telegramGroupRepositoryProvider);
  await repo.deleteGroup(groupId);
  ref.invalidate(telegramGroupsProvider);
  ref.invalidate(activeGroupsProvider);
});

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
