import 'package:drift/drift.dart';

class FavoriteEntity extends Table {
  TextColumn get id => text()();
  TextColumn get jobId => text()();
  DateTimeColumn get savedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
