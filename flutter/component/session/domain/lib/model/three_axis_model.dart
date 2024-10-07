import 'package:freezed_annotation/freezed_annotation.dart';

part 'three_axis_model.freezed.dart';
part 'three_axis_model.g.dart';

@freezed
class ThreeAxisModel with _$ThreeAxisModel {
  const factory ThreeAxisModel({
    required double x,
    required double y,
    required double z,
  }) = _ThreeAxisModel;

  factory ThreeAxisModel.fromJson(Map<String, dynamic> json) =>
      _$ThreeAxisModelFromJson(json);
}
