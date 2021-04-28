//models
import '../../models/user_model.dart';

//services
import '../networking/api_endpoint.dart';
import '../networking/api_service.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository({required ApiService apiService}) : _apiService = apiService;

  Future<UserModel> sendLoginData({
    required Map<String, dynamic> data,
    required void Function(String newToken) updateTokenCallback,
  }) async {
    return await _apiService.setData<UserModel>(
      endpoint: ApiEndpoint.auth(login: true),
      data: data,
      requiresAuthToken: false,
      builder: (response) {
        updateTokenCallback(response["body"]["token"]);
        return UserModel.fromJson(response["body"]);
      },
    );
  }

  Future<UserModel> sendRegisterData({
    required Map<String, dynamic> data,
    required void Function(String newToken) updateTokenCallback,
  }) async {
    return await _apiService.setData<UserModel>(
      endpoint: ApiEndpoint.auth(register: true),
      data: data,
      requiresAuthToken: false,
      builder: (response) {
        updateTokenCallback(response["body"]["token"]);
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
