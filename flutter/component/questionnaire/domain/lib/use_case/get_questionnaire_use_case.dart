import 'package:core_component_domain/use_case/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:questionnaire_component_domain/model/questionnaire.dart';
import 'package:questionnaire_component_domain/questionnaire_repository.dart';

@injectable
class GetQuestionnaireUseCase
    implements UseCase<QuestionnaireType, Questionnaire> {
  final QuestionnaireRepository _questionnaireRepository;

  GetQuestionnaireUseCase(this._questionnaireRepository);

  @override
  Future<Either<Exception, Questionnaire>> invoke(
      QuestionnaireType type) async {
    return _questionnaireRepository.getQuestionnaire(type);
  }
}
