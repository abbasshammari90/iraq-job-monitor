import 'package:drift/drift.dart';

class JobsTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get company => text()();
  TextColumn get location => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get description => text()();
  TextColumn get classification => text().withDefault(const Constant('Ignore'))();
  RealColumn get importanceScore => real().withDefault(const Constant(0.0))();
  TextColumn get source => text()();
  TextColumn get matchedKeywords => text().withDefault(const Constant('[]'))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  BoolColumn get isSeen => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
