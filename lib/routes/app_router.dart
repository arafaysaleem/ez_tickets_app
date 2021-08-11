import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../views/screens/app_startup_screen.dart';
import '../views/screens/login_screen.dart';
import '../views/screens/register_screen.dart';
import '../views/screens/movies_screen.dart';
import '../views/screens/movie_details_screen.dart';
import '../views/screens/trailer_screen.dart';
import '../views/screens/shows_screen.dart';
import '../views/screens/theater_screen.dart';
import '../views/screens/ticket_summary_screen.dart';
import '../views/screens/payment_screen.dart';
import '../views/screens/confirmation_screen.dart';
import '../views/screens/user_bookings_screen.dart';
import '../views/screens/change_password_screen.dart';
import '../views/screens/forgot_password_screen.dart';

@MaterialAutoRouter(
    routes: <AutoRoute>[
      AutoRoute<Widget>(page: AppStartupScreen, initial: true),
      AutoRoute<Widget>(page: RegisterScreen),
      AutoRoute<Widget>(page: LoginScreen),
      AutoRoute<Widget>(page: MoviesScreen),
      AutoRoute<Widget>(page: MovieDetailsScreen),
      AutoRoute<Widget>(page: TrailerScreen),
      AutoRoute<Widget>(page: ShowsScreen),
      AutoRoute<Widget>(page: TheaterScreen),
      AutoRoute<Widget>(page: TicketSummaryScreen),
      AutoRoute<Widget>(page: PaymentScreen),
      AutoRoute<Widget>(page: ConfirmationScreen),
      AutoRoute<Widget>(page: UserBookingsScreen),
      AutoRoute<Widget>(page: ChangePasswordScreen),
      AutoRoute<Widget>(page: ForgotPasswordScreen),
    ],
)
class $AppRouter{}
