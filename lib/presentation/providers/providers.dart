import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/local/database/app_database.dart';
import '../../data/repositories/job_repository.dart';
import '../../data/repositories/keyword_repository.dart';
import '../../data/repositories/telegram_group_repository.dart';
import '../../data/repositories/favorite_repository.dart';
import '../../data/repositories/notification_repository.dart';
import '../../data/repositories/settings_repository.dart';
import '../../data/repositories/log_repository.dart';
import '../../domain/services/telegram_service.dart';
import '../../domain/services/background_job_service.dart';
import '../../domain/services/notification_service.dart';
import '../../domain/services/job_classifier.dart';

// Database
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

// Repositories
final jobRepositoryProvider = Provider<JobRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return JobRepository(db);
});

final keywordRepositoryProvider = Provider<KeywordRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return KeywordRepository(db);
});

final telegramGroupRepositoryProvider =
    Provider<TelegramGroupRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return TelegramGroupRepository(db);
});

final favoriteRepositoryProvider = Provider<FavoriteRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return FavoriteRepository(db);
});

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return NotificationRepository(db);
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return SettingsRepository(db);
});

final logRepositoryProvider = Provider<LogRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return LogRepository(db);
});

// Services
final telegramServiceProvider = Provider<TelegramService>((ref) {
  final logRepo = ref.watch(logRepositoryProvider);
  return TelegramService(logRepo);
});

final backgroundJobServiceProvider = Provider<BackgroundJobService>((ref) {
  final logRepo = ref.watch(logRepositoryProvider);
  return BackgroundJobService(logRepo);
});

final notificationServiceProvider = Provider<NotificationService>((ref) {
  final logRepo = ref.watch(logRepositoryProvider);
  return NotificationService(logRepo);
});

final jobClassifierProvider = FutureProvider<JobClassifier>((ref) async {
  final keywordRepo = ref.watch(keywordRepositoryProvider);
  final keywords = await keywordRepo.getKeywordStrings();
  return JobClassifier(keywords);
});
