import '../../local/database/app_database.dart';

class LogRepository {
  final AppDatabase _database;

  LogRepository(this._database);

  Future<void> log(String level, String message, [String? stackTrace]) async {
    await _database.insertLog(
      LogEntityCompanion.insert(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        level: level,
        message: message,
        stackTrace: stackTrace,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<List<LogEntity>> getRecentLogs(int limit) =>
      _database.getRecentLogs(limit);
}
