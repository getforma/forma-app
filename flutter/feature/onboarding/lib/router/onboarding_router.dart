import 'package:auto_route/auto_route.dart';
import 'package:onboarding_feature/router/onboarding_router.gr.dart';

@AutoRouterConfig()
class OnboardingRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: OnboardingRoute.page,
          initial: true,
          children: [
            AutoRoute(page: WelcomeRoute.page, initial: true),
            AutoRoute(page: LoginRoute.page),
          ],
        ),
      ];
}
