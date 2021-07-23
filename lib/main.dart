import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helper
import 'helper/utils/custom_theme.dart';

//Router
import 'routes/app_router.gr.dart';

//Services
import 'services/local_storage/key_value_storage_base.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint = setDebugPrint;
  await KeyValueStorageBase.init();
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

void setDebugPrint(String? message, {int? wrapWidth}) {
  final date = DateTime.now();
  var msg = "${date.year}/${date.month}/${date.day}";
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
