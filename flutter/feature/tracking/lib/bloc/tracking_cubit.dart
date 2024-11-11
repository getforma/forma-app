import 'dart:async';

import 'package:core_component_domain/use_case/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:session_component_domain/model/measurement_analysis.dart';
import 'package:session_component_domain/model/split_analysis.dart';
import 'package:session_component_domain/use_case/stop_session_use_case.dart';
import 'package:session_component_domain/use_case/get_measurement_analysis_stream_use_case.dart';
import 'package:session_component_domain/use_case/get_split_analysis_use_case.dart';
import 'package:tracking_feature/bloc/tracking_screen_status.dart';

part 'tracking_cubit.freezed.dart';
part 'tracking_state.dart';

const _analyzeSessionDataInterval = Duration(minutes: 5);

@injectable
class TrackingCubit extends Cubit<TrackingState> {
  final StopSessionUseCase _stopSessionUseCase;
  final GetMeasurementAnalysisStreamUseCase
      _getMeasurementAnalysisStreamUseCase;
  final GetSplitAnalysisUseCase _getSplitAnalysisUseCase;

  StreamSubscription<MeasurementAnalysis?>?
      _measurementAnalysisStreamSubscription;

  Timer? _analyzeSessionDataTimer;

  TrackingCubit(
    this._stopSessionUseCase,
    this._getMeasurementAnalysisStreamUseCase,
    this._getSplitAnalysisUseCase,
    @factoryParam String sessionId,
  ) : super(TrackingState(
          sessionId: sessionId,
          analyzeIntervalStartTime: DateTime.now().toUtc(),
          analyzeIntervalEndTime: DateTime.now().toUtc(),
        )) {
    _measurementAnalysisStreamSubscription =
        _getMeasurementAnalysisStreamUseCase.invoke(sessionId).listen((value) {
      emit(state.copyWith(measurementAnalysis: value));
    });

    _analyzeSessionDataTimer =
        Timer.periodic(_analyzeSessionDataInterval, (timer) {
      _analyzeSessionData();
    });
  }

  Future<void> stopSession() async {
    emit(state.copyWith(status: TrackingScreenStatus.loading));
    final stopSessionResult = await _stopSessionUseCase.invoke(EmptyParam());
    if (stopSessionResult.isRight()) {
      final measurementAnalysis = stopSessionResult.fold((e) => null, (r) => r);
      emit(state.copyWith(
        status: TrackingScreenStatus.stopped,
        measurementAnalysis: measurementAnalysis,
      ));
      return;
    }
    emit(state.copyWith(status: TrackingScreenStatus.error));
  }

  void resetStatus() {
    emit(state.copyWith(status: TrackingScreenStatus.initial));
  }

  Future<void> _analyzeSessionData() async {
    final analyzeIntervalStartTime = state.analyzeIntervalEndTime;
    final analyzeIntervalEndTime = DateTime.now().toUtc();

    final splitAnalysisResult = await _getSplitAnalysisUseCase.invoke(
      GetSplitAnalysisBody(
        // sessionId: "8aa30a78-cbcf-4e41-9e42-06e6dda1dc53",
        // startTime: DateTime.parse("2024-11-04T12:09:03.129918"),
        // endTime: DateTime.parse("2024-11-04T12:09:33.129918"),
        sessionId: state.sessionId,
        startTime: analyzeIntervalStartTime,
        endTime: analyzeIntervalEndTime,
      ),
    );

    final splitAnalysis = splitAnalysisResult.fold((e) => null, (r) => r);

    emit(state.copyWith(
      lastSplitAnalysis: splitAnalysis,
      analyzeIntervalStartTime: analyzeIntervalStartTime,
      analyzeIntervalEndTime: analyzeIntervalEndTime,
    ));
  }

  @override
  Future<void> close() {
    _measurementAnalysisStreamSubscription?.cancel();
    _analyzeSessionDataTimer?.cancel();
    _analyzeSessionDataTimer = null;
    return super.close();
  }
}
