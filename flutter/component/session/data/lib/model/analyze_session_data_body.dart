import 'package:freezed_annotation/freezed_annotation.dart';

part 'analyze_session_data_body.freezed.dart';

@freezed
class AnalyzeSessionDataBody with _$AnalyzeSessionDataBody {
  const factory AnalyzeSessionDataBody({
    required DateTime startTime,
    required DateTime endTime,
  }) = _AnalyzeSessionDataBody;

  factory AnalyzeSessionDataBody.fromJson(Map<String, dynamic> json) =>
      _$AnalyzeSessionDataBodyFromJson(json);
}
