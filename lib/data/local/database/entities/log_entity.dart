import 'package:drift/drift.dart';

class LogEntity extends Table {
  TextColumn get id => text()();
  TextColumn get level => text()();
  TextColumn get message => text()();
  TextColumn get stackTrace => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
