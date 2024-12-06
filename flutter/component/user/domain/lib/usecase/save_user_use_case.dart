import 'package:core_component_domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:user_component_domain/model/user.dart';
import 'package:user_component_domain/user_repository.dart';

@injectable
class SaveUserUseCase implements UseCase<User, void> {
  final UserRepository _userRepository;

  SaveUserUseCase(this._userRepository);

  @override
  Future<Either<Exception, Unit>> invoke(User user) async {
    return _userRepository.saveUser(user);
  }
}
