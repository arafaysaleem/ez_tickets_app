// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

//Screens
import '../views/screens/app_startup_screen.dart';
import '../views/screens/change_password_screen.dart';
import '../views/screens/confirmation_screen.dart';
import '../views/screens/forgot_password_screen.dart';
import '../views/screens/home_screen.dart';
import '../views/screens/login_screen.dart';
import '../views/screens/movie_details_screen.dart';
import '../views/screens/movies_screen.dart';
import '../views/screens/payment_screen.dart';
import '../views/screens/register_screen.dart';
import '../views/screens/shows_screen.dart';
import '../views/screens/theater_screen.dart';
import '../views/screens/ticket_summary_screen.dart';
import '../views/screens/trailer_screen.dart';
import '../views/screens/user_bookings_screen.dart';
import '../views/screens/welcome_screen.dart';

//Routes
import 'routes.dart';

/// A utility class provides basic methods for navigation.
/// This class has no constructor and all variables are `static`.
@immutable
class AppRouter {
  const AppRouter._();

  /// The global key used to access navigator without context
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// The name of the route that loads on app startup
  static const String initialRoute = Routes.AppStartupScreenRoute;

  /// This method is used when the app is navigating using named routes.
  ///
  /// It maps each route name to a specific screen route.
  ///
  /// In case of unknown route name, it returns a route indicating error.
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case Routes.AppStartupScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const AppStartupScreen(),
          settings: const RouteSettings(name: Routes.AppStartupScreenRoute),
        );
      case Routes.HomeScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const HomeScreen(),
          settings: const RouteSettings(name: Routes.HomeScreenRoute),
        );
      case Routes.LoginScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const LoginScreen(),
          settings: const RouteSettings(name: Routes.LoginScreenRoute),
        );
      case Routes.RegisterScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const RegisterScreen(),
          settings: const RouteSettings(name: Routes.RegisterScreenRoute),
        );
      case Routes.ForgotPasswordScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const ForgotPasswordScreen(),
          settings: const RouteSettings(name: Routes.ForgotPasswordScreenRoute),
        );
      case Routes.WelcomeScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const WelcomeScreen(),
          settings: const RouteSettings(name: Routes.WelcomeScreenRoute),
        );
      case Routes.ChangePasswordScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const ChangePasswordScreen(),
          settings: const RouteSettings(name: Routes.ChangePasswordScreenRoute),
        );
      case Routes.UserBookingsScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const UserBookingsScreen(),
          settings: const RouteSettings(name: Routes.UserBookingsScreenRoute),
        );
      case Routes.MoviesScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const MoviesScreen(),
          settings: const RouteSettings(name: Routes.MoviesScreenRoute),
        );
      case Routes.MovieDetailsScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const MovieDetailsScreen(),
          settings: const RouteSettings(name: Routes.MovieDetailsScreenRoute),
        );
      case Routes.TrailerScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const TrailerScreen(),
          settings: const RouteSettings(name: Routes.TrailerScreenRoute),
        );
      case Routes.ShowsScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const ShowsScreen(),
          settings: const RouteSettings(name: Routes.ShowsScreenRoute),
        );
      case Routes.TheaterScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const TheaterScreen(),
          settings: const RouteSettings(name: Routes.TheaterScreenRoute),
        );
      case Routes.TicketSummaryScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const TicketSummaryScreen(),
          settings: const RouteSettings(name: Routes.TicketSummaryScreenRoute),
        );
      case Routes.PaymentScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const PaymentScreen(),
          settings: const RouteSettings(name: Routes.PaymentScreenRoute),
        );
      case Routes.ConfirmationScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const ConfirmationScreen(),
          settings: const RouteSettings(name: Routes.ConfirmationScreenRoute),
        );
      default:
        return _errorRoute();
    }
  }

  /// This method returns an error page to indicate redirection to an
  /// unknown route.
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Unknown Route'),
        ),
        body: const Center(
          child: Text('Unknown Route'),
        ),
      ),
    );
  }

  /// This method is used to navigate to a screen using it's name
  static Future<dynamic> pushNamed(String routeName, {dynamic args}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: args);
  }

  /// This method is used to navigate back to the previous screen.
  ///
  /// The [result] can contain any value that we want to return to the previous
  /// screen.
  static Future<void> pop([dynamic result]) async {
    navigatorKey.currentState!.pop(result);
  }

  /// This method is used to navigate all the way back to a specific screen.
  ///
  /// The [routeName] is the name of the screen we want to go back to.
  static void popUntil(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  /// This method is used to navigate all the way back to the first screen
  /// shown on startup i.e. the [initialRoute].
  static void popUntilRoot() {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(initialRoute));
  }
}
