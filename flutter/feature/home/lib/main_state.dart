part of 'main_cubit.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({
    String? userName,
    SensorPosition? sensorPosition,
  }) = _MainState;
}
