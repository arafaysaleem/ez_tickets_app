import 'package:hooks_riverpod/hooks_riverpod.dart';

//enums
import '../enums/user_role_enum.dart';

//models
import '../models/user_model.dart';

//services
import '../services/networking/api_endpoint.dart';
import '../services/networking/api_service.dart';

//providers
import 'all_providers.dart';

class AuthProvider {
  String token = "";

  late int _currentUserId;
  final Reader _read;
  late final ApiService _apiService;

  AuthProvider(this._read) {
    _apiService = _read(apiServiceProvider);
  }

  int get currentUserId => _currentUserId;

  Future<UserModel> login(
      {required String email, required String password}) async {
    final data = {"email": email, "password": password};
    final currentUser = await _apiService.setData<UserModel>(
      endpoint: ApiEndpoint.auth(login: true),
      data: data,
      builder: (response) {
        token = response["body"]["token"];
        return UserModel.fromJson(response["body"]);
      },
    );
    _currentUserId = currentUser.userId;
    return currentUser;
  }

  Future<String> register({
    required String email,
    required String password,
    required String fullName,
    required String contact,
    required String address,
    required UserRole role,
  }) async {
    final data = {
      "email": email,
      "password": password,
      "full_name": fullName,
      "contact": contact,
      "address": address,
      "role": role.toJson,
    };
    final message = await _apiService.setData<String>(
      endpoint: ApiEndpoint.auth(login: true),
      data: data,
      builder: (response) {
        token = response["body"]["token"];
        _currentUserId = response["body"]["user_id"];
        return response["headers"]["message"];
      },
    );
    return message;
  }

  Future<String> forgotPassword(String email) async {
    final data = {"email": email};
    final message = await _apiService.setData(
      endpoint: ApiEndpoint.auth(forgotPassword: true),
      data: data,
      builder: (response) => response["headers"]["message"],
    );
    return message;
  }

  Future<String> resetPassword({
    required String email,
    required String password,
  }) async {
    final data = {"email": email, "password": password};
    final message = await _apiService.setData(
      endpoint: ApiEndpoint.auth(resetPassword: true),
      data: data,
      builder: (response) => response["headers"]["message"],
    );
    return message;
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
    final message = await _apiService.setData(
      endpoint: ApiEndpoint.auth(changePassword: true),
      data: data,
      builder: (response) => response["headers"]["message"],
    );
    return message;
  }

  Future<String> verifyOtp({required String email, required int otp}) async {
    final data = {
      "email": email,
      "OTP": otp,
    };
    final message = await _apiService.setData(
      endpoint: ApiEndpoint.auth(changePassword: true),
      data: data,
      builder: (response) => response["headers"]["message"],
    );
    return message;
  }

  void refreshToken({required String oldToken}) {}
}
