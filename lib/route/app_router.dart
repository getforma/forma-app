import 'package:auto_route/auto_route.dart';
import 'package:home_feature/router/home_router.dart';
import 'package:injectable/injectable.dart';
import 'package:onboarding_feature/router/onboarding_router.dart';
import 'package:tracking_feature/router/tracking_router.dart';
import 'package:questionnaire_feature/router/questionnaire_router.dart';

export 'package:home_feature/router/home_router.gr.dart';
export 'package:tracking_feature/router/tracking_router.gr.dart';
export 'package:onboarding_feature/router/onboarding_router.gr.dart';
export 'package:questionnaire_feature/router/questionnaire_router.gr.dart';

part 'app_router.gr.dart';

@singleton
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter() : super();

  final _homeRouter = HomeRouter();
  final _trackingRouter = TrackingRouter();
  final _onboardingRouter = OnboardingRouter();
  final _questionnaireRouter = QuestionnaireRouter();

  @override
  List<AutoRoute> get routes => [
        ..._homeRouter.routes,
        ..._trackingRouter.routes,
        ..._onboardingRouter.routes,
        ..._questionnaireRouter.routes,
      ];
}
