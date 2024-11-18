import 'dart:async';

import 'package:core_component_domain/app_configuration_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'onboarding_cubit.freezed.dart';
part 'onboarding_state.dart';

@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  final AppConfigurationRepository _appConfigurationRepository;
  
  OnboardingCubit(this._appConfigurationRepository)
      : super(const OnboardingState());

  Future<void> loadOnboardingCompleted() async {
    final onboardingCompleted = await _appConfigurationRepository.getOnboardingCompleted();
    emit(state.copyWith(onboardingCompleted: onboardingCompleted));
    await _appConfigurationRepository.setOnboardingCompleted();
  }
}
