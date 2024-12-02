part of 'questionnaire_cubit.dart';

@freezed
class QuestionnaireState with _$QuestionnaireState {
  const factory QuestionnaireState({
    @Default(QuestionnaireStatus.initial) QuestionnaireStatus status,
    QuestionnaireError? error,
    Questionnaire? questionnaire,
    @Default({}) Map<String, int> answers,
  }) = _QuestionnaireState;
}

enum QuestionnaireStatus {
  initial,
  loading,
  saved,
}

enum QuestionnaireError {
  unknown;

  String text(BuildContext context) {
    final translations = S.of(context);
    switch (this) {
      case QuestionnaireError.unknown:
        return translations.error_unknown;
    }
  }
}