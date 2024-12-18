part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isSessionRecordingActive,
    MeasurementAnalysis? measurementAnalysis,
    @Default(HomeStatus.initial) HomeStatus status,
    @Default(false) bool isSensorConnected,
    @Default([]) List<Recommendation> recommendations,
    @Default(0) int score,
  }) = _HomeState;
}
