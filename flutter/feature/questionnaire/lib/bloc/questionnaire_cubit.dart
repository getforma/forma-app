import 'package:core_feature/generated/l10n.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:questionnaire_component_domain/model/questionnaire.dart';
import 'package:questionnaire_component_domain/usecase/get_questionnaire_use_case.dart';
part 'questionnaire_cubit.freezed.dart';
part 'questionnaire_state.dart';

@injectable
class QuestionnaireCubit extends Cubit<QuestionnaireState> {
  final GetQuestionnaireUseCase _getQuestionnaireUseCase;

  QuestionnaireCubit(this._getQuestionnaireUseCase)
      : super(const QuestionnaireState());

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

  void resetError() {
    emit(state.copyWith(error: null));
  }
}
