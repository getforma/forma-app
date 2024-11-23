import 'package:authentication_component_domain/model/firebase_authentication_error.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(Either<FirebaseAuthenticationError, Unit>)
        verificationCompleted,
    required Function(bool) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  });

  Future<Either<FirebaseAuthenticationError, Unit>> signInWithSMSCode(
      String verificationId, String smsCode);
}
