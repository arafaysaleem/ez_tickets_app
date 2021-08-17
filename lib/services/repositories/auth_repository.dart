//models
import '../../models/user_model.dart';

//services
import '../networking/api_endpoint.dart';
import '../networking/api_service.dart';

//helpers
import '../../helper/typedefs.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository({required ApiService apiService}) : _apiService = apiService;

  Future<UserModel> sendLoginData({
    required JSON data,
    required void Function(String newToken) updateTokenCallback,
  }) async {
    return await _apiService.setData<UserModel>(
      endpoint: ApiEndpoint.auth(AuthEndpoint.LOGIN),
      data: data,
      requiresAuthToken: false,
      converter: (response) {
        updateTokenCallback(response['body']['token'] as String);
        return UserModel.fromJson(response['body'] as JSON);
      },
    );
  }

  Future<UserModel> sendRegisterData({
    required JSON data,
    required void Function(String newToken) updateTokenCallback,
  }) async {
    return await _apiService.setData<UserModel>(
      endpoint: ApiEndpoint.auth(AuthEndpoint.REGISTER),
      data: data,
      requiresAuthToken: false,
      converter: (response) {
        updateTokenCallback(response['body']['token'] as String);
        data['user_id'] = response['body']['user_id'];
        return UserModel.fromJson(data);
      },
    );
  }

  Future<String> sendForgotPasswordData({
    required JSON data,
  }) async {
    return await _apiService.setData<String>(
      endpoint: ApiEndpoint.auth(AuthEndpoint.FORGOT_PASSWORD),
      data: data,
      requiresAuthToken: false,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<String> sendResetPasswordData({
    required JSON data,
  }) async {
    return await _apiService.setData<String>(
      endpoint: ApiEndpoint.auth(AuthEndpoint.RESET_PASSWORD),
      data: data,
      requiresAuthToken: false,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<String> sendChangePasswordData({
    required JSON data,
  }) async {
    return await _apiService.setData<String>(
      endpoint: ApiEndpoint.auth(AuthEndpoint.CHANGE_PASSWORD),
      data: data,
      requiresAuthToken: false,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<String> sendOtpData({required JSON data}) async {
    return await _apiService.setData<String>(
      endpoint: ApiEndpoint.auth(AuthEndpoint.VERIFY_OTP),
      data: data,
      requiresAuthToken: false,
      converter: (response) => response['headers']['message'] as String,
    );
  }
}
