import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'presentation/app.dart';
import 'data/local/database/app_database.dart';

final logger = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize database
  try {
    final database = AppDatabase();
    logger.i('Database initialized successfully');
  } catch (e, stackTrace) {
    logger.e('Failed to initialize database', error: e, stackTrace: stackTrace);
  }

  runApp(
    const ProviderScope(
      child: IraqJobMonitorApp(),
    ),
  );
}
