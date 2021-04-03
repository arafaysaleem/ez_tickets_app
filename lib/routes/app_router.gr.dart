// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;

import '../views/screens/home_screen.dart' as _i2;
import '../views/screens/login_screen.dart' as _i4;
import '../views/screens/movie_details_screen.dart' as _i6;
import '../views/screens/movies_screen.dart' as _i5;
import '../views/screens/register_screen.dart' as _i3;
import '../views/screens/shows_screen.dart' as _i7;

class AppRouter extends _i1.RootStackRouter {
  AppRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    HomeScreenRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i2.HomeScreen());
    },
    RegisterScreenRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i3.RegisterScreen());
    },
    LoginScreenRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i4.LoginScreen());
    },
    MoviesScreenRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i5.MoviesScreen());
    },
    MovieDetailsScreenRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i6.MovieDetailsScreen());
    },
    ShowsScreenRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i7.ShowsScreen());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(HomeScreenRoute.name, path: '/'),
        _i1.RouteConfig(RegisterScreenRoute.name, path: '/register-screen'),
        _i1.RouteConfig(LoginScreenRoute.name, path: '/login-screen'),
        _i1.RouteConfig(MoviesScreenRoute.name, path: '/movies-screen'),
        _i1.RouteConfig(MovieDetailsScreenRoute.name,
            path: '/movie-details-screen'),
        _i1.RouteConfig(ShowsScreenRoute.name, path: '/shows-screen')
      ];
}

class HomeScreenRoute extends _i1.PageRouteInfo {
  const HomeScreenRoute() : super(name, path: '/');

  static const String name = 'HomeScreenRoute';
}

class RegisterScreenRoute extends _i1.PageRouteInfo {
  const RegisterScreenRoute() : super(name, path: '/register-screen');

  static const String name = 'RegisterScreenRoute';
}

class LoginScreenRoute extends _i1.PageRouteInfo {
  const LoginScreenRoute() : super(name, path: '/login-screen');

  static const String name = 'LoginScreenRoute';
}

class MoviesScreenRoute extends _i1.PageRouteInfo {
  const MoviesScreenRoute() : super(name, path: '/movies-screen');

  static const String name = 'MoviesScreenRoute';
}

class MovieDetailsScreenRoute extends _i1.PageRouteInfo {
  const MovieDetailsScreenRoute() : super(name, path: '/movie-details-screen');

  static const String name = 'MovieDetailsScreenRoute';
}

class ShowsScreenRoute extends _i1.PageRouteInfo {
  const ShowsScreenRoute() : super(name, path: '/shows-screen');

  static const String name = 'ShowsScreenRoute';
}
