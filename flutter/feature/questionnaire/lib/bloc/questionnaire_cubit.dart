import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:questionnaire_component_domain/model/questionnaire.dart';

part 'questionnaire_cubit.freezed.dart';
part 'questionnaire_state.dart';

@injectable
class QuestionnaireCubit extends Cubit<QuestionnaireState> {
  QuestionnaireCubit() : super(const QuestionnaireState());

  Future<void> loadQuestionnaire() async {
    emit(state.copyWith(status: QuestionnaireStatus.loading));

    emit(state.copyWith(
        questionnaire: const Questionnaire(
      id: '1',
      key: '1',
      name: 'post_run',
      questions: [
        QuestionnaireQuestion(
          id: '1',
          label:
              'How would you rate the overall discomfort or pain experienced during the run?',
          questionType: QuestionType.singleChoice,
          sortIndex: 0,
          options: [
            QuestionnaireOption(
              id: '1',
              label: 'No discomfort',
              value: 0,
            ),
            QuestionnaireOption(
              id: '2',
              label: 'Mild discomfort',
              value: 1,
            ),
            QuestionnaireOption(
              id: '3',
              label: 'Moderate discomfort',
              value: 3,
            ),
            QuestionnaireOption(
              id: '4',
              label: 'Severe discomfort',
              value: 4,
            ),
            QuestionnaireOption(
              id: '5',
              label: 'Extreme discomfort',
              value: 5,
            ),
          ],
        ),
      ],
    )));
    emit(state.copyWith(status: QuestionnaireStatus.initial));
  }
}
