part of 'tracking_cubit.dart';

@freezed
class TrackingState with _$TrackingState {
  const factory TrackingState({
    required String sessionId,
    MeasurementAnalysis? measurementAnalysis,
    @Default(TrackingScreenStatus.initial) TrackingScreenStatus status,
    required DateTime analyzeIntervalStartTime,
    required DateTime analyzeIntervalEndTime,
    SplitAnalysis? lastSplitAnalysis,
    @Default(false) bool isSensorConnected,
  }) = _TrackingState;
}
