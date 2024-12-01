import 'package:auto_route/auto_route.dart';
import 'package:questionnaire_feature/router/questionnaire_router.gr.dart';

@AutoRouterConfig()
class QuestionnaireRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: QuestionnaireRoute.page),
      ];
}
