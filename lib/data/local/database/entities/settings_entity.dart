import 'package:drift/drift.dart';

class SettingsEntity extends Table {
  TextColumn get id => text()();
  BoolColumn get isDarkMode => boolean().withDefault(const Constant(false))();
  TextColumn get languageCode => text().withDefault(const Constant('en'))();
  BoolColumn get notificationsEnabled =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get backgroundMonitoringEnabled =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get autoUpdateEnabled =>
      boolean().withDefault(const Constant(true))();
  IntColumn get syncIntervalMinutes =>
      integer().withDefault(const Constant(15))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(Constant(DateTime.now()))();

  @override
  Set<Column> get primaryKey => {id};
}
