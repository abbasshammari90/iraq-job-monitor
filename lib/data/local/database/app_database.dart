import 'package:drift/drift.dart';
import '../tables/jobs_table.dart';
import '../tables/keywords_table.dart';
import '../tables/notifications_table.dart';
import '../tables/telegram_groups_table.dart';
import '../tables/settings_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  JobsTable,
  KeywordsTable,
  NotificationsTable,
  TelegramGroupsTable,
  SettingsTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Jobs queries
  Future<List<JobsTableData>> getAllJobs() => select(jobsTable).get();

  Future<List<JobsTableData>> getJobsByClassification(String classification) {
    return (select(jobsTable)..where((t) => t.classification.equals(classification)))
        .get();
  }

  Future<List<JobsTableData>> getFavoriteJobs() {
    return (select(jobsTable)..where((t) => t.isFavorite.equals(true))).get();
  }

  Future<List<JobsTableData>> getRecentJobs(int days) {
    final date = DateTime.now().subtract(Duration(days: days));
    return (select(jobsTable)..where((t) => t.date.isBiggerOrEqualValue(date)))
        .get();
  }

  Future<void> insertJob(JobsTableCompanion job) => into(jobsTable).insert(job);

  Future<void> updateJob(JobsTableCompanion job) =>
      update(jobsTable).replace(job);

  Future<void> deleteJob(String id) =>
      (delete(jobsTable)..where((t) => t.id.equals(id))).go();

  Future<void> toggleFavorite(String id, bool favorite) async {
    await (update(jobsTable)..where((t) => t.id.equals(id)))
        .write(JobsTableCompanion(isFavorite: Value(favorite)));
  }

  // Keywords queries
  Future<List<KeywordsTableData>> getAllKeywords() => select(keywordsTable).get();

  Future<List<KeywordsTableData>> getDefaultKeywords() {
    return (select(keywordsTable)..where((t) => t.isDefault.equals(true)))
        .get();
  }

  Future<void> insertKeyword(KeywordsTableCompanion keyword) =>
      into(keywordsTable).insert(keyword);

  Future<void> deleteKeyword(String id) =>
      (delete(keywordsTable)..where((t) => t.id.equals(id))).go();

  // Notifications queries
  Future<List<NotificationsTableData>> getAllNotifications() =>
      select(notificationsTable).get();

  Future<List<NotificationsTableData>> getUnreadNotifications() {
    return (select(notificationsTable)..where((t) => t.isRead.equals(false)))
        .get();
  }

  Future<void> insertNotification(NotificationsTableCompanion notification) =>
      into(notificationsTable).insert(notification);

  Future<void> markNotificationAsRead(String id) {
    return (update(notificationsTable)..where((t) => t.id.equals(id)))
        .write(const NotificationsTableCompanion(isRead: Value(true)));
  }

  Future<void> clearAllNotifications() => delete(notificationsTable).go();

  // Telegram groups queries
  Future<List<TelegramGroupsTableData>> getAllGroups() =>
      select(telegramGroupsTable).get();

  Future<List<TelegramGroupsTableData>> getActiveGroups() {
    return (select(telegramGroupsTable)..where((t) => t.isActive.equals(true)))
        .get();
  }

  Future<void> insertGroup(TelegramGroupsTableCompanion group) =>
      into(telegramGroupsTable).insert(group);

  Future<void> updateGroup(TelegramGroupsTableCompanion group) =>
      update(telegramGroupsTable).replace(group);

  Future<void> deleteGroup(String id) =>
      (delete(telegramGroupsTable)..where((t) => t.id.equals(id))).go();

  // Settings queries
  Future<SettingsTableData?> getSettings() async {
    final result = await select(settingsTable).get();
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> insertSettings(SettingsTableCompanion settings) =>
      into(settingsTable).insert(settings);

  Future<void> updateSettings(SettingsTableCompanion settings) =>
      update(settingsTable).replace(settings);
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await _getDatabasePath();
    final file = File('$dbFolder/iraq_job_monitor.db');
    return NativeDatabase(file);
  });
}

Future<String> _getDatabasePath() async {
  // This will be implemented based on platform
  throw UnimplementedError();
}

import 'dart:io';
import 'package:drift/native.dart';
