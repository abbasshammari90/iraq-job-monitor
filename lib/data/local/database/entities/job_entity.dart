import 'package:drift/drift.dart';

class JobEntity extends Table {
  TextColumn get id => text()();
  TextColumn get company => text()();
  TextColumn get title => text()();
  TextColumn get location => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get source => text()();
  TextColumn get message => text()();
  RealColumn get importanceScore => real()();
  TextColumn get classification => text()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(Constant(DateTime.now()))();

  @override
  Set<Column> get primaryKey => {id};
}
