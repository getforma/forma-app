import 'package:freezed_annotation/freezed_annotation.dart';

part 'split_analysis.freezed.dart';
part 'split_analysis.g.dart';

@freezed
class SplitAnalysis with _$SplitAnalysis {
  const factory SplitAnalysis({
    required double cadence,
    required double distance,
    required DateTime endTime,
    required double groundContactTime,
    required double pace,
    required double speed,
    required DateTime startTime,
    required double strideLength,
    required double verticalOscillation,
    required String feedback,
  }) = _SplitAnalysis;

  factory SplitAnalysis.fromJson(Map<String, dynamic> json) =>
      _$SplitAnalysisFromJson(json);
}
