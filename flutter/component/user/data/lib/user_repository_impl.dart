import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';
import 'package:user_component_data/datasource/user_datasource.dart';
import 'package:user_component_data/datasource/user_local_datasource.dart';
import 'package:user_component_domain/user_repository.dart';
import 'package:user_component_domain/model/user.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserDataSource _userDataSource;
  final UserLocalDataSource _userLocalDataSource;

  UserRepositoryImpl(this._userDataSource, this._userLocalDataSource);

  @override
  Future<Either<Exception, Unit>> saveUser(User user) async {
    try {
      await _userDataSource.saveUser(user);
      await _userLocalDataSource.saveCurrentUser(user);
      return right(unit);
    } on Exception catch (e) {
      return left(e);
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    return _userLocalDataSource.getCurrentUser();
  }
}
