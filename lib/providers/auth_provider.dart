//repositories
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/repositories/auth_repository.dart';

//enums
import '../enums/user_role_enum.dart';

//models
import '../models/user_model.dart';

//states
import '../states/auth_state.dart';

//services
import '../services/networking/network_exception.dart';

//TODO: Change to state notifier
//TODO: Generate auth states with freezed
//TODO: Set relevant state based on login/register
//TODO: Create auth_notifier_provider
//TODO: Read auth status in login_screen and show relevant page widget

class AuthProvider extends StateNotifier<AuthState>{
  late UserModel? _currentUser;
  final AuthRepository _authRepository;

  AuthProvider(this._authRepository) : super(AuthState.unauthenticated());

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
    } on NetworkException catch(e) {
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
    } on NetworkException catch(e) {
      state = AuthState.failed(reason: e.message);
    }
  }

  Future<String> forgotPassword(String email) async {
    final data = {"email": email};
    return await _authRepository.sendForgotPasswordData(data: data);
  }

  Future<String> resetPassword({
    required String email,
    required String password,
  }) async {
    final data = {"email": email, "password": password};
    return await _authRepository.sendResetPasswordData(data: data);
  }

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

  void logout(){
    _authRepository.eraseToken();
    _currentUser = null;
    state = AuthState.unauthenticated();
  }
}
