import 'package:drift/drift.dart';

class UserTable extends Table {
  TextColumn get email => text()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {email};
}
