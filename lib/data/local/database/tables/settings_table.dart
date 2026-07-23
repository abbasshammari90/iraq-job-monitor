import 'package:drift/drift.dart';

class SettingsTable extends Table {
  TextColumn get id => text()();
  BoolColumn get isDarkMode => boolean().withDefault(const Constant(false))();
  TextColumn get languageCode => text().withDefault(const Constant('en'))();
  BoolColumn get notificationsEnabled => boolean().withDefault(const Constant(true))();
  BoolColumn get backgroundMonitoringEnabled => boolean().withDefault(const Constant(true))();
  BoolColumn get autoUpdateEnabled => boolean().withDefault(const Constant(true))();
  IntColumn get syncIntervalMinutes => integer().withDefault(const Constant(15))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
