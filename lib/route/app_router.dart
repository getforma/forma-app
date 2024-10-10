import 'package:auto_route/auto_route.dart';
import 'package:home_feature/router/home_router.dart';
import 'package:injectable/injectable.dart';

export 'package:home_feature/router/home_router.dart';

part 'app_router.gr.dart';

@singleton
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter() : super();

  final _homeRouter = HomeRouter();

  @override
  List<AutoRoute> get routes => [
        ..._homeRouter.routes,
      ];
}
