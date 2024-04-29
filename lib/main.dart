import 'package:flutter/material.dart';
import 'package:forma_app/application/application.dart';
import 'package:forma_app/injection/injection.dart';
import 'package:forma_app/route/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  runApp(Application(appRouter: getIt.get<AppRouter>()));
}
