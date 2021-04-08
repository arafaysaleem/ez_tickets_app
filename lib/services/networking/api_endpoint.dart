class ApiEndpoint {
  static String auth({
    bool register = false,
    bool login = false,
    bool forgotPassword = false,
    bool resetPassword = false,
    bool changePassword = false,
    bool verifyOtp = false,
  }) {
    String path = "/auth";
    if (register)
      path = path + "/register";
    else if (login)
      path = path + "/login";
    else {
      path = path + "/password";
      if (forgotPassword)
        path = path + "/forgot";
      else if (resetPassword)
        path = path + "/reset";
      else if (changePassword)
        path = path + "/change";
      else if (verifyOtp) path = path + "/otp";
    }
    return path;
  }

  static String users({int? id}) {
    String path = "/users";
    if (id != null) path = path + "/id/$id";
    return path;
  }

  static String movies({int? id, bool searchRoles = false}) {
    String path = "/movies";
    if (id != null) path = path + "/id/$id";
    if (searchRoles) path = path + "/roles";
    return path;
  }

  static String roles({int? id, bool searchMovies = false}) {
    String path = "/roles";
    if (id != null) path = path + "/id/$id";
    if (searchMovies) path = path + "/movies";
    return path;
  }

  static String shows({int? id, bool filters = false}) {
    String path = "/shows";
    if (id != null)
      path = path + "/id/$id";
    else if (filters) path = path + "/filters";
    return path;
  }

  static String theaters({int? id}) {
    String path = "/theaters";
    if (id != null) path = path + "/id/$id";
    return path;
  }

  static String bookings({
    int? id,
    bool filters = false,
    bool searchUsers = false,
    bool searchShows = false,
  }) {
    String path = "/bookings";
    if (searchUsers) path = path + "/users/$id";
    else if(searchShows) path = path + "/shows/$id";
    else if (filters) path = path + "/filters";
    else if (id != null) path = path + "/id/$id";
    return path;
  }

  static String payments({
    int? id,
    bool filters = false,
    bool searchUsers = false,
    bool searchShows = false,
  }) {
    String path = "/payments";
    if (searchUsers) path = path + "/users/$id";
    else if (id != null) path = path + "/id/$id";
    return path;
  }
}