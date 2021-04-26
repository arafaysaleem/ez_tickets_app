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
      : super(AuthState.unauthenticated());

  int get currentUserId => _currentUser!.userId;

  void login({
    required String email,
    required String password,
  }) async {
    final data = {"email": email, "password": password};
    state = AuthState.authenticating();
    try {
      _currentUser = await _authRepository.sendLoginData(data: data);
      state = AuthState.authenticated(fullName: _currentUser!.fullName);
      _prefsProvider.setAuthFullName(_currentUser!.fullName);
      _prefsProvider.setAuthEmail(_currentUser!.email);
      _prefsProvider.setAuthId(_currentUser!.userId);
      _prefsProvider.setAuthPassword(password);
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
      _prefsProvider.setAuthFullName(fullName);
      _prefsProvider.setAuthEmail(email);
      _prefsProvider.setAuthId(_currentUser!.userId);
      _prefsProvider.setAuthPassword(password);
    } on NetworkException catch (e) {
      state = AuthState.failed(reason: e.message);
    }
  }

  Future<String> forgotPassword(String email) async {
    final data = {"email": email};
    return await _authRepository.sendForgotPasswordData(data: data);
  }

  //TODO: Change local prefs password
  Future<String> resetPassword({
    required String email,
    required String password,
  }) async {
    final data = {"email": email, "password": password};
    return await _authRepository.sendResetPasswordData(data: data);
  }

  //TODO: Change local prefs password
  Future<String> changePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    final data = {
      "email": email,
      "password": oldPassword,
      "new_password": newPassword,
    };
    return await _authRepository.sendChangePasswordData(data: data);
  }

  Future<String> verifyOtp({required String email, required int otp}) async {
    final data = {
      "email": email,
      "OTP": otp,
    };
    return await _authRepository.sendOtpData(data: data);
  }

  void logout() {
    _authRepository.eraseToken();
    _currentUser = null;
    state = AuthState.unauthenticated();
    _prefsProvider.resetPrefs();
  }
}
