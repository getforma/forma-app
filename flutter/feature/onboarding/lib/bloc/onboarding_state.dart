part of 'onboarding_cubit.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(false) bool onboardingCompleted,
    @Default(false) bool isUserSignedIn,
    @Default(OnboardingStage.welcome) OnboardingStage stage,
    @Default(OnboardingStatus.initial) OnboardingStatus status,
    OnboardingError? error,
    String? phoneNumber,
    String? verificationId,
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
  accountExistsWithDifferentCredential,
  unknown;

  static fromFirebaseAuthenticationError(FirebaseAuthenticationError error) {
    switch (error.runtimeType) {
      case InvalidPhoneNumberError:
        return OnboardingError.invalidPhoneNumber;
      case InvalidSMSCodeError:
        return OnboardingError.invalidSmsCode;
      case AccountExistsWithDifferentCredentialError:
        return OnboardingError.accountExistsWithDifferentCredential;
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
      case OnboardingError.accountExistsWithDifferentCredential:
        return translations.login_error_account_exists_with_different_credential;
      case OnboardingError.unknown:
        return translations.login_error_unknown;
    }
  }
}
