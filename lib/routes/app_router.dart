import 'package:auto_route/annotations.dart';

import '../views/screens/login_screen.dart';
import '../views/screens/register_screen.dart';
import '../views/screens/home_screen.dart';

@MaterialAutoRouter(
    routes: <AutoRoute>[
      AutoRoute(page: HomeScreen, initial: true),
      AutoRoute(page: RegisterScreen),
      AutoRoute(page: LoginScreen),
    ],
    generateNavigationHelperExtension: true
)
class $AppRouter{}
