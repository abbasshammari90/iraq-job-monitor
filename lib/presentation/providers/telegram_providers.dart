import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers.dart';

final isTelegramConnectedProvider = StateProvider<bool>((ref) => false);

final isMonitoringProvider = StateProvider<bool>((ref) => false);

final lastSyncProvider = StateProvider<DateTime?>((ref) => null);

final telegramLoginProvider = FutureProvider.family<bool, String>((ref, phoneNumber) async {
  final telegramService = ref.watch(telegramServiceProvider);
  final result = await telegramService.login(phoneNumber);
  if (result) {
    ref.read(isTelegramConnectedProvider.notifier).state = true;
  }
  return result;
});

final telegramLogoutProvider = FutureProvider<bool>((ref) async {
  final telegramService = ref.watch(telegramServiceProvider);
  await telegramService.logout();
  ref.read(isTelegramConnectedProvider.notifier).state = false;
  ref.read(isMonitoringProvider.notifier).state = false;
  return true;
});

final startMonitoringProvider = FutureProvider.family<bool, List<int>>((ref, chatIds) async {
  final telegramService = ref.watch(telegramServiceProvider);
  final result = await telegramService.startMonitoring(chatIds);
  if (result) {
    ref.read(isMonitoringProvider.notifier).state = true;
    ref.read(lastSyncProvider.notifier).state = DateTime.now();
  }
  return result;
});

final stopMonitoringProvider = FutureProvider<bool>((ref) async {
  final telegramService = ref.watch(telegramServiceProvider);
  final result = await telegramService.stopMonitoring();
  if (result) {
    ref.read(isMonitoringProvider.notifier).state = false;
  }
  return result;
});
