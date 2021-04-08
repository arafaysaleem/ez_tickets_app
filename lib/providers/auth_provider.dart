//repositories
import '../services/repositories/auth_repository.dart';

//enums
import '../enums/user_role_enum.dart';

//models
import '../models/user_model.dart';

//TODO: Change to state notifier
//TODO: Generate auth states with freezed
//TODO: Set relevant state based on login/register
//TODO: Create logout method
//TODO: Create auth_notifier_provider
//TODO: Read auth status in login_screen and show relevant page widget

class AuthProvider {
  late UserModel _currentUser;
  final AuthRepository _authRepository;

  AuthProvider(this._authRepository);

  int get currentUserId => _currentUser.userId;

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    final data = {"email": email, "password": password};
    _currentUser = await _authRepository.sendLoginData(data: data);
    print(_currentUser);
    return true;
  }

  Future<bool> register({
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
    _currentUser = await _authRepository.sendRegisterData(data: data);
    print(_currentUser);
    return true;
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
}
