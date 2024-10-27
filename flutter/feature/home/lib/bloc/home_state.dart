part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    String? userName,
    @Default(SensorPosition.pelvisRight) SensorPosition sensorPosition,
    @Default(false) bool isSessionRecordingActive,
    MeasurementAnalysis? measurementAnalysis,
    @Default(HomeStatus.initial) HomeStatus status,
  }) = _HomeState;
}
