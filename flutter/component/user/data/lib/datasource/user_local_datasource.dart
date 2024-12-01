import 'package:core_component_data/database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:user_component_data/model/user_mapper.dart';
import 'package:user_component_domain/model/user.dart';

abstract class UserLocalDataSource {
  Future<void> saveCurrentUser(User user);

  Future<User?> getCurrentUser();
}

@LazySingleton(as: UserLocalDataSource)
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final AppDatabase _database;

  UserLocalDataSourceImpl(this._database);

  @override
  Future<void> saveCurrentUser(User user) async {
    await _database.into(_database.userTable).insert(UserTableCompanion(
          email: Value(user.email),
          name: Value(user.name),
        ));
  }

  @override
  Future<User?> getCurrentUser() async {
    final user = await _database.select(_database.userTable).get();
    return user.firstOrNull?.toUser();
  }
}
