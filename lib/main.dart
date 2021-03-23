import 'package:ez_ticketz_app/helper/utils/custom_theme.dart';
import 'package:flutter/material.dart';

import 'routes/router.gr.dart';
import 'package:auto_route/auto_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
      title: 'EZ Tickets',
      theme: CustomTheme.mainTheme,
    );
  }
}
