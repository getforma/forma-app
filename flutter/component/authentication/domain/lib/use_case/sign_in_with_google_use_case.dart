import 'package:authentication_component_domain/repository/authentication_repository.dart';
import 'package:core_component_domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInWithGoogleUseCase implements UseCase<EmptyParam, Unit> {
  final AuthenticationRepository authenticationRepository;

  SignInWithGoogleUseCase({required this.authenticationRepository});

  @override
  Future<Either<Exception, Unit>> invoke(EmptyParam params) async {
    return authenticationRepository.triggerGoogleSignIn();
  }
}
