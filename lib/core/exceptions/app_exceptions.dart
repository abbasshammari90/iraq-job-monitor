class AppExceptions implements Exception {
  final String message;
  final String? code;
  final dynamic originalException;

  AppExceptions({
    required this.message,
    this.code,
    this.originalException,
  });

  @override
  String toString() => message;
}

class DatabaseException extends AppExceptions {
  DatabaseException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
    message: message,
    code: code,
    originalException: originalException,
  );
}

class TelegramException extends AppExceptions {
  TelegramException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
    message: message,
    code: code,
    originalException: originalException,
  );
}

class ClassificationException extends AppExceptions {
  ClassificationException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
    message: message,
    code: code,
    originalException: originalException,
  );
}

class NetworkException extends AppExceptions {
  NetworkException({
    required String message,
    String? code,
    dynamic originalException,
  }) : super(
    message: message,
    code: code,
    originalException: originalException,
  );
}
