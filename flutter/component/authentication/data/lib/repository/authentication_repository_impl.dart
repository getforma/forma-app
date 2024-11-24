import 'package:authentication_component_domain/repository/authentication_repository.dart';
import 'package:authentication_component_domain/model/firebase_authentication_error.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthenticationRepository)
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(Either<FirebaseAuthenticationError, Unit>)
        verificationCompleted,
    required Function(bool isPhoneNumberInvalid) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Android only
          // Sign the user in (or link) with the auto-generated credential
          verificationCompleted(await _signInWithCredential(credential));
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            verificationFailed(true);
          }
          verificationFailed(false);
        },
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<FirebaseAuthenticationError, Unit>> signInWithSMSCode(
      String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    return _signInWithCredential(credential);
  }

  Future<Either<FirebaseAuthenticationError, Unit>> _signInWithCredential(
      PhoneAuthCredential credential) async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.signInWithCredential(credential);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        return left(InvalidSMSCodeError());
      }
      return left(UnknownFirebaseAuthenticationError());
    }
  }
}
