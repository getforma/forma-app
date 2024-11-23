import 'package:authentication_component_domain/model/firebase_authentication_error.dart';
import 'package:authentication_component_domain/repository/authentication_repository.dart';
import 'package:core_component_domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyPhoneNumberUseCase
    implements NotLensUseCase<VerifyPhoneNumberUseCaseParams, Unit> {
  final AuthenticationRepository authenticationRepository;

  VerifyPhoneNumberUseCase({required this.authenticationRepository});

  @override
  Future<Unit> invoke(VerifyPhoneNumberUseCaseParams params) async {
    await authenticationRepository.verifyPhoneNumber(
      phoneNumber: params.phoneNumber,
      verificationCompleted: params.verificationCompleted,
      verificationFailed: params.verificationFailed,
      codeSent: params.codeSent,
      codeAutoRetrievalTimeout: params.codeAutoRetrievalTimeout,
    );
    return unit;
  }
}

class VerifyPhoneNumberUseCaseParams {
  final String phoneNumber;
  final Function(Either<FirebaseAuthenticationError, Unit>)
      verificationCompleted;
  final Function(bool) verificationFailed;
  final Function(String, int?) codeSent;
  final Function(String) codeAutoRetrievalTimeout;

  VerifyPhoneNumberUseCaseParams({
    required this.phoneNumber,
    required this.verificationCompleted,
    required this.verificationFailed,
    required this.codeSent,
    required this.codeAutoRetrievalTimeout,
  });
}
