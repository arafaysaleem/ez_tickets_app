// ignore_for_file: non_constant_identifier_names
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

//Helpers
import '../../helper/utils/exception_constants.dart';

part 'network_exception.freezed.dart';

@freezed
class NetworkException with _$NetworkException {
  const factory NetworkException.FormatException({
    required String name,
    required String message,
  }) = _FormatException;

  const factory NetworkException.FetchDataException({
    required String name,
    required String message,
  }) = _FetchDataException;

  const factory NetworkException.ApiException({
    required String name,
    required String message,
  }) = _ApiException;

  const factory NetworkException.TokenExpiredException({
    required String name,
    required String message,
  }) = _TokenExpiredException;

  const factory NetworkException.UnrecognizedException({
    required String name,
    required String message,
  }) = _UnrecognizedException;

  const factory NetworkException.CancelException({
    required String name,
    required String message,
  }) = _CancelException;

  const factory NetworkException.ConnectTimeoutException({
    required String name,
    required String message,
  }) = _ConnectTimeoutException;

  const factory NetworkException.ReceiveTimeoutException({
    required String name,
    required String message,
  }) = _ReceiveTimeoutException;

  const factory NetworkException.SendTimeoutException({
    required String name,
    required String message,
  }) = _SendTimeoutException;

  static NetworkException getDioException(Exception error) {
    try {
      if (error is DioError) {
        switch (error.type) {
          case DioErrorType.cancel:
            return const NetworkException.CancelException(
              name: ExceptionConstants.CancelException,
              message: 'Request cancelled prematurely',
            );
          case DioErrorType.connectTimeout:
            return const NetworkException.ConnectTimeoutException(
              name: ExceptionConstants.ConnectTimeoutException,
              message: 'Connection not established',
            );
          case DioErrorType.sendTimeout:
            return const NetworkException.SendTimeoutException(
              name: ExceptionConstants.SendTimeoutException,
              message: 'Failed to send',
            );
          case DioErrorType.receiveTimeout:
            return const NetworkException.ReceiveTimeoutException(
              name: ExceptionConstants.ReceiveTimeoutException,
              message: 'Failed to receive',
            );
          case DioErrorType.response:
          case DioErrorType.other:
            if(error.message.contains(ExceptionConstants.SocketException)) {
              return const NetworkException.FetchDataException(
                name: ExceptionConstants.FetchDataException,
                message: 'No internet connectivity',
              );
            }
            final name = error.response?.data['headers']['error'] as String;
            final message = error.response?.data['headers']['message'] as String;
            switch (name) {
              case ExceptionConstants.TokenExpiredException:
                return NetworkException.TokenExpiredException(
                  name: name,
                  message: message,
                );
              default:
                return NetworkException.ApiException(
                  name: name,
                  message: message,
                );
            }
        }
      } else {
        return const NetworkException.UnrecognizedException(
          name: ExceptionConstants.UnrecognizedException,
          message: 'Error unrecognized',
        );
      }
    } on FormatException catch (e) {
      return NetworkException.FormatException(
        name: ExceptionConstants.FormatException,
        message: e.message,
      );
    } on Exception catch (_) {
      return const NetworkException.UnrecognizedException(
        name: ExceptionConstants.UnrecognizedException,
        message: 'Error unrecognized',
      );
    }
  }
}
