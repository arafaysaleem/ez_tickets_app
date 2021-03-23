import 'package:flutter/material.dart';

import 'helper/utils/custom_theme.dart';
import 'routes/router.gr.dart';

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
