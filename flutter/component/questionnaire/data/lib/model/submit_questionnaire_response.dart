import 'package:freezed_annotation/freezed_annotation.dart';

part 'submit_questionnaire_response.freezed.dart';
part 'submit_questionnaire_response.g.dart';

@freezed
class SubmitQuestionnaireResponse with _$SubmitQuestionnaireResponse {
  const SubmitQuestionnaireResponse._();

  const factory SubmitQuestionnaireResponse({
    required String message,
    required int score,
  }) = _SubmitQuestionnaireResponse;

  factory SubmitQuestionnaireResponse.fromJson(Map<String, dynamic> json) =>
      _$SubmitQuestionnaireResponseFromJson(json);
}
