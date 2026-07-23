import 'package:drift/drift.dart';

class NotificationsTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get message => text()();
  TextColumn get type => text().withDefault(const Constant('status'))();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get jobId => text().nullable()();
  TextColumn get metadata => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
