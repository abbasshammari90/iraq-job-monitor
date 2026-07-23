import 'telegram_models.dart';
import '../../data/repositories/log_repository.dart';

class TelegramService {
  final LogRepository _logRepository;
  bool _isConnected = false;
  bool _isMonitoring = false;

  TelegramService(this._logRepository);

  bool get isConnected => _isConnected;
  bool get isMonitoring => _isMonitoring;

  Future<bool> initialize() async {
    try {
      await _logRepository.log('INFO', 'Initializing Telegram service');
      _isConnected = true;
      return true;
    } catch (e, stackTrace) {
      await _logRepository.log('ERROR', 'Failed to initialize Telegram', stackTrace.toString());
      return false;
    }
  }

  Future<bool> login(String phoneNumber) async {
    try {
      await _logRepository.log('INFO', 'Logging in with phone: $phoneNumber');
      _isConnected = true;
      return true;
    } catch (e, stackTrace) {
      await _logRepository.log('ERROR', 'Login failed', stackTrace.toString());
      return false;
    }
  }

  Future<bool> verifyCode(String code) async {
    try {
      await _logRepository.log('INFO', 'Verifying code');
      return true;
    } catch (e, stackTrace) {
      await _logRepository.log('ERROR', 'Code verification failed', stackTrace.toString());
      return false;
    }
  }

  Future<bool> verifyPassword(String password) async {
    try {
      await _logRepository.log('INFO', 'Verifying password');
      return true;
    } catch (e, stackTrace) {
      await _logRepository.log('ERROR', 'Password verification failed', stackTrace.toString());
      return false;
    }
  }

  Future<List<TelegramChat>> getChats() async {
    try {
      await _logRepository.log('INFO', 'Fetching chats');
      return [];
    } catch (e, stackTrace) {
      await _logRepository.log('ERROR', 'Failed to fetch chats', stackTrace.toString());
      return [];
    }
  }

  Future<bool> startMonitoring(List<int> chatIds) async {
    try {
      await _logRepository.log('INFO', 'Starting monitoring for ${chatIds.length} chats');
      _isMonitoring = true;
      return true;
    } catch (e, stackTrace) {
      await _logRepository.log('ERROR', 'Failed to start monitoring', stackTrace.toString());
      return false;
    }
  }

  Future<bool> stopMonitoring() async {
    try {
      await _logRepository.log('INFO', 'Stopping monitoring');
      _isMonitoring = false;
      return true;
    } catch (e, stackTrace) {
      await _logRepository.log('ERROR', 'Failed to stop monitoring', stackTrace.toString());
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _logRepository.log('INFO', 'Logging out');
      _isConnected = false;
      _isMonitoring = false;
    } catch (e, stackTrace) {
      await _logRepository.log('ERROR', 'Logout failed', stackTrace.toString());
    }
  }

  Future<bool> reconnect() async {
    try {
      await _logRepository.log('INFO', 'Attempting to reconnect');
      _isConnected = true;
      return true;
    } catch (e, stackTrace) {
      await _logRepository.log('ERROR', 'Reconnection failed', stackTrace.toString());
      return false;
    }
  }
}
