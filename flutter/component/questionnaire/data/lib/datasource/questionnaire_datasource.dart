import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:questionnaire_component_data/model/submit_questionnaire_answers_request.dart';
import 'package:questionnaire_component_data/questionnaire_service.dart';
import 'package:questionnaire_component_domain/model/questionnaire.dart';

@injectable
class QuestionnaireDataSource {
  final QuestionnaireService _questionnaireService;

  QuestionnaireDataSource(this._questionnaireService);

  Future<Questionnaire> getQuestionnaire(QuestionnaireType type) async {
    final response = await _questionnaireService.getQuestionnaire(type);
    if (response.response.statusCode == HttpStatus.ok) {
      return response.data;
    }
    throw Exception(response.data);
  }

  Future<int> saveQuestionnaireAnswers(
      SubmitQuestionnaireAnswersRequest request) async {
    final response =
        await _questionnaireService.saveQuestionnaireAnswers(request);
    if (response.response.statusCode == HttpStatus.created) {
      return response.data.score;
    }
    throw Exception();
  }
}
