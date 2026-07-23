import '../../local/database/app_database.dart';

class NotificationRepository {
  final AppDatabase _database;

  NotificationRepository(this._database);

  Future<void> createNotification({
    required String jobId,
    required String title,
    required String company,
    required String source,
  }) async {
    await _database.insertNotification(
      NotificationEntityCompanion.insert(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        jobId: jobId,
        title: title,
        company: company,
        source: source,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<List<NotificationEntity>> getUnreadNotifications() =>
      _database.getUnreadNotifications();

  Future<void> markAsRead(String id) =>
      _database.markNotificationAsRead(id);
}
