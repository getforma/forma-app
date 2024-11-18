import 'dart:async';

import 'package:core_component_domain/use_case/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:home_feature/bloc/home_status.dart';
import 'package:home_feature/model/recommended_training.dart';
import 'package:injectable/injectable.dart';
import 'package:sensor_component_domain/use_case/get_is_sensor_connected_stream_use_case.dart';
import 'package:sensor_component_domain/use_case/initialize_sensor_use_case.dart';
import 'package:sensor_component_domain/use_case/start_sensor_discovery_use_case.dart';
import 'package:session_component_domain/model/measurement_analysis.dart';
import 'package:session_component_domain/model/sensor_position.dart';
import 'package:session_component_domain/use_case/create_session_use_case.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final InitializeSensorUseCase _initializeSensorUseCase;
  final StartSensorDiscoveryUseCase _startSensorDiscoveryUseCase;
  final CreateSessionUseCase _createSessionUseCase;
  final GetIsSensorConnectedStreamUseCase _getIsSensorConnectedStreamUseCase;

  StreamSubscription<bool>? _isSensorConnectedStreamSubscription;

  HomeCubit(
    this._initializeSensorUseCase,
    this._startSensorDiscoveryUseCase,
    this._createSessionUseCase,
    this._getIsSensorConnectedStreamUseCase,
  ) : super(const HomeState()) {
    _isSensorConnectedStreamSubscription =
        _getIsSensorConnectedStreamUseCase.invoke(EmptyParam()).listen((value) {
      emit(state.copyWith(isSensorConnected: value));
    });
  }

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
    if (!state.isSensorConnected) {
      emit(state.copyWith(status: HomeStatus.sensorDisconnected));
      return null;
    }

    emit(state.copyWith(status: HomeStatus.loading));

    final sessionResult =
        await _createSessionUseCase.invoke(CreateSessionUseCaseParam(
      sensorPosition: SensorPosition.pelvisBack,
      userName: "",
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

  void loadRecommendedTrainings() {
    final now = DateTime.now();
    emit(state.copyWith(
      recommendedTrainings: [
        RecommendedTraining(
          date: now,
          type: RecommendedTrainingType.rest,
        ),
        RecommendedTraining(
          date: now.add(const Duration(days: 1)),
          type: RecommendedTrainingType.easy,
        ),
        RecommendedTraining(
          date: now.add(const Duration(days: 2)),
          type: RecommendedTrainingType.intervals,
        ),
        RecommendedTraining(
          date: now.add(const Duration(days: 3)),
          type: RecommendedTrainingType.rest,
        ),
        RecommendedTraining(
          date: now.add(const Duration(days: 4)),
          type: RecommendedTrainingType.long,
        ),
      ],
    ));
  }

  void resetStatus() {
    emit(state.copyWith(status: HomeStatus.initial));
  }

  @override
  Future<void> close() {
    _isSensorConnectedStreamSubscription?.cancel();
    _isSensorConnectedStreamSubscription = null;
    return super.close();
  }
}
