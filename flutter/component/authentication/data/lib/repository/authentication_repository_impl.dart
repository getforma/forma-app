import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

import 'package:authentication_component_domain/model/firebase_authentication_error.dart';
import 'package:authentication_component_domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
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
  Future<Either<FirebaseAuthenticationError, Unit>> signInWithGoogle() async {
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

  @override
  Future<Either<FirebaseAuthenticationError, Unit>> signInWithApple() async {
    try {
      final appleProvider = AppleAuthProvider();
      await FirebaseAuth.instance.signInWithProvider(appleProvider);
      return right(unit);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return left(UnknownFirebaseAuthenticationError());
    }
  }

  @override
  Future<Either<FirebaseAuthenticationError, Unit>> signInWithFacebook() async {
    try {
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login(
        nonce: nonce,
      );

      final accessToken = loginResult.accessToken;
      if (accessToken == null) {
        return left(UnknownFirebaseAuthenticationError());
      }

      // handle limited access token
      if (accessToken.type == AccessTokenType.limited) {
        final OAuthCredential facebookAuthCredential =
            OAuthProvider('facebook.com').credential(
          idToken: accessToken.tokenString,
          rawNonce: rawNonce,
        );
        return _signInWithCredential(facebookAuthCredential);
      }

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(accessToken.tokenString);
      return _signInWithCredential(facebookAuthCredential);
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
      final userCredential = await auth.signInWithCredential(credential);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        return left(InvalidSMSCodeError());
      }
      if (e.code == 'account-exists-with-different-credential') {
        return left(AccountExistsWithDifferentCredentialError());
      }
      return left(UnknownFirebaseAuthenticationError());
    }
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String _generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
