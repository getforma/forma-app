import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:forma_app/feature/main/main_screen.dart';

part 'app_router.gr.dart';

@singleton
@AutoRouterConfig()
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
