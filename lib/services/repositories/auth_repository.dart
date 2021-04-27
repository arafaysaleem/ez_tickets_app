import 'package:hooks_riverpod/hooks_riverpod.dart';

//services
import '../networking/api_endpoint.dart';
import '../networking/api_service.dart';

//models
import '../../models/user_model.dart';

//providers
import '../../providers/all_providers.dart';

class AuthRepository {
  final ApiService _apiService;
  final Reader _read;

  AuthRepository({
    required ApiService apiService,
    required Reader reader,
  }) : _apiService = apiService, _read = reader;

  Future<UserModel> sendLoginData({required Map<String, dynamic> data}) async {
    return await _apiService.setData<UserModel>(
      endpoint: ApiEndpoint.auth(login: true),
      data: data,
      requiresAuthToken: false,
      builder: (response) {
        _read(authProvider.notifier).token = response["body"]["token"];
        return UserModel.fromJson(response["body"]);
      },
    );
  }

  Future<UserModel> sendRegisterData({
    required Map<String, dynamic> data,
  }) async {
    return await _apiService.setData<UserModel>(
      endpoint: ApiEndpoint.auth(register: true),
      data: data,
      requiresAuthToken: false,
      builder: (response) {
        _read(authProvider.notifier).token = response["body"]["token"];
        data["user_id"] = response["body"]["user_id"];
        return UserModel.fromJson(data);
      },
    );
  }

  Future<String> sendForgotPasswordData({
    required Map<String, dynamic> data,
  }) async {
    return await _apiService.setData<String>(
      endpoint: ApiEndpoint.auth(forgotPassword: true),
      data: data,
      requiresAuthToken: false,
      builder: (response) => response["headers"]["message"],
    );
  }

  Future<bool> sendResetPasswordData({
    required Map<String, dynamic> data,
  }) async {
    return await _apiService.setData<bool>(
      endpoint: ApiEndpoint.auth(resetPassword: true),
      data: data,
      requiresAuthToken: false,
      builder: (response) => response["headers"]["success"] == 1,
    );
  }

  Future<bool> sendChangePasswordData({
    required Map<String, dynamic> data,
  }) async {
    return await _apiService.setData<bool>(
      endpoint: ApiEndpoint.auth(changePassword: true),
      data: data,
      requiresAuthToken: false,
      builder: (response) => response["headers"]["success"] == 1,
    );
  }

  Future<bool> sendOtpData({required Map<String, dynamic> data}) async {
    return await _apiService.setData<bool>(
      endpoint: ApiEndpoint.auth(verifyOtp: true),
      data: data,
      requiresAuthToken: false,
      builder: (response) => response["headers"]["success"] == 1,
    );
  }
}
