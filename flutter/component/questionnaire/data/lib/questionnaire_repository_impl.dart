import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:questionnaire_component_data/datasource/questionnaire_datasource.dart';
import 'package:questionnaire_component_data/model/submit_questionnaire_answers_request.dart';
import 'package:questionnaire_component_domain/model/questionnaire.dart';
import 'package:questionnaire_component_domain/questionnaire_repository.dart';

@LazySingleton(as: QuestionnaireRepository)
class QuestionnaireRepositoryImpl implements QuestionnaireRepository {
  final QuestionnaireDataSource _questionnaireDataSource;

  QuestionnaireRepositoryImpl(this._questionnaireDataSource);

  @override
  Future<Either<Exception, Questionnaire>> getQuestionnaire(
      QuestionnaireType type) async {
    try {
      final questionnaire =
          await _questionnaireDataSource.getQuestionnaire(type);
      return Right(questionnaire);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, int>> saveQuestionnaireAnswers(
      {required String runningSessionId,
      required Map<String, Set<String>> answers}) async {
    try {
      final score = await _questionnaireDataSource.saveQuestionnaireAnswers(
          SubmitQuestionnaireAnswersRequest(
              runningSessionId: runningSessionId,
              data: answers.entries
                  .map((e) => QuestionnaireAnswer(
                      questionId: e.key, answerValue: e.value))
                  .toList()));
      return Right(score);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
