import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exception.freezed.dart';

@freezed
abstract class NetworkException with _$NetworkException {
  const factory NetworkException.FormatException({
    required String name,
    required String message,
  }) = FormatException;

  const factory NetworkException.FetchDataException({
    required String name,
    required String message,
  }) = FetchDataException;

  const factory NetworkException.ApiException({
    required String name,
    required String message,
  }) = ApiException;

  const factory NetworkException.TokenExpiredException({
    required String name,
    required String message,
  }) = TokenExpiredException;

  const factory NetworkException.UnrecognizedException({
    required String name,
    required String message,
  }) = UnrecognizedException;

  const factory NetworkException.CancelException({
    required String name,
    required String message,
  }) = CancelException;

  const factory NetworkException.ConnectTimeoutException({
    required String name,
    required String message,
  }) = ConnectTimeoutException;

  const factory NetworkException.ReceiveTimeoutException({
    required String name,
    required String message,
  }) = ReceiveTimeoutException;

  const factory NetworkException.SendTimeoutException({
    required String name,
    required String message,
  }) = SendTimeoutException;

  static NetworkException getDioException(error) {
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
      } else if (error is SocketException) {
        return NetworkException.FetchDataException(
          name: "FetchDataException",
          message: "No internet connectivity",
        );
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
    } catch (_) {
      return NetworkException.UnrecognizedException(
        name: "UnrecognizedException",
        message: "Error unrecognized",
      );
    }
  }
}
