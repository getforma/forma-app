import 'package:flutter/material.dart';
import 'package:forma_app/application.dart';
import 'package:forma_app/injection/injection.dart';
import 'package:forma_app/route/app_router.dart';
import 'package:sensor_component_data/datasource/sensor_callback_api.dart';
import 'package:sensor_component_data/datasource/sensor_messages.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  SensorCallbackApi.setUp(SensorCallbackApiImpl());

  runApp(Application(appRouter: getIt.get<AppRouter>()));
}
