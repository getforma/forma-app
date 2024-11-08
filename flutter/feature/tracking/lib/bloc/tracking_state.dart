part of 'tracking_cubit.dart';

@freezed
class TrackingState with _$TrackingState {
  const factory TrackingState({
    required String sessionId,
    MeasurementAnalysis? measurementAnalysis,
    @Default(TrackingScreenStatus.initial) TrackingScreenStatus status,
  }) = _TrackingState;
}
