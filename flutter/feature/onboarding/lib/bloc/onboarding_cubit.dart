import 'dart:async';

import 'package:authentication_component_domain/model/firebase_authentication_error.dart';
import 'package:authentication_component_domain/use_case/sign_in_with_sms_code_use_case.dart';
import 'package:authentication_component_domain/use_case/verify_phone_number_use_case.dart';
import 'package:core_component_domain/app_configuration_repository.dart';
import 'package:core_feature/generated/l10n.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onboarding_feature/bloc/onboarding_stage.dart';

part 'onboarding_cubit.freezed.dart';
part 'onboarding_state.dart';

@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  final AppConfigurationRepository _appConfigurationRepository;
  final VerifyPhoneNumberUseCase _verifyPhoneNumberUseCase;
  final SignInWithSmsCodeUseCase _signInWithSmsCode;

  OnboardingCubit(
    this._appConfigurationRepository,
    this._verifyPhoneNumberUseCase,
    this._signInWithSmsCode,
  ) : super(const OnboardingState());

  Future<void> loadOnboardingCompleted() async {
    final onboardingCompleted =
        await _appConfigurationRepository.getOnboardingCompleted();
    emit(state.copyWith(onboardingCompleted: onboardingCompleted));
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

    // emit(state.copyWith(status: OnboardingStatus.loading));

    await _verifyPhoneNumberUseCase.invoke(VerifyPhoneNumberUseCaseParams(
      phoneNumber: phoneNumber,
      verificationCompleted:
          (Either<FirebaseAuthenticationError, Unit> result) {
        if (result.isRight()) {
          emit(state.copyWith(status: OnboardingStatus.initial));
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
        ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        emit(state.copyWith(
          stage: OnboardingStage.enterSmsCode,
          status: OnboardingStatus.initial,
        ));
      },
    ));
  }

  void setPhoneNumber(String? phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void resetError() {
    emit(state.copyWith(error: null));
  }
}
