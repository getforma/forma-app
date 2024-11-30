import 'package:authentication_component_domain/repository/authentication_repository.dart';
import 'package:authentication_component_domain/model/firebase_authentication_error.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  @override
  Future<bool> isUserSignedIn() async {
    final auth = FirebaseAuth.instance;
    return auth.currentUser != null;
  }

  @override
  Future<Either<FirebaseAuthenticationError, Unit>>
      triggerGoogleSignIn() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return _signInWithCredential(credential);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return left(UnknownFirebaseAuthenticationError());
    }
  }

  Future<Either<FirebaseAuthenticationError, Unit>> _signInWithCredential(
      AuthCredential credential) async {
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
