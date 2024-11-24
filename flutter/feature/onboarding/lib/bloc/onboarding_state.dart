part of 'onboarding_cubit.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(false) bool onboardingCompleted,
    @Default(OnboardingStage.welcome) OnboardingStage stage,
    @Default(OnboardingStatus.initial) OnboardingStatus status,
    OnboardingError? error,
    String? phoneNumber,
  }) = _OnboardingState;
}

enum OnboardingStatus {
  initial,
  loading,
  logInSuccess,
}

enum OnboardingError {
  invalidPhoneNumber,
  invalidSmsCode,
  unknown;

  static fromFirebaseAuthenticationError(FirebaseAuthenticationError error) {
    switch (error.runtimeType) {
      case InvalidPhoneNumberError:
        return OnboardingError.invalidPhoneNumber;
      case InvalidSMSCodeError:
        return OnboardingError.invalidSmsCode;
      default:
        return OnboardingError.unknown;
    }
  }

  String text(BuildContext context) {
    final translations = S.of(context);
    switch (this) {
      case OnboardingError.invalidPhoneNumber:
        return translations.login_error_invalid_phone_number;
      case OnboardingError.invalidSmsCode:
        return translations.login_error_invalid_sms_code;
      case OnboardingError.unknown:
        return translations.login_error_unknown;
    }
  }
}
