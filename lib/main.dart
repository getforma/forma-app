import 'package:flutter/material.dart';
import 'package:forma_app/application.dart';
import 'package:forma_app/injection/injection.dart';
import 'package:forma_app/route/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:sensor_component_data/datasource/sensor_callback_api.dart';
import 'package:sensor_component_data/datasource/sensor_messages.g.dart';
import 'package:core_component_data/database/app_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  final database = GetIt.I.get<AppDatabase>();

  final sensorCallbackApi = GetIt.I<SensorCallbackApiImpl>();
  SensorCallbackApi.setUp(sensorCallbackApi);

  runApp(Application(appRouter: getIt.get<AppRouter>()));
}
