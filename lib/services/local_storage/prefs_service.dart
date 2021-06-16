import 'dart:convert';

//services
import 'prefs_base.dart';

//models
import '../../models/user_model.dart';

//states
import '../../providers/states/auth_state.dart';

/// A service class for providing methods to store and retrieve data from
/// shared preferences.
class PrefsService {

  /// The name of auth token key
  static const _authTokenKey = "authToken";

  /// The name of auth state key
  static const _authStateKey = "authStateKey";

  /// The name of user password key
  static const _authPasswordKey = "authPasswordKey";

  /// The name of user model key
  static const _authUserKey = "authUserKey";

  ///Instance of prefs class
  final _prefs = PrefsBase.instance;

  ///Returns logged in user password
  String getAuthPassword() {
    return _prefs.get<String>(_authPasswordKey) ?? '';
  }

  ///Returns last authentication status
  bool getAuthState() {
    return _prefs.get<bool>(_authStateKey) ?? false;
  }

  ///Returns last authenticated user
  UserModel? getAuthUser() {
    final user = _prefs.get<String>(_authUserKey);
    if(user == null) return null;
    return UserModel.fromJson(jsonDecode(user));
  }

  ///Returns last authentication token
  String getAuthToken() {
    return _prefs.get<String>(_authTokenKey) ?? '';
  }

  ///Sets the authentication password to this value
  void setAuthPassword(String password) {
    _prefs.set<String>(_authPasswordKey, password);
  }

  ///Sets the authentication status to this value
  void setAuthState(AuthState authState) {
    if(authState is AUTHENTICATED) {
      _prefs.set<bool>(_authStateKey, true);
    }
  }

  ///Sets the authenticated user to this value
  void setAuthUser(UserModel user) {
    _prefs.set<String>(_authUserKey, jsonEncode(user.toJson()));
  }

  ///Sets the authentication token to this value
  void setAuthToken(String token) {
    _prefs.set<String>(_authTokenKey, token);
  }

  ///Resets the authentication
  void resetPrefs() {
    _prefs.clear();
  }
}
