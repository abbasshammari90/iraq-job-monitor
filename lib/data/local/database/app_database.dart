import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'entities/job_entity.dart';
import 'entities/keyword_entity.dart';
import 'entities/telegram_group_entity.dart';
import 'entities/favorite_entity.dart';
import 'entities/notification_entity.dart';
import 'entities/settings_entity.dart';
import 'entities/log_entity.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    JobEntity,
    KeywordEntity,
    TelegramGroupEntity,
    FavoriteEntity,
    NotificationEntity,
    SettingsEntity,
    LogEntity,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'iraq_job_monitor');
  }

  Future<void> insertOrUpdateJob(JobEntityCompanion job) async {
    await into(jobEntity).insertOnConflictUpdate(job);
  }

  Future<void> insertOrUpdateJobs(List<JobEntityCompanion> jobs) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(jobEntity, jobs);
    });
  }

  Future<List<JobEntity>> getAllJobs() => select(jobEntity).get();

  Future<List<JobEntity>> getJobsByClassification(String classification) {
    return (select(jobEntity)
          ..where((tbl) => tbl.classification.equals(classification)))
        .get();
  }

  Future<List<JobEntity>> searchJobs(String query) {
    return (select(jobEntity)
          ..where((tbl) =>
              tbl.company.like('%$query%') |
              tbl.title.like('%$query%') |
              tbl.location.like('%$query%')))
        .get();
  }

  Future<void> insertKeyword(KeywordEntityCompanion keyword) async {
    await into(keywordEntity).insert(keyword);
  }

  Future<List<KeywordEntity>> getAllKeywords() => select(keywordEntity).get();

  Future<void> deleteKeyword(String id) async {
    await (delete(keywordEntity)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> insertTelegramGroup(
      TelegramGroupEntityCompanion group) async {
    await into(telegramGroupEntity).insertOnConflictUpdate(group);
  }

  Future<List<TelegramGroupEntity>> getAllTelegramGroups() =>
      select(telegramGroupEntity).get();

  Future<void> addToFavorites(FavoriteEntityCompanion favorite) async {
    await into(favoriteEntity).insert(favorite);
  }

  Future<void> removeFromFavorites(String jobId) async {
    await (delete(favoriteEntity)..where((tbl) => tbl.jobId.equals(jobId)))
        .go();
  }

  Future<List<FavoriteEntity>> getAllFavorites() =>
      select(favoriteEntity).get();

  Future<void> insertNotification(
      NotificationEntityCompanion notification) async {
    await into(notificationEntity).insert(notification);
  }

  Future<List<NotificationEntity>> getUnreadNotifications() {
    return (select(notificationEntity)
          ..where((tbl) => tbl.isRead.equals(false)))
        .get();
  }

  Future<void> markNotificationAsRead(String id) async {
    await (update(notificationEntity)..where((tbl) => tbl.id.equals(id)))
        .write(const NotificationEntityCompanion(isRead: Value(true)));
  }

  Future<void> insertLog(LogEntityCompanion log) async {
    await into(logEntity).insert(log);
  }

  Future<List<LogEntity>> getRecentLogs(int limit) {
    return (select(logEntity)
          ..orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)])
          ..limit(limit))
        .get();
  }
}
