import '../../models/user_model.dart';
import '../networking/api_endpoint.dart';
import '../networking/api_service.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository({required ApiService apiService}) : _apiService = apiService;

  Future<UserModel> sendLoginData({required Map<String, dynamic> data}) async {
    return await _apiService.setData<UserModel>(
      endpoint: ApiEndpoint.auth(login: true),
      data: data,
      builder: (response) {
        _apiService.token = response["body"]["token"];
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
      builder: (response) {
        _apiService.token = response["body"]["token"];
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
      builder: (response) => response["headers"]["message"],
    );
  }

  Future<String> sendResetPasswordData({
    required Map<String, dynamic> data,
  }) async {
    return await _apiService.setData<String>(
      endpoint: ApiEndpoint.auth(resetPassword: true),
      data: data,
      builder: (response) => response["headers"]["message"],
    );
  }

  Future<String> sendChangePasswordData({
    required Map<String, dynamic> data,
  }) async {
    return await _apiService.setData<String>(
      endpoint: ApiEndpoint.auth(changePassword: true),
      data: data,
      builder: (response) => response["headers"]["message"],
    );
  }

  Future<String> sendOtpData({required Map<String, dynamic> data}) async {
    return await _apiService.setData<String>(
      endpoint: ApiEndpoint.auth(verifyOtp: true),
      data: data,
      builder: (response) => response["headers"]["message"],
    );
  }
}
