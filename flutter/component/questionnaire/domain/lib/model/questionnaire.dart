import 'package:freezed_annotation/freezed_annotation.dart';

part 'questionnaire.freezed.dart';
part 'questionnaire.g.dart';

@freezed
class Questionnaire with _$Questionnaire {
  const Questionnaire._();

  const factory Questionnaire({
    required String id,
    required String key,
    required String name,
    required List<QuestionnaireQuestion> questions,
  }) = _Questionnaire;

  factory Questionnaire.fromJson(Map<String, dynamic> json) =>
      _$QuestionnaireFromJson(json);
}

@freezed
class QuestionnaireQuestion with _$QuestionnaireQuestion {
  const QuestionnaireQuestion._();

  const factory QuestionnaireQuestion({
    required String id,
    required String label,
    required List<QuestionnaireOption> options,
    required QuestionType questionType,
    required int sortIndex,
  }) = _QuestionnaireQuestion;

  factory QuestionnaireQuestion.fromJson(Map<String, dynamic> json) =>
      _$QuestionnaireQuestionFromJson(json);
}

@freezed
class QuestionnaireOption with _$QuestionnaireOption {
  const QuestionnaireOption._();

  const factory QuestionnaireOption({
    required String id,
    required String label,
    required int value,
  }) = _QuestionnaireOption;

  factory QuestionnaireOption.fromJson(Map<String, dynamic> json) =>
      _$QuestionnaireOptionFromJson(json);
}

enum QuestionType {
  singleChoice,
  multipleChoice,
}
