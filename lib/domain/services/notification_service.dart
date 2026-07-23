import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../data/repositories/log_repository.dart';
import '../../core/constants/app_constants.dart';

class NotificationService {
  late FlutterLocalNotificationsPlugin _localNotifications;
  final LogRepository _logRepository;

  NotificationService(this._logRepository);

  Future<void> initialize() async {
    try {
      _localNotifications = FlutterLocalNotificationsPlugin();

      const androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosSettings = DarwinInitializationSettings();

      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await _localNotifications.initialize(initSettings);
      await _logRepository.log('INFO', 'Notifications initialized');
    } catch (e, stackTrace) {
      await _logRepository.log(
          'ERROR', 'Failed to initialize notifications', stackTrace.toString());
    }
  }

  Future<void> showJobNotification({
    required String jobTitle,
    required String company,
    required String source,
  }) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'job_notifications',
        'Job Notifications',
        channelDescription: 'Notifications for new job opportunities',
        importance: Importance.max,
        priority: Priority.high,
      );

      const iosDetails = DarwinNotificationDetails();

      const notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _localNotifications.show(
        AppConstants.newJobNotificationId,
        jobTitle,
        'From $company via $source',
        notificationDetails,
      );

      await _logRepository.log('INFO',
          'Job notification shown: $jobTitle from $company');
    } catch (e, stackTrace) {
      await _logRepository.log('ERROR', 'Failed to show notification',
          stackTrace.toString());
    }
  }

  Future<void> showSyncStatusNotification(
      {required String status, required String message}) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'sync_notifications',
        'Sync Notifications',
        channelDescription: 'Notifications for sync status',
        importance: Importance.low,
        priority: Priority.low,
      );

      const iosDetails = DarwinNotificationDetails();

      const notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _localNotifications.show(
        AppConstants.syncStatusNotificationId,
        status,
        message,
        notificationDetails,
      );

      await _logRepository.log('INFO', 'Sync notification shown: $status');
    } catch (e, stackTrace) {
      await _logRepository.log('ERROR', 'Failed to show sync notification',
          stackTrace.toString());
    }
  }
}
