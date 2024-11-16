import 'dart:async';

import 'package:core_component_domain/use_case/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:home_feature/bloc/home_status.dart';
import 'package:injectable/injectable.dart';
import 'package:sensor_component_domain/use_case/initialize_sensor_use_case.dart';
import 'package:sensor_component_domain/use_case/start_sensor_discovery_use_case.dart';
import 'package:session_component_domain/model/measurement_analysis.dart';
import 'package:session_component_domain/model/sensor_position.dart';
import 'package:session_component_domain/use_case/create_session_use_case.dart';
import 'package:sensor_component_domain/use_case/get_is_sensor_connected_stream_use_case.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final InitializeSensorUseCase _initializeSensorUseCase;
  final StartSensorDiscoveryUseCase _startSensorDiscoveryUseCase;
  final CreateSessionUseCase _createSessionUseCase;

  HomeCubit(
    this._initializeSensorUseCase,
    this._startSensorDiscoveryUseCase,
    this._createSessionUseCase,
  ) : super(const HomeState());

  Future<void> startDeviceDiscovery() async {
    final initializeResult =
        await _initializeSensorUseCase.invoke(EmptyParam());
    final isSensorInitialized = initializeResult.fold(
      (l) => false,
      (r) => r,
    );
    if (!isSensorInitialized) {
      emit(state.copyWith(status: HomeStatus.sensorInitializationError));
      return;
    }

    _startSensorDiscoveryUseCase.invoke(EmptyParam());
  }

  Future<String?> startSession() async {
    final userName = state.userName;
    if (userName == null) {
      emit(state.copyWith(status: HomeStatus.nameError));
      return null;
    }

    if (!state.isSensorConnected) {
      emit(state.copyWith(status: HomeStatus.sensorDisconnected));
      return null;
    }

    emit(state.copyWith(status: HomeStatus.loading));

    final sessionResult =
        await _createSessionUseCase.invoke(CreateSessionUseCaseParam(
      sensorPosition: state.sensorPosition,
      userName: userName,
    ));

    if (sessionResult.isLeft()) {
      emit(state.copyWith(status: HomeStatus.genericError));
      return null;
    }

    final sessionResponse = sessionResult.fold(
      (l) => null,
      (r) => r,
    );

    emit(state.copyWith(
      isSessionRecordingActive: true,
      status: HomeStatus.sessionStarted,
    ));
    return sessionResponse?.id;
  }

  void onSessionStopped(MeasurementAnalysis? measurementAnalysis) {
    emit(state.copyWith(
      measurementAnalysis: measurementAnalysis,
      isSessionRecordingActive: false,
      status: HomeStatus.sessionStopped,
    ));
  }

  void updateUserName(String name) {
    emit(state.copyWith(userName: name));
  }

  void updateSensorPosition(SensorPosition? position) {
    if (position == null) {
      return;
    }
    emit(state.copyWith(sensorPosition: position));
  }

  void resetStatus() {
    emit(state.copyWith(status: HomeStatus.initial));
  }
}
