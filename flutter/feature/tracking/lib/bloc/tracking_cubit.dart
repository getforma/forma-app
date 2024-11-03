import 'dart:async';

import 'package:core_component_domain/use_case/use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:session_component_domain/model/measurement_analysis.dart';
import 'package:session_component_domain/use_case/stop_session_use_case.dart';
import 'package:session_component_domain/use_case/get_measurement_analysis_stream_use_case.dart';
import 'package:tracking_feature/bloc/tracking_screen_status.dart';

part 'tracking_cubit.freezed.dart';
part 'tracking_state.dart';

@injectable
class TrackingCubit extends Cubit<TrackingState> {
  final StopSessionUseCase _stopSessionUseCase;
  final GetMeasurementAnalysisStreamUseCase
      _getMeasurementAnalysisStreamUseCase;

  StreamSubscription<MeasurementAnalysis?>?
      _measurementAnalysisStreamSubscription;

  TrackingCubit(
    this._stopSessionUseCase,
    this._getMeasurementAnalysisStreamUseCase,
  ) : super(const TrackingState()) {
    // _measurementAnalysisStreamSubscription =
    //     _getMeasurementAnalysisStreamUseCase
    //         .invoke(sessionResponse!.id)
    //         .listen((value) {
    //   emit(state.copyWith(measurementAnalysis: value));
    // });
  }

  Future<void> stopSession() async {
    emit(state.copyWith(status: TrackingScreenStatus.loading));
    final stopSessionResult = await _stopSessionUseCase.invoke(EmptyParam());
    if (stopSessionResult.isRight()) {
      emit(state.copyWith(
        status: TrackingScreenStatus.stopped,
      ));
      return;
    }
    emit(state.copyWith(status: TrackingScreenStatus.error));
  }

  void resetStatus() {
    emit(state.copyWith(status: TrackingScreenStatus.initial));
  }

  @override
  Future<void> close() {
    _measurementAnalysisStreamSubscription?.cancel();
    return super.close();
  }
}
