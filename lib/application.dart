import 'package:auto_route/auto_route.dart';
import 'package:core_feature/generated/l10n.dart';
import 'package:core_feature/style/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'route/app_router.dart';

class Application extends StatefulWidget {
  final AppRouter _appRouter;

  const Application({
    required AppRouter appRouter,
    super.key,
  }) : _appRouter = appRouter;

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852), // iPhone 15 Pro
      child: MaterialApp.router(
        themeMode: ThemeMode.light,
        theme: AppThemes.light,
        darkTheme: AppThemes.dark,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        routeInformationParser: widget._appRouter.defaultRouteParser(),
        routerDelegate: AutoRouterDelegate(
          widget._appRouter,
        ),
      ),
    );
  }
}
