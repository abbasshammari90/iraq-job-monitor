import 'package:drift/drift.dart';

class KeywordEntity extends Table {
  TextColumn get id => text()();
  TextColumn get keyword => text().unique()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
