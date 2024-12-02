import 'package:freezed_annotation/freezed_annotation.dart';

part 'submit_questionnaire_answers_request.freezed.dart';
part 'submit_questionnaire_answers_request.g.dart';

@freezed
class SubmitQuestionnaireAnswersRequest
    with _$SubmitQuestionnaireAnswersRequest {
  const SubmitQuestionnaireAnswersRequest._();

  const factory SubmitQuestionnaireAnswersRequest({
    required String runningSessionId,
    required List<QuestionnaireAnswer> data,
  }) = _SubmitQuestionnaireAnswersRequest;

  factory SubmitQuestionnaireAnswersRequest.fromJson(
          Map<String, dynamic> json) =>
      _$SubmitQuestionnaireAnswersRequestFromJson(json);
}

@freezed
class QuestionnaireAnswer with _$QuestionnaireAnswer {
  const QuestionnaireAnswer._();

  const factory QuestionnaireAnswer({
    required String questionId,
    required Set<String> answerValue,
  }) = _QuestionnaireAnswer;

  factory QuestionnaireAnswer.fromJson(Map<String, dynamic> json) =>
      _$QuestionnaireAnswerFromJson(json);
}
