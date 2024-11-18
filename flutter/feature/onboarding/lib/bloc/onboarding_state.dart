part of 'onboarding_cubit.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(false) bool onboardingCompleted,
  }) = _OnboardingState;
}
