import 'package:drift/drift.dart';

class TelegramGroupsTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get username => text().unique()();
  BoolColumn get isChannel => boolean().withDefault(const Constant(false))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get addedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get memberCount => integer().nullable()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
