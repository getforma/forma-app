import 'dart:async';

import 'package:core_component_domain/use_case/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sensor_component_domain/use_case/initialize_sensor_use_case.dart';
import 'package:sensor_component_domain/use_case/start_sensor_discovery_use_case.dart';
import 'package:session_component_domain/model/measurement_analysis.dart';
import 'package:session_component_domain/model/sensor_position.dart';
import 'package:session_component_domain/use_case/create_session_use_case.dart';
import 'package:session_component_domain/use_case/stop_session_use_case.dart';
import 'package:session_component_domain/use_case/get_measurement_analysis_stream_use_case.dart';
part 'home_cubit.freezed.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final InitializeSensorUseCase _initializeSensorUseCase;
  final StartSensorDiscoveryUseCase _startSensorDiscoveryUseCase;
  final CreateSessionUseCase _createSessionUseCase;
  final StopSessionUseCase _stopSessionUseCase;
  final GetMeasurementAnalysisStreamUseCase
      _getMeasurementAnalysisStreamUseCase;

  StreamSubscription<MeasurementAnalysis>?
      _measurementAnalysisStreamSubscription;

  HomeCubit(
    this._initializeSensorUseCase,
    this._startSensorDiscoveryUseCase,
    this._createSessionUseCase,
    this._stopSessionUseCase,
    this._getMeasurementAnalysisStreamUseCase,
  ) : super(const HomeState());

  Future<void> startDeviceDiscovery() async {
    _initializeSensorUseCase.invoke(EmptyParam());
    _startSensorDiscoveryUseCase.invoke(EmptyParam());
  }

  Future<void> startSession() async {
    final userName = state.userName;
    if (userName == null) {
      // TODO: display error
      return;
    }

    final sessionResult =
        await _createSessionUseCase.invoke(CreateSessionUseCaseParam(
      sensorPosition: state.sensorPosition,
      userName: userName,
    ));

    if (sessionResult.isLeft()) {
      // TODO: display error
      return;
    }

    final sessionResponse = sessionResult.fold(
      (l) => null,
      (r) => r,
    );

    _measurementAnalysisStreamSubscription =
        _getMeasurementAnalysisStreamUseCase
            .invoke(sessionResponse!.id)
            .listen((value) {
      emit(state.copyWith(measurementAnalysis: value));
    });

    emit(state.copyWith(isSessionRecordingActive: true));
  }

  Future<void> stopSession() async {
    final stopSessionResult = await _stopSessionUseCase.invoke(EmptyParam());
    if (stopSessionResult.isRight()) {
      // TODO: Show popup
      emit(state.copyWith(isSessionRecordingActive: false));
      return;
    }
    // TODO: handle error
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

  @override
  Future<void> close() {
    _measurementAnalysisStreamSubscription?.cancel();
    return super.close();
  }
}
