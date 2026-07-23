import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/notification_repository.dart';
import '../../data/models/notification_dto.dart';
import '../../data/local/database/app_database.dart';

final notificationRepositoryProvider = Provider((ref) {
  final database = ref.watch(databaseProvider);
  return NotificationRepository(database);
});

final notificationsProvider = FutureProvider((ref) async {
  final repo = ref.watch(notificationRepositoryProvider);
  return repo.getAllNotifications();
});

final unreadNotificationsProvider = FutureProvider((ref) async {
  final repo = ref.watch(notificationRepositoryProvider);
  return repo.getUnreadNotifications();
});

final unreadCountProvider = FutureProvider((ref) async {
  final unread = await ref.watch(unreadNotificationsProvider.future);
  return unread.length;
});

final markNotificationReadProvider = FutureProvider.family<void, String>((ref, notificationId) async {
  final repo = ref.watch(notificationRepositoryProvider);
  await repo.markAsRead(notificationId);
  ref.invalidate(notificationsProvider);
  ref.invalidate(unreadNotificationsProvider);
  ref.invalidate(unreadCountProvider);
});

final clearNotificationsProvider = FutureProvider((ref) async {
  final repo = ref.watch(notificationRepositoryProvider);
  await repo.clearAll();
  ref.invalidate(notificationsProvider);
  ref.invalidate(unreadNotificationsProvider);
});

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
