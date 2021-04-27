import 'package:hooks_riverpod/hooks_riverpod.dart';

//enums
import '../enums/user_role_enum.dart';

//models
import '../models/user_model.dart';
import '../services/networking/network_exception.dart';

//services
import '../services/repositories/auth_repository.dart';

//states
import '../states/auth_state.dart';

//providers
import 'prefs_provider.dart';

class AuthProvider extends StateNotifier<AuthState> {
  late UserModel? _currentUser;
  final AuthRepository _authRepository;
  final PrefsProvider _prefsProvider;
  String token = "";

  AuthProvider(this._authRepository, this._prefsProvider)
      : super(AuthState.unauthenticated()) {
    init();
  }

  int get currentUserId => _currentUser!.userId;

  String get currentUserFullName => _currentUser!.fullName;

  String get currentUserEmail => _currentUser!.email;

  void init() {
    final authenticated = _prefsProvider.getAuthState();
    _currentUser = _prefsProvider.getAuthUser();
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
    state = AuthState.authenticating();
    try {
      _currentUser = await _authRepository.sendLoginData(data: data);
      state = AuthState.authenticated(fullName: _currentUser!.fullName);
      _updatePreferences(password);
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
    final Map<String, dynamic> data = {
      "email": email,
      "password": password,
      "full_name": fullName,
      "contact": contact,
      "address": address,
      "role": role.toJson,
    };
    state = AuthState.authenticating();
    try {
      _currentUser = await _authRepository.sendRegisterData(data: data);
      state = AuthState.authenticated(fullName: _currentUser!.fullName);
      _updatePreferences(password);
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
    if (result) _prefsProvider.setAuthPassword(password);
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
    if (result) _prefsProvider.setAuthPassword(newPassword);
    return result;
  }

  Future<bool> verifyOtp({required String email, required int otp}) async {
    final data = {
      "email": email,
      "OTP": otp,
    };
    return await _authRepository.sendOtpData(data: data);
  }

  void _updatePreferences(String password) {
    _prefsProvider.setAuthState(state);
    _prefsProvider.setAuthUser(_currentUser!);
    _prefsProvider.setAuthToken(token);
    _prefsProvider.setAuthPassword(password);
  }

  void logout() {
    token = "";
    _currentUser = null;
    state = AuthState.unauthenticated();
    _prefsProvider.resetPrefs();
  }
}
