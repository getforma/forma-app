part of 'questionnaire_cubit.dart';

@freezed
class QuestionnaireState with _$QuestionnaireState {
  const factory QuestionnaireState({
    @Default(QuestionnaireStatus.initial) QuestionnaireStatus status,
  }) = _QuestionnaireState;
}

enum QuestionnaireStatus {
  initial,
  loading,
  saved,
}
