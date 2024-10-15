import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sensor_component_domain/model/sensor_data.dart';

part 'measurement.freezed.dart';

@freezed
class Measurement with _$Measurement {
  const factory Measurement({
    required DateTime time,
    required double latitude,
    required double longitude,
    required ThreeAxisMeasurement acceleration,
    required ThreeAxisMeasurement angularVelocity,
    required ThreeAxisMeasurement magneticField,
    required ThreeAxisMeasurement angle,
  }) = _Measurement;
}