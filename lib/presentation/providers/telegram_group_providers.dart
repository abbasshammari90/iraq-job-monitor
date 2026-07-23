import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/telegram_group_dto.dart';
import 'providers.dart';

final telegramGroupsProvider = FutureProvider<List<TelegramGroupDTO>>((ref) async {
  final groupRepo = ref.watch(telegramGroupRepositoryProvider);
  return groupRepo.getAllGroups();
});

final activeGroupsProvider = FutureProvider<List<TelegramGroupDTO>>((ref) async {
  final groupRepo = ref.watch(telegramGroupRepositoryProvider);
  return groupRepo.getActiveGroups();
});

final groupCountProvider = FutureProvider<int>((ref) async {
  final groupRepo = ref.watch(telegramGroupRepositoryProvider);
  return groupRepo.getGroupCount();
});
