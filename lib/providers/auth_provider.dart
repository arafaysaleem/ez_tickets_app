import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../enums/user_role_enum.dart';

import '../services/networking/api_service.dart';

import 'all_providers.dart';

class AuthProvider {
  String token = "";
  late int currentUserID;
  final Reader _read;
  late final ApiService _apiService;

  AuthProvider(this._read){
    _apiService = _read(apiServiceProvider);
  }

  void login({required String email, required String password}) {}

  void register({
    required String email,
    required String password,
    required String fullName,
    required String contact,
    required String address,
    required UserRole role,
  }) {}

  void forgotPassword(String email) {}

  void resetPassword({required String email, required String password}) {}

  void changePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) {}

  void verifyOtp({required String email, required int otp}){}

  void refreshToken({required String oldToken}){}
}
