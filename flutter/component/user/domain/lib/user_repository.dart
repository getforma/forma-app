import 'package:dartz/dartz.dart';
import 'package:user_component_domain/model/user.dart';

abstract class UserRepository {
  Future<Either<Exception, Unit>> saveUser(User user);

  Future<User?> getCurrentUser();
}
