import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:session_component_domain/model/three_axis_model.dart';

part 'session_measurement.freezed.dart';
part 'session_measurement.g.dart';

@freezed
class SessionMeasurement with _$SessionMeasurement {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SessionMeasurement({
    required DateTime time,
    required double latitude,
    required double longitude,
    required ThreeAxisModel acceleration,
    required ThreeAxisModel angularVelocity,
    required ThreeAxisModel magneticField,
    required ThreeAxisModel angle,
  }) = _SessionMeasurement;

  factory SessionMeasurement.fromJson(Map<String, dynamic> json) =>
      _$SessionMeasurementFromJson(json);
}
