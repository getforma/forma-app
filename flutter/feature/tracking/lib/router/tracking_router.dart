import 'package:auto_route/auto_route.dart';
import 'package:tracking_feature/router/tracking_router.gr.dart';

@AutoRouterConfig()
class TrackingRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: TrackingRoute.page),
      ];
}
