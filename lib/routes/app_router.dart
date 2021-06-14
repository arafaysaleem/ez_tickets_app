import 'package:auto_route/annotations.dart';

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

@MaterialAutoRouter(
    routes: <AutoRoute>[
      AutoRoute(page: AppStartupScreen, initial: true),
      AutoRoute(page: RegisterScreen),
      AutoRoute(page: LoginScreen),
      AutoRoute(page: MoviesScreen),
      AutoRoute(page: MovieDetailsScreen),
      AutoRoute(page: TrailerScreen),
      AutoRoute(page: ShowsScreen),
      AutoRoute(page: TheaterScreen),
      AutoRoute(page: TicketSummaryScreen),
      AutoRoute(page: PaymentScreen),
      AutoRoute(page: ConfirmationScreen),
      AutoRoute(page: UserBookingsScreen),
    ],
)
class $AppRouter{}
