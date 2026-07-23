import 'package:drift/drift.dart';

class KeywordsTable extends Table {
  TextColumn get id => text()();
  TextColumn get keyword => text().unique()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
