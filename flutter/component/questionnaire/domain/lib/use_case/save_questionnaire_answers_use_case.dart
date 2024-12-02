import 'package:core_component_domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:questionnaire_component_domain/questionnaire_repository.dart';

@injectable
class SaveQuestionnaireAnswersUseCase
    implements UseCase<SaveQuestionnaireAnswersUseCaseParams, void> {
  final QuestionnaireRepository _questionnaireRepository;

  SaveQuestionnaireAnswersUseCase(this._questionnaireRepository);

  @override
  Future<Either<Exception, void>> invoke(
      SaveQuestionnaireAnswersUseCaseParams params) async {
    return _questionnaireRepository.saveQuestionnaireAnswers(
        runningSessionId: params.runningSessionId, answers: params.answers);
  }
}

class SaveQuestionnaireAnswersUseCaseParams {
  final String runningSessionId;
  final Map<String, Set<String>> answers;

  SaveQuestionnaireAnswersUseCaseParams({
    required this.runningSessionId,
    required this.answers,
  });
}
