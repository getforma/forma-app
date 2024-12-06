import 'package:authentication_component_domain/repository/authentication_repository.dart';
import 'package:core_component_domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInWithSmsCodeUseCase
    implements UseCase<SignInWithSmsCodeUseCaseParams, bool> {
  final AuthenticationRepository authenticationRepository;

  SignInWithSmsCodeUseCase({required this.authenticationRepository});

  @override
  Future<Either<Exception, bool>> invoke(
      SignInWithSmsCodeUseCaseParams params) async {
    return authenticationRepository.signInWithSMSCode(
        params.verificationId, params.smsCode);
  }
}

class SignInWithSmsCodeUseCaseParams {
  final String verificationId;
  final String smsCode;

  SignInWithSmsCodeUseCaseParams(
      {required this.verificationId, required this.smsCode});
}
