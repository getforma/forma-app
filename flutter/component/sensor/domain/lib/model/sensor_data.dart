import 'package:freezed_annotation/freezed_annotation.dart';

part 'sensor_data.freezed.dart';

@freezed
class SensorData with _$SensorData {
  const SensorData._();

  const factory SensorData({
    required String name,
    required ThreeAxisMeasurement acceleration,
    required ThreeAxisMeasurement angularVelocity,
    required ThreeAxisMeasurement magneticField,
    required ThreeAxisMeasurement angle,
  }) = _SensorData;
}

@freezed
class ThreeAxisMeasurement with _$ThreeAxisMeasurement {
  const factory ThreeAxisMeasurement({
    double? x,
    double? y,
    double? z,
  }) = _ThreeAxisMeasurement;
}
