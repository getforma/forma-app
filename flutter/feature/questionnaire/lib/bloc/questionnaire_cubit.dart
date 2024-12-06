import 'package:core_feature/generated/l10n.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:questionnaire_component_domain/model/questionnaire.dart';
import 'package:questionnaire_component_domain/use_case/get_questionnaire_use_case.dart';
import 'package:questionnaire_component_domain/use_case/save_questionnaire_answers_use_case.dart';

part 'questionnaire_cubit.freezed.dart';
part 'questionnaire_state.dart';

@injectable
class QuestionnaireCubit extends Cubit<QuestionnaireState> {
  final GetQuestionnaireUseCase _getQuestionnaireUseCase;
  final SaveQuestionnaireAnswersUseCase _saveQuestionnaireAnswersUseCase;

  QuestionnaireCubit(
    this._getQuestionnaireUseCase,
    this._saveQuestionnaireAnswersUseCase,
  ) : super(const QuestionnaireState());

  Future<void> loadQuestionnaire() async {
    emit(state.copyWith(status: QuestionnaireStatus.loading));

    final result =
        await _getQuestionnaireUseCase.invoke(QuestionnaireType.post_run);

    final questionnaire = result.fold(
      (l) => null,
      (r) => r,
    );

    if (questionnaire == null) {
      emit(state.copyWith(
        error: QuestionnaireError.unknown,
        status: QuestionnaireStatus.initial,
      ));
      return;
    }

    emit(state.copyWith(
      questionnaire: questionnaire,
      status: QuestionnaireStatus.initial,
    ));
  }

  void setRunningSessionId(String? runningSessionId) {
    emit(state.copyWith(runningSessionId: runningSessionId));
  }

  Future<void> saveQuestionnaireAnswers() async {
    emit(state.copyWith(status: QuestionnaireStatus.loading));

    final result = await _saveQuestionnaireAnswersUseCase
        .invoke(SaveQuestionnaireAnswersUseCaseParams(
      runningSessionId: state.runningSessionId ?? "27784feb-ab95-4c69-97b5-fa4ae271a138", // TODO
      answers: state.answers,
    ));

    result.fold(
      (l) => emit(state.copyWith(
        error: QuestionnaireError.unknown,
        status: QuestionnaireStatus.initial,
      )),
      (r) => emit(state.copyWith(status: QuestionnaireStatus.saved)),
    );
  }

  void onAnswerClicked(String questionId, String answerId) {
    final question =
        state.questionnaire?.questions.firstWhere((q) => q.id == questionId);
    if (question == null) {
      return;
    }

    final answers = Map.of(state.answers);
    Set<String> currentAnswers = Set.of(answers[questionId] ?? {});

    if (question.questionType == QuestionType.single_choice) {
      currentAnswers = {answerId};
      answers[questionId] = currentAnswers;
      emit(state.copyWith(answers: answers));
      return;
    }

    if (currentAnswers.contains(answerId) == true) {
      currentAnswers.remove(answerId);
    } else {
      if (currentAnswers.length >= 2) {
        currentAnswers.remove(currentAnswers.first);
      }
      currentAnswers.add(answerId);
    }

    answers[questionId] = currentAnswers;
    emit(state.copyWith(answers: answers));
  }

  void resetError() {
    emit(state.copyWith(error: null));
  }
}
