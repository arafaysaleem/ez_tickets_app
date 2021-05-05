import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/all_providers.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (options.headers.containsKey("requiresAuthToken")) {
      if(options.headers["requiresAuthToken"]){
        final token = ProviderContainer().read(authProvider.notifier).token;
        options.headers.addAll({'Authorization': 'Bearer $token'});
      }

      options.headers.remove("requiresAuthToken");
    }
    return handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    final success = response.data["headers"]["success"] == 1;

    if (success) return handler.next(response);

    //Reject all error codes from server except 402 and 200 OK
    return handler.reject(
      DioError(
        requestOptions: response.requestOptions,
        response: response,
      ),
    );
  }
}
