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
            CustomRoute(
              page: WelcomeRoute.page,
              transitionsBuilder: TransitionsBuilders.slideLeft,
              initial: true,
            ),
            CustomRoute(
              page: LoginRoute.page,
              transitionsBuilder: TransitionsBuilders.slideLeft,
            ),
            CustomRoute(
              page: VerificationCodeRoute.page,
              transitionsBuilder: TransitionsBuilders.slideLeft,
            ),
          ],
        ),
      ];
}
