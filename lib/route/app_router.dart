import 'package:auto_route/auto_route.dart';
import 'package:home_feature/route/home_router.dart';
import 'package:home_feature/route/home_router.gm.dart';
import 'package:injectable/injectable.dart';

part 'app_router.gr.dart';

@singleton
@AutoRouterConfig(
    replaceInRouteName: 'Screen|Page,Route', modules: [HomeModule])
class AppRouter extends _$AppRouter {
  AppRouter() : super();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MainRoute.page,
          initial: true,
        ),
      ];
}
