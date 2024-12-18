import 'dart:async';

import 'package:authentication_component_domain/model/firebase_authentication_error.dart';
import 'package:authentication_component_domain/use_case/sign_in_with_google_use_case.dart';
import 'package:authentication_component_domain/use_case/sign_in_with_sms_code_use_case.dart';
import 'package:authentication_component_domain/use_case/sign_in_with_apple_use_case.dart';
import 'package:authentication_component_domain/use_case/sign_in_with_facebook_use_case.dart';
import 'package:authentication_component_domain/use_case/verify_phone_number_use_case.dart';
import 'package:authentication_component_domain/use_case/is_user_signed_id_use_case.dart';
import 'package:core_component_domain/app_configuration_repository.dart';
import 'package:core_component_domain/use_case/use_case.dart';
import 'package:core_feature/generated/l10n.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onboarding_feature/bloc/onboarding_stage.dart';
import 'package:user_component_domain/model/user.dart';
import 'package:user_component_domain/usecase/save_user_use_case.dart';

part 'onboarding_cubit.freezed.dart';
part 'onboarding_state.dart';

@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  final AppConfigurationRepository _appConfigurationRepository;
  final VerifyPhoneNumberUseCase _verifyPhoneNumberUseCase;
  final SignInWithSmsCodeUseCase _signInWithSmsCode;
  final IsUserSignedInUseCase _isUserSignedInUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignInWithAppleUseCase _signInWithAppleUseCase;
  final SignInWithFacebookUseCase _signInWithFacebookUseCase;
  final SaveUserUseCase _saveUserUseCase;

  OnboardingCubit(
    this._appConfigurationRepository,
    this._verifyPhoneNumberUseCase,
    this._signInWithSmsCode,
    this._isUserSignedInUseCase,
    this._signInWithGoogleUseCase,
    this._signInWithAppleUseCase,
    this._signInWithFacebookUseCase,
    this._saveUserUseCase,
  ) : super(const OnboardingState());

  Future<void> initialLoad() async {
    final onboardingCompleted =
        await _appConfigurationRepository.getOnboardingCompleted();
    final isUserSignedIn = await _isUserSignedInUseCase.invoke(EmptyParam());
    emit(state.copyWith(
      onboardingCompleted: onboardingCompleted,
      isUserSignedIn: isUserSignedIn,
    ));
    await _appConfigurationRepository.setOnboardingCompleted();
  }

  void navigateToLogin() {
    emit(state.copyWith(stage: OnboardingStage.login));
  }

  Future<void> verifyPhoneNumber() async {
    final phoneNumber = state.phoneNumber;
    if (phoneNumber == null) {
      emit(state.copyWith(error: OnboardingError.invalidPhoneNumber));
      return;
    }

    emit(state.copyWith(status: OnboardingStatus.loading));

    await _verifyPhoneNumberUseCase.invoke(VerifyPhoneNumberUseCaseParams(
      phoneNumber: phoneNumber,
      verificationCompleted:
          (Either<FirebaseAuthenticationError, bool> result) {
        if (result.isRight()) {
          emit(state.copyWith(
            status: OnboardingStatus.initial,
            stage: OnboardingStage.enterSmsCode,
            isNewUser: result.fold((l) => true, (r) => r),
          ));
        } else {
          final error = result.fold((l) => l, (r) => null);

          emit(state.copyWith(
              status: OnboardingStatus.initial,
              error: OnboardingError.fromFirebaseAuthenticationError(error!)));
        }
      },
      verificationFailed: (bool isPhoneNumberInvalid) {
        emit(state.copyWith(
            status: OnboardingStatus.initial,
            error: isPhoneNumberInvalid
                ? OnboardingError.invalidPhoneNumber
                : OnboardingError.unknown));
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        emit(state.copyWith(
          stage: OnboardingStage.enterSmsCode,
          status: OnboardingStatus.initial,
          verificationId: verificationId,
        ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        emit(state.copyWith(
          stage: OnboardingStage.enterSmsCode,
          status: OnboardingStatus.initial,
          verificationId: verificationId,
        ));
      },
    ));
  }

  Future<void> verifySmsCode(String smsCode) async {
    final verificationId = state.verificationId;
    if (verificationId == null) {
      emit(state.copyWith(
        error: OnboardingError.invalidSmsCode,
        stage: OnboardingStage.login,
        status: OnboardingStatus.initial,
      ));
      return;
    }

    emit(state.copyWith(status: OnboardingStatus.loading));

    final result =
        await _signInWithSmsCode.invoke(SignInWithSmsCodeUseCaseParams(
      verificationId: verificationId,
      smsCode: smsCode,
    ));
    final isNewUser = result.fold((l) => true, (r) => r);

    if (result.isRight()) {
      emit(state.copyWith(
        stage: isNewUser
            ? OnboardingStage.enterUserDetails
            : OnboardingStage.enterSmsCode,
        status: isNewUser
            ? OnboardingStatus.initial
            : OnboardingStatus.logInSuccess,
        isNewUser: isNewUser,
      ));
      return;
    }

    final error =
        result.fold((l) => l as FirebaseAuthenticationError, (r) => null);
    if (error == null) {
      return;
    }

    emit(state.copyWith(
      error: OnboardingError.fromFirebaseAuthenticationError(error),
      stage: OnboardingStage.login,
      status: OnboardingStatus.initial,
    ));
  }

  Future<void> saveUserDetails(String email, String name) async {
    emit(state.copyWith(status: OnboardingStatus.loading));
    final result = await _saveUserUseCase.invoke(User(
      email: email,
      name: name,
    ));

    if (result.isRight()) {
      emit(state.copyWith(status: OnboardingStatus.logInSuccess));
      return;
    }

    final error = result.fold((l) => l, (r) => null);
    if (error == null) {
      emit(state.copyWith(status: OnboardingStatus.initial));
      return;
    }

    emit(state.copyWith(
      error: OnboardingError.unknown,
      stage: OnboardingStage.login,
      status: OnboardingStatus.initial,
    ));
  }

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(status: OnboardingStatus.loading));
    final result = await _signInWithGoogleUseCase.invoke(EmptyParam());
    if (result.isRight()) {
      emit(state.copyWith(status: OnboardingStatus.logInSuccess));
      return;
    }

    final error =
        result.fold((l) => l as FirebaseAuthenticationError, (r) => null);
    if (error == null) {
      return;
    }

    emit(state.copyWith(
      error: OnboardingError.fromFirebaseAuthenticationError(error),
      stage: OnboardingStage.login,
      status: OnboardingStatus.initial,
    ));
  }

  Future<void> signInWithApple() async {
    emit(state.copyWith(status: OnboardingStatus.loading));
    final result = await _signInWithAppleUseCase.invoke(EmptyParam());
    if (result.isRight()) {
      emit(state.copyWith(status: OnboardingStatus.logInSuccess));
      return;
    }

    final error =
        result.fold((l) => l as FirebaseAuthenticationError, (r) => null);
    if (error == null) {
      return;
    }

    emit(state.copyWith(
      error: OnboardingError.fromFirebaseAuthenticationError(error),
      stage: OnboardingStage.login,
      status: OnboardingStatus.initial,
    ));
  }

  Future<void> signInWithFacebook() async {
    emit(state.copyWith(status: OnboardingStatus.loading));
    final result = await _signInWithFacebookUseCase.invoke(EmptyParam());
    if (result.isRight()) {
      emit(state.copyWith(status: OnboardingStatus.logInSuccess));
      return;
    }

    final error =
        result.fold((l) => l as FirebaseAuthenticationError, (r) => null);
    if (error == null) {
      return;
    }

    emit(state.copyWith(
      error: OnboardingError.fromFirebaseAuthenticationError(error),
      stage: OnboardingStage.login,
      status: OnboardingStatus.initial,
    ));
  }

  void setPhoneNumber(String? phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void resetError() {
    emit(state.copyWith(error: null));
  }
}
