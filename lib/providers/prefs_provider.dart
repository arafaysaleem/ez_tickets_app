//services
import '../services/local_storage/prefs.dart';

//states
import '../states/auth_state.dart';

class PrefsProvider {
  final authTokenKey = "authToken";
  final authenticatedKey = "authenticated";
  final userFullNameKey = "userFullName";
  final userEmailKey = "userEmailKey";
  final userPasswordKey = "userPasswordKey";
  final userIdKey = "userIdKey";

  ///Instance of prefs class
  final _prefs = Prefs.instance;

  ///Returns logged in user email
  String getAuthEmail() {
    return _prefs.get<String>(userEmailKey)!;
  }

  ///Returns logged in user password
  String getAuthPassword() {
    return _prefs.get<String>(userPasswordKey)!;
  }

  ///Returns logged in user id
  int getAuthId() {
    return _prefs.get<int>(userIdKey)!;
  }

  ///Returns last authentication status
  AuthState getAuthState() {
    final authenticated = _prefs.get<bool>(authenticatedKey);
    if(authenticated == null || !authenticated) {
      return AuthState.unauthenticated();
    }
    final fullName = _prefs.get<String>(userFullNameKey);
    return AuthState.authenticated(fullName: fullName!);
  }

  ///Returns last authentication token
  String getAuthToken() {
    return _prefs.get<String>(authTokenKey) ?? '';
  }

  ///Sets the authentication email to this value
  setAuthEmail(String email) {
    return _prefs.set<String>(userEmailKey, email);
  }

  ///Sets the authentication password to this value
  setAuthPassword(String password) {
    return _prefs.set<String>(userPasswordKey, password);
  }

  ///Sets the authentication id to this value
  setAuthId(int id) {
    return _prefs.set<int>(userIdKey, id);
  }

  ///Sets the authentication full name to this value
  setAuthFullName(String fullName) {
    return _prefs.set<String>(userFullNameKey, fullName);
  }

  ///Sets the authentication status to this value
  setAuthState(AuthState authState) {
    if(authState is AUTHENTICATED) {
      _prefs.set<bool>(authenticatedKey, true);
      _prefs.set<String>(userFullNameKey, authState.fullName);
    }
  }

  ///Sets the authentication token to this value
  setAuthToken(String token) {
    return _prefs.set<String>(authTokenKey, token);
  }

  ///Resets the authentication
  resetPrefs() {
    _prefs.clear();
  }
}
