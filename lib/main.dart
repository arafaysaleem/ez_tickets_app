import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'helper/utils/custom_theme.dart';
import 'routes/app_router.gr.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint = setDebugPrint;
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

void setDebugPrint (String? message, {int? wrapWidth}) {
  final date = DateTime.now();
  String msg = "${date.year}/${date.month}/${date.day}";
  msg += " ${date.hour}:${date.minute}:${date.second}";
  msg += " $message";
  debugPrintSynchronously(
    msg,
    wrapWidth: wrapWidth,
  );
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
        title: 'EZ Tickets',
        theme: CustomTheme.mainTheme,
      ),
    );
  }
}
