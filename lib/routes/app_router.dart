import 'package:auto_route/annotations.dart';
import 'package:ez_ticketz_app/views/screens/movies_screen.dart';

import '../views/screens/login_screen.dart';
import '../views/screens/register_screen.dart';
import '../views/screens/home_screen.dart';

@MaterialAutoRouter(
    routes: <AutoRoute>[
      AutoRoute(page: HomeScreen, initial: true),
      AutoRoute(page: RegisterScreen),
      AutoRoute(page: LoginScreen),
      AutoRoute(page: MoviesScreen),
    ],
    generateNavigationHelperExtension: true
)
class $AppRouter{}
