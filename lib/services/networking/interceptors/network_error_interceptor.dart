import 'package:dio/dio.dart';

class NetworkErrorInterceptor extends Interceptor {
  @override
  void onError(
    DioError dioError,
    ErrorInterceptorHandler handler,
  ) {
    //Convert to custom exception here or if in try catch then delete this interceptor
    return handler.next(dioError);
  }
}
