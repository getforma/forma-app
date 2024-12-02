import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:questionnaire_component_data/model/submit_questionnaire_answers_request.dart';
import 'package:questionnaire_component_domain/model/questionnaire.dart';
import 'package:retrofit/retrofit.dart';

part 'questionnaire_service.g.dart';

@RestApi()
@injectable
abstract class QuestionnaireService {
  @factoryMethod
  factory QuestionnaireService(Dio dio) = _QuestionnaireService;

  @GET('/questionnaires/{type}')
  Future<HttpResponse<Questionnaire>> getQuestionnaire(
      @Path('type') QuestionnaireType type);

  @POST('/answers')
  Future<HttpResponse<void>> saveQuestionnaireAnswers(
      @Body() SubmitQuestionnaireAnswersRequest request);
}
