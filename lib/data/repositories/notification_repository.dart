import '../../models/notification_dto.dart';
import '../database/app_database.dart';
import 'package:drift/drift.dart' as drift;
import 'dart:convert';

class NotificationRepository {
  final AppDatabase _database;

  NotificationRepository(this._database);

  Future<List<NotificationDTO>> getAllNotifications() async {
    final notifications = await _database.getAllNotifications();
    return notifications.map(_mapToDTO).toList();
  }

  Future<List<NotificationDTO>> getUnreadNotifications() async {
    final notifications = await _database.getUnreadNotifications();
    return notifications.map(_mapToDTO).toList();
  }

  Future<void> createNotification(NotificationDTO notification) async {
    await _database.insertNotification(
      NotificationsTableCompanion(
        id: drift.Value(notification.id),
        title: drift.Value(notification.title),
        message: drift.Value(notification.message),
        type: drift.Value(notification.type),
        isRead: drift.Value(notification.isRead),
        createdAt: drift.Value(notification.createdAt),
        jobId: drift.Value(notification.jobId),
        metadata: notification.metadata != null
            ? drift.Value(jsonEncode(notification.metadata))
            : const drift.Value(null),
      ),
    );
  }

  Future<void> markAsRead(String id) =>
      _database.markNotificationAsRead(id);

  Future<void> clearAll() => _database.clearAllNotifications();

  NotificationDTO _mapToDTO(NotificationsTableData notification) {
    final metadata = notification.metadata != null
        ? jsonDecode(notification.metadata!) as Map<String, dynamic>?
        : null;

    return NotificationDTO(
      id: notification.id,
      title: notification.title,
      message: notification.message,
      type: notification.type,
      isRead: notification.isRead,
      createdAt: notification.createdAt,
      jobId: notification.jobId,
      metadata: metadata,
    );
  }
}
