import 'package:dartz/dartz.dart';
import 'package:questionnaire_component_domain/model/questionnaire.dart';

abstract class QuestionnaireRepository {
  Future<Either<Exception, Questionnaire>> getQuestionnaire(
      QuestionnaireType type);
}
