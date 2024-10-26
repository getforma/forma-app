import 'package:freezed_annotation/freezed_annotation.dart';

part 'measurement_analysis.freezed.dart';
part 'measurement_analysis.g.dart';

@freezed
class MeasurementAnalysis with _$MeasurementAnalysis {
  const factory MeasurementAnalysis({
    required double cadence,
    required double distance,
    required DateTime endTime,
    required double groundContactTime,
    required double pace,
    required double speed,
    required DateTime startTime,
    required double strideLength,
    required double verticalOscillation,
  }) = _MeasurementAnalysis;

  factory MeasurementAnalysis.fromJson(Map<String, dynamic> json) =>
      _$MeasurementAnalysisFromJson(json);
}