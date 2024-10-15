import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sensor_component_domain/model/sensor_data.dart';

part 'three_axis_model.freezed.dart';
part 'three_axis_model.g.dart';

@freezed
class ThreeAxisModel with _$ThreeAxisModel {
  const ThreeAxisModel._();

  const factory ThreeAxisModel({
    required double x,
    required double y,
    required double z,
  }) = _ThreeAxisModel;

  factory ThreeAxisModel.fromJson(Map<String, dynamic> json) =>
      _$ThreeAxisModelFromJson(json);

  factory ThreeAxisModel.fromMeasurement(ThreeAxisMeasurement measurement) =>
      ThreeAxisModel(
        x: measurement.x ?? 0,
        y: measurement.y ?? 0,
        z: measurement.z ?? 0,
      );
}
