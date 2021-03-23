// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;

import '../views/screens/auth_screen.dart' as _i3;
import '../views/screens/welcome_screen.dart' as _i2;

class Router extends _i1.RootStackRouter {
  Router();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    WelcomeScreenRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i2.WelcomeScreen());
    },
    AuthScreenRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i3.AuthScreen());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(WelcomeScreenRoute.name, path: '/'),
        _i1.RouteConfig(AuthScreenRoute.name, path: '/auth-screen')
      ];
}

class WelcomeScreenRoute extends _i1.PageRouteInfo {
  const WelcomeScreenRoute() : super(name, path: '/');

  static const String name = 'WelcomeScreenRoute';
}

class AuthScreenRoute extends _i1.PageRouteInfo {
  const AuthScreenRoute() : super(name, path: '/auth-screen');

  static const String name = 'AuthScreenRoute';
}
