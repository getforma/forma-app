part of 'main_cubit.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({
    String? userName,
    @Default(SensorPosition.pelvisRight) SensorPosition sensorPosition,
  }) = _MainState;
}
