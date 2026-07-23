import 'package:workmanager/workmanager.dart';
import '../../data/repositories/log_repository.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      switch (task) {
        case 'telegram_sync':
          return await _syncTelegram();
        case 'notification_check':
          return await _checkNotifications();
        default:
          return false;
      }
    } catch (e) {
      return false;
    }
  });
}

Future<bool> _syncTelegram() async {
  return true;
}

Future<bool> _checkNotifications() async {
  return true;
}

class BackgroundJobService {
  final LogRepository _logRepository;

  BackgroundJobService(this._logRepository);

  Future<void> initializeBackgroundTasks() async {
    try {
      await Workmanager().initialize(
        callbackDispatcher,
        isInDebugMode: false,
      );
      await _logRepository.log('INFO', 'Background tasks initialized');
    } catch (e, stackTrace) {
      await _logRepository.log('ERROR', 'Failed to initialize background tasks', stackTrace.toString());
    }
  }

  Future<void> scheduleTelegramSync(int intervalMinutes) async {
    try {
      await Workmanager().registerPeriodicTask(
        'telegram_sync_${DateTime.now().millisecondsSinceEpoch}',
        'telegram_sync',
        frequency: Duration(minutes: intervalMinutes),
        backoffPolicy: BackoffPolicy.exponential,
      );
      await _logRepository.log('INFO', 'Telegram sync scheduled every $intervalMinutes minutes');
    } catch (e, stackTrace) {
      await _logRepository.log('ERROR', 'Failed to schedule Telegram sync', stackTrace.toString());
    }
  }

  Future<void> scheduleNotificationCheck(int intervalMinutes) async {
    try {
      await Workmanager().registerPeriodicTask(
        'notification_check_${DateTime.now().millisecondsSinceEpoch}',
        'notification_check',
        frequency: Duration(minutes: intervalMinutes),
        backoffPolicy: BackoffPolicy.exponential,
      );
      await _logRepository.log('INFO', 'Notification check scheduled every $intervalMinutes minutes');
    } catch (e, stackTrace) {
      await _logRepository.log('ERROR', 'Failed to schedule notification check', stackTrace.toString());
    }
  }

  Future<void> cancelAllTasks() async {
    try {
      await Workmanager().cancelAll();
      await _logRepository.log('INFO', 'All background tasks cancelled');
    } catch (e, stackTrace) {
      await _logRepository.log('ERROR', 'Failed to cancel background tasks', stackTrace.toString());
    }
  }
}
