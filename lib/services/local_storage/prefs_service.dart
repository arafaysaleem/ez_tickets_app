import 'dart:convert';

//services
import 'prefs_base.dart';

//models
import '../../models/user_model.dart';

//states
import '../../providers/states/auth_state.dart';

class PrefsService {
  final authTokenKey = "authToken";
  final authStateKey = "authStateKey";
  final authPasswordKey = "authPasswordKey";
  final authUserKey = "authUserKey";

  ///Instance of prefs class
  final _prefs = PrefsBase.instance;

  ///Returns logged in user password
  String getAuthPassword() {
    return _prefs.get<String>(authPasswordKey) ?? '';
  }

  ///Returns last authentication status
  bool getAuthState() {
    return _prefs.get<bool>(authStateKey) ?? false;
  }

  ///Returns last authenticated user
  UserModel? getAuthUser() {
    final user = _prefs.get<String>(authUserKey);
    if(user == null) return null;
    return UserModel.fromJson(jsonDecode(user));
  }

  ///Returns last authentication token
  String getAuthToken() {
    return _prefs.get<String>(authTokenKey) ?? '';
  }

  ///Sets the authentication password to this value
  void setAuthPassword(String password) {
    _prefs.set<String>(authPasswordKey, password);
  }

  ///Sets the authentication status to this value
  void setAuthState(AuthState authState) {
    if(authState is AUTHENTICATED) {
      _prefs.set<bool>(authStateKey, true);
    }
  }

  ///Sets the authenticated user to this value
  void setAuthUser(UserModel user) {
    _prefs.set<String>(authUserKey, jsonEncode(user.toJson()));
  }

  ///Sets the authentication token to this value
  void setAuthToken(String token) {
    _prefs.set<String>(authTokenKey, token);
  }

  ///Resets the authentication
  void resetPrefs() {
    _prefs.clear();
  }
}
