// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

/// A utility class that holds screen names for named navigation.
/// This class has no constructor and all variables are `static`.
@immutable
class Routes {
  const Routes._();

  /// The name of the route for app startup screen
  static const String AppStartupScreenRoute = '/app-startup-screen';

  /// The name of the route for home screen.
  static const String HomeScreenRoute = '/home-screen';

  /// The name of the route for login screen.
  static const String LoginScreenRoute = '/login-screen';

  /// The name of the route for home screen.
  static const String RegisterScreenRoute = '/register-screen';

  /// The name of the route for login screen.
  static const String ForgotPasswordScreenRoute = '/forgot-password-screen';

  /// The name of the route for home screen.
  static const String WelcomeScreenRoute = '/welcome-screen';

  /// The name of the route for login screen.
  static const String ChangePasswordScreenRoute = '/change-password-screen';

  /// The name of the route for user bookings screen.
  static const String UserBookingsScreenRoute = '/user-bookings-screen';

  /// The name of the route for movies screen.
  static const String MoviesScreenRoute = '/movies-screen';

  /// The name of the route for movie details screen.
  static const String MovieDetailsScreenRoute = '/movie-details-screen';

  /// The name of the route for trailer screen.
  static const String TrailerScreenRoute = '/trailer-screen';

  /// The name of the route for shows screen.
  static const String ShowsScreenRoute = '/shows-screen';

  /// The name of the route for theater map screen.
  static const String TheaterScreenRoute = '/theater-screen';

  /// The name of the route for ticket summary screen.
  static const String TicketSummaryScreenRoute = '/ticket-summary-screen';

  /// The name of the route for payment screen.
  static const String PaymentScreenRoute = '/payment-screen';

  /// The name of the route for payment/booking confirmation screen.
  static const String ConfirmationScreenRoute = '/confirmation-screen';
}
