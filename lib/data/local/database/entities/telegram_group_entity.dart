import 'package:drift/drift.dart';

class TelegramGroupEntity extends Table {
  TextColumn get id => text()();
  TextColumn get groupId => text().unique()();
  TextColumn get name => text()();
  BoolColumn get isChannel => boolean()();
  DateTimeColumn get addedAt => dateTime()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}
