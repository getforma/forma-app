import 'dart:async';

import 'package:core_component_data/database/app_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:forma_app/application.dart';
import 'package:forma_app/firebase_options.dart';
import 'package:forma_app/injection/injection.dart';
import 'package:forma_app/route/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:sensor_component_data/datasource/sensor_callback_api.dart';
import 'package:sensor_component_data/datasource/sensor_messages.g.dart';
import 'package:sensor_component_data/datasource/sensor_store_worker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  GetIt.I.get<AppDatabase>();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final worker = GetIt.I.get<SensorStoreWorker>();
  await worker.initialize();

  final sensorCallbackApi = GetIt.I<SensorCallbackApiImpl>();
  SensorCallbackApi.setUp(sensorCallbackApi);

  runApp(Application(appRouter: getIt.get<AppRouter>()));
}
