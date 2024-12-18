import 'dart:convert';
import 'dart:math';

import 'package:authentication_component_domain/model/firebase_authentication_error.dart';
import 'package:authentication_component_domain/repository/authentication_repository.dart';
import 'package:core_component_domain/model/auth_token.dart';
import 'package:core_component_domain/secure_storage_repository.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:user_component_domain/model/user.dart' as UserDomain;
import 'package:user_component_domain/user_repository.dart';

@Injectable(as: AuthenticationRepository)
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final SecureStorageRepository _secureStorageRepository;
  final UserRepository _userRepository;

  AuthenticationRepositoryImpl(
    this._secureStorageRepository,
    this._userRepository,
  );

  @override
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required Function(Either<FirebaseAuthenticationError, bool>)
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
          verificationCompleted(await _signInWithCredential(
            credential: credential,
            handleUserDetailsManually: true,
          ));
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
  Future<Either<FirebaseAuthenticationError, bool>> signInWithSMSCode(
      String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    return _signInWithCredential(
      credential: credential,
      handleUserDetailsManually: true,
    );
  }

  @override
  Future<bool> isUserSignedIn() async {
    final auth = FirebaseAuth.instance;
    return auth.currentUser != null;
  }

  @override
  Future<Either<FirebaseAuthenticationError, bool>> signInWithGoogle() async {
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
      return _signInWithCredential(credential: credential);
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
      appleProvider.addScope('email');
      appleProvider.addScope('name');
      final signedCredential =
          await FirebaseAuth.instance.signInWithProvider(appleProvider);

      final accessToken =
          await FirebaseAuth.instance.currentUser?.getIdTokenResult();
      final tokenString = accessToken?.token;
      if (accessToken == null || tokenString == null) {
        return left(UnknownFirebaseAuthenticationError());
      }

      await _secureStorageRepository.setAccessToken(AuthToken(
        token: tokenString,
        expirationTime: accessToken.expirationTime,
      ));

      final isNewUser = signedCredential.additionalUserInfo?.isNewUser ?? true;
      if (isNewUser) {
        final userResponse = await _userRepository.saveUser(UserDomain.User(
          email: signedCredential.user?.providerData.firstOrNull?.email ?? '',
          name: signedCredential.user?.providerData.firstOrNull?.displayName ??
              '',
        ));
        if (userResponse.isLeft()) {
          return left(UnknownFirebaseAuthenticationError());
        }
      }

      return right(unit);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return left(UnknownFirebaseAuthenticationError());
    }
  }

  @override
  Future<Either<FirebaseAuthenticationError, bool>> signInWithFacebook() async {
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
        return _signInWithCredential(credential: facebookAuthCredential);
      }

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(accessToken.tokenString);
      return _signInWithCredential(credential: facebookAuthCredential);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return left(UnknownFirebaseAuthenticationError());
    }
  }

  Future<Either<FirebaseAuthenticationError, bool>> _signInWithCredential({
    required AuthCredential credential,
    bool handleUserDetailsManually = false,
  }) async {
    try {
      final auth = FirebaseAuth.instance;
      final signedCredential = await auth.signInWithCredential(credential);

      final accessToken =
          await FirebaseAuth.instance.currentUser?.getIdTokenResult();
      final tokenString = accessToken?.token;
      if (accessToken == null || tokenString == null) {
        return left(UnknownFirebaseAuthenticationError());
      }

      await _secureStorageRepository.setAccessToken(AuthToken(
        token: tokenString,
        expirationTime: accessToken.expirationTime,
      ));

      if (handleUserDetailsManually) {
        return right(signedCredential.additionalUserInfo?.isNewUser ?? true);
      }

      final isNewUser = signedCredential.additionalUserInfo?.isNewUser ?? true;
      if (isNewUser) {
        final userResponse = await _userRepository.saveUser(UserDomain.User(
          email: auth.currentUser?.email ?? '',
          name: auth.currentUser?.displayName ?? '',
        ));
        if (userResponse.isLeft()) {
          return left(UnknownFirebaseAuthenticationError());
        }
      }

      return right(isNewUser);
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

  @override
  Future<AuthToken?> getAccessToken() async {
    return _secureStorageRepository.getAccessToken();
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
