import 'package:drift/drift.dart';

class NotificationEntity extends Table {
  TextColumn get id => text()();
  TextColumn get jobId => text()();
  TextColumn get title => text()();
  TextColumn get company => text()();
  TextColumn get source => text()();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
