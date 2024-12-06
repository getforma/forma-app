import 'package:authentication_component_domain/model/firebase_authentication_error.dart';
import 'package:core_component_domain/model/auth_token.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(Either<FirebaseAuthenticationError, bool>)
        verificationCompleted,
    required Function(bool) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  });

  Future<Either<FirebaseAuthenticationError, bool>> signInWithSMSCode(
      String verificationId, String smsCode);

  Future<bool> isUserSignedIn();

  Future<Either<FirebaseAuthenticationError, bool>> signInWithGoogle();

  Future<Either<FirebaseAuthenticationError, Unit>> signInWithApple();

  Future<Either<FirebaseAuthenticationError, bool>> signInWithFacebook();

  Future<AuthToken?> getAccessToken();
}
