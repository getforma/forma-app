import 'package:auto_route/auto_route.dart';
import 'package:home_feature/router/home_router.gr.dart';

@AutoRouterConfig()
class HomeRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      initial: true,
    ),
  ];
}
