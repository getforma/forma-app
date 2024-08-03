import 'package:flutter/material.dart';
import 'package:forma_app/application/application.dart';
import 'package:forma_app/injection/injection.dart';
import 'package:forma_app/route/app_router.dart';
import 'package:forma_app/service/sensor_flutter_api.dart';
import 'package:forma_app/service/sensor_messages.g.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  SensorFlutterApi.setUp(SensorFlutterApiImpl());

  runApp(Application(appRouter: getIt.get<AppRouter>()));
}
