import 'package:flutter_riverpod/flutter_riverpod.dart';

// Telegram authentication state
final telegramAuthProvider = StateProvider<TelegramAuthState>((ref) {
  return TelegramAuthState.initial();
});

final telegramLoginProvider = FutureProvider.family<bool, String>((ref, phoneNumber) async {
  // TODO: Implement actual Telegram TDLib login
  // This will be implemented when TDLib wrapper is created
  await Future.delayed(const Duration(seconds: 2));
  return true;
});

final verifyCodeProvider = FutureProvider.family<bool, String>((ref, code) async {
  // TODO: Implement actual code verification
  await Future.delayed(const Duration(seconds: 1));
  return true;
});

final verifyPasswordProvider = FutureProvider.family<bool, String>((ref, password) async {
  // TODO: Implement actual password verification
  await Future.delayed(const Duration(seconds: 1));
  return true;
});

class TelegramAuthState {
  final bool isAuthenticated;
  final String? phoneNumber;
  final String? error;
  final bool isLoading;

  TelegramAuthState({
    required this.isAuthenticated,
    this.phoneNumber,
    this.error,
    required this.isLoading,
  });

  factory TelegramAuthState.initial() {
    return TelegramAuthState(
      isAuthenticated: false,
      isLoading: false,
    );
  }

  TelegramAuthState copyWith({
    bool? isAuthenticated,
    String? phoneNumber,
    String? error,
    bool? isLoading,
  }) {
    return TelegramAuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
