import 'package:auto_route/annotations.dart';

import '../views/screens/auth_screen.dart';
import '../views/screens/welcome_screen.dart';

@MaterialAutoRouter(
    routes: <AutoRoute>[
      AutoRoute(page: WelcomeScreen, initial: true),
      AutoRoute(page: AuthScreen),
    ]
)
class $Router{}
