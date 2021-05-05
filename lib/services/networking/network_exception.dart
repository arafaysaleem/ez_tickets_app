import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exception.freezed.dart';

@freezed
class NetworkException with _$NetworkException {
  // ignore: non_constant_identifier_names
  const factory NetworkException.FormatException({
    required String name,
    required String message,
  }) = _FormatException;

  // ignore: non_constant_identifier_names
  const factory NetworkException.FetchDataException({
    required String name,
    required String message,
  }) = _FetchDataException;

  // ignore: non_constant_identifier_names
  const factory NetworkException.ApiException({
    required String name,
    required String message,
  }) = _ApiException;

  // ignore: non_constant_identifier_names
  const factory NetworkException.TokenExpiredException({
    required String name,
    required String message,
  }) = _TokenExpiredException;

  // ignore: non_constant_identifier_names
  const factory NetworkException.UnrecognizedException({
    required String name,
    required String message,
  }) = _UnrecognizedException;

  // ignore: non_constant_identifier_names
  const factory NetworkException.CancelException({
    required String name,
    required String message,
  }) = _CancelException;

  // ignore: non_constant_identifier_names
  const factory NetworkException.ConnectTimeoutException({
    required String name,
    required String message,
  }) = _ConnectTimeoutException;

  // ignore: non_constant_identifier_names
  const factory NetworkException.ReceiveTimeoutException({
    required String name,
    required String message,
  }) = _ReceiveTimeoutException;

  // ignore: non_constant_identifier_names
  const factory NetworkException.SendTimeoutException({
    required String name,
    required String message,
  }) = _SendTimeoutException;

  static NetworkException getDioException(Exception error) {
    try {
      if (error is DioError) {
        switch (error.type) {
          case DioErrorType.cancel:
            return NetworkException.CancelException(
              name: "CancelException",
              message: "Request cancelled prematurely",
            );
          case DioErrorType.connectTimeout:
            return NetworkException.ConnectTimeoutException(
              name: "ConnectTimeoutException",
              message: "Connection not established",
            );
          case DioErrorType.receiveTimeout:
            return NetworkException.SendTimeoutException(
              name: "SendTimeoutException",
              message: "Failed to send",
            );
          case DioErrorType.sendTimeout:
            return NetworkException.ReceiveTimeoutException(
              name: "ReceiveTimeoutException",
              message: "Failed to receive",
            );
          case DioErrorType.response:
          case DioErrorType.other:
            if(error.message.contains("SocketException")) {
              return NetworkException.FetchDataException(
                name: "FetchDataException",
                message: "No internet connectivity",
              );
            }
            final name = error.response?.data["headers"]["error"];
            final message = error.response?.data["headers"]["message"];
            switch (name) {
              case "TokenExpiredException":
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
        return NetworkException.UnrecognizedException(
          name: "UnrecognizedException",
          message: "Error unrecognized",
        );
      }
    } on FormatException catch (e) {
      return NetworkException.FormatException(
        name: "FormatException",
        message: e.message,
      );
    } on Exception catch (_) {
      return NetworkException.UnrecognizedException(
        name: "UnrecognizedException",
        message: "Error unrecognized",
      );
    }
  }
}
