// ignore_for_file: constant_identifier_names
/// DO NOT USE 'dartfmt' on this file for formatting

class ApiEndpoint {
  static String auth(AuthEndpoint endpoint) {
    var path = "/auth";
    switch (endpoint) {
      case AuthEndpoint.REGISTER: return "$path/register";
      case AuthEndpoint.LOGIN: return "$path/login";
      case AuthEndpoint.REFRESH_TOKEN: return "$path/token";
      case AuthEndpoint.FORGOT_PASSWORD: return "$path/password/forgot";
      case AuthEndpoint.RESET_PASSWORD: return "$path/password/reset";
      case AuthEndpoint.CHANGE_PASSWORD: return "$path/password/change";
      case AuthEndpoint.VERIFY_OTP: return "$path/password/otp";
    }
  }

  static String users(UserEndpoint endpoint, {int? id}) {
    var path = "/users";
    switch(endpoint){
      case UserEndpoint.BASE: return path;
      case UserEndpoint.BY_ID: {
        assert(id != null, "userId is required for BY_ID endpoint");
        return "$path/id/$id";
      }
    }
  }

  static String movies(MovieEndpoint endpoint, {int? id}) {
    var path = "/movies";
    switch (endpoint) {
      case MovieEndpoint.BASE: return path;
      case MovieEndpoint.BY_ID: {
        assert(id != null, "movieId is required for BY_ID endpoint");
        return "$path/id/$id";
      }
      case MovieEndpoint.ROLES: {
        assert(id != null, "movieId is required for ROLES endpoint");
        return "$path/id/$id/roles";
      }
    }
  }

  static String roles(RoleEndpoint endpoint, {int? id}) {
    var path = "/roles";
    switch (endpoint) {
      case RoleEndpoint.BASE: return path;
      case RoleEndpoint.BY_ID: {
        assert(id != null, "roleId is required for BY_ID endpoint");
        return "$path/id/$id";
      }
      case RoleEndpoint.MOVIES: {
        assert(id != null, "roleId is required for MOVIES endpoint");
        return "$path/id/$id/movies";
      }
    }
  }

  static String shows(ShowEndpoint endpoint, {int? id}) {
    var path = "/shows";
    switch(endpoint){
      case ShowEndpoint.BASE: return path;
      case ShowEndpoint.FILTERS: return "$path/filters";
      case ShowEndpoint.BY_ID: {
        assert(id != null, "showId is required for BY_ID endpoint");
        return "$path/id/$id";
      }
    }
  }

  static String theaters(TheaterEndpoint endpoint, {int? id}) {
    var path = "/theaters";
    switch(endpoint){
      case TheaterEndpoint.BASE: return path;
      case TheaterEndpoint.BY_ID: {
        assert(id != null, "theaterId is required for BY_ID endpoint");
        return "$path/id/$id";
      }
    }
  }

  static String bookings(BookingEndpoint endpoint, {int? id}) {
    var path = "/bookings";
    switch(endpoint){
      case BookingEndpoint.BASE: return path;
      case BookingEndpoint.FILTERS: return "$path/filters";
      case BookingEndpoint.USERS: {
        assert(id != null, "bookingId is required for USERS endpoint");
        return "$path/users/$id";
      }
      case BookingEndpoint.SHOWS: {
        assert(id != null, "bookingId is required for SHOWS endpoint");
        return "$path/shows/$id";
      }
      case BookingEndpoint.BY_ID: {
        assert(id != null, "bookingId is required for BY_ID endpoint");
        return "$path/id/$id";
      }
    }
  }

  static String payments(PaymentEndpoint endpoint, {int? id}) {
    var path = "/payments";
    switch(endpoint){
      case PaymentEndpoint.BASE: return path;
      case PaymentEndpoint.USERS: {
        assert(id != null, "paymentId is required for USERS endpoint");
        return "$path/users/$id";
      }
      case PaymentEndpoint.BY_ID: {
        assert(id != null, "paymentId is required for BY_ID endpoint");
        return "$path/id/$id";
      }
    }
  }
}

enum AuthEndpoint {
  REGISTER, LOGIN, REFRESH_TOKEN,
  FORGOT_PASSWORD, RESET_PASSWORD, CHANGE_PASSWORD, VERIFY_OTP,
}

enum MovieEndpoint { BASE, BY_ID, ROLES }

enum UserEndpoint { BASE, BY_ID }

enum RoleEndpoint { BASE, BY_ID, MOVIES }

enum ShowEndpoint { BASE, BY_ID, FILTERS }

enum TheaterEndpoint { BASE, BY_ID }

enum BookingEndpoint { BASE, BY_ID, USERS, SHOWS, FILTERS }

enum PaymentEndpoint { BASE, BY_ID, USERS }

