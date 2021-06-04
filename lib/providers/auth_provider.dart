import 'package:hooks_riverpod/hooks_riverpod.dart';

//enums
import '../enums/user_role_enum.dart';

//models
import '../models/user_model.dart';

//services
import '../services/local_storage/prefs_service.dart';
import '../services/networking/network_exception.dart';
import '../services/repositories/auth_repository.dart';

//states
import 'states/auth_state.dart';

class AuthProvider extends StateNotifier<AuthState> {
  late UserModel? _currentUser;
  final AuthRepository _authRepository;
  final PrefsService _prefsService;
  String _token = "";
  String _password = "";

  AuthProvider(this._authRepository, this._prefsService)
      : super(const AuthState.unauthenticated()) {
    init();
  }

  int get currentUserId => _currentUser!.userId!;

  String get token => _token;

  String get currentUserFullName => _currentUser!.fullName;

  String get currentUserEmail => _currentUser!.email;

  String get currentUserAddress => _currentUser!.address;

  String get currentUserContact => _currentUser!.contact;

  String get currentUserPassword => _password;

  void updateToken(String value) {
    _token = value;
    _prefsService.setAuthToken(value);
  }

  void _updatePassword(String value) {
    _password = value;
    _prefsService.setAuthPassword(value);
  }

  void init() {
    final authenticated = _prefsService.getAuthState();
    _currentUser = _prefsService.getAuthUser();
    _password = _prefsService.getAuthPassword();
    _token = _prefsService.getAuthToken();
    if (!authenticated || _currentUser == null) {
      logout();
    } else {
      state = AuthState.authenticated(fullName: _currentUser!.fullName);
    }
  }

  void login({
    required String email,
    required String password,
  }) async {
    final data = {"email": email, "password": password};
    state = const AuthState.authenticating();
    try {
      _currentUser = await _authRepository.sendLoginData(
        data: data,
        updateTokenCallback: updateToken,
      );
      state = AuthState.authenticated(fullName: _currentUser!.fullName);
      _updatePassword(password);
      _updatePreferences();
    } on NetworkException catch (e) {
      state = AuthState.failed(reason: e.message);
    }
  }

  void register({
    required String email,
    required String password,
    required String fullName,
    required String contact,
    required String address,
    UserRole role = UserRole.API_USER,
  }) async {
    if (contact.startsWith("0")) contact = contact.substring(1);
    contact = "+92$contact";
    final user = UserModel(
      userId: null,
      fullName: fullName,
      email: email,
      address: address,
      contact: contact,
      role: role,
    );
    state = const AuthState.authenticating();
    try {
      _currentUser = await _authRepository.sendRegisterData(
        data: user.toJson(),
        updateTokenCallback: updateToken,
      );
      state = AuthState.authenticated(fullName: _currentUser!.fullName);
      _updatePassword(password);
      _updatePreferences();
    } on NetworkException catch (e) {
      state = AuthState.failed(reason: e.message);
    }
  }

  Future<String> forgotPassword(String email) async {
    final data = {"email": email};
    return await _authRepository.sendForgotPasswordData(data: data);
  }

  Future<bool> resetPassword({
    required String email,
    required String password,
  }) async {
    final data = {"email": email, "password": password};
    final result = await _authRepository.sendResetPasswordData(data: data);
    if (result) _updatePassword(password);
    return result;
  }

  Future<bool> changePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    final data = {
      "email": email,
      "password": oldPassword,
      "new_password": newPassword,
    };
    final result = await _authRepository.sendChangePasswordData(data: data);
    if (result) _updatePassword(newPassword);
    return result;
  }

  Future<bool> verifyOtp({required String email, required int otp}) async {
    final data = {
      "email": email,
      "OTP": otp,
    };
    return await _authRepository.sendOtpData(data: data);
  }

  void _updatePreferences() {
    _prefsService.setAuthState(state);
    _prefsService.setAuthUser(_currentUser!);
    _prefsService.setAuthToken(token);
  }

  void logout() {
    _token = "";
    _currentUser = null;
    _password = "";
    state = const AuthState.unauthenticated();
    _prefsService.resetPrefs();
  }
}
