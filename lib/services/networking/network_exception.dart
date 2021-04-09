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

  const factory NetworkException.InvalidPropertiesException({
    required String name,
    required String message,
  }) = InvalidPropertiesException;

  const factory NetworkException.NotFoundException({
    required String name,
    required String message,
  }) = NotFoundException;

  const factory NetworkException.DuplicateEntryException({
    required String name,
    required String message,
  }) = DuplicateEntryException;

  const factory NetworkException.TokenMissingException({
    required String name,
    required String message,
  }) = TokenMissingException;

  const factory NetworkException.InternalServerException({
    required String name,
    required String message,
  }) = InternalServerException;

  const factory NetworkException.UnauthorizedException({
    required String name,
    required String message,
  }) = UnauthorizedException;

  const factory NetworkException.UnexpectedException({
    required String name,
    required String message,
  }) = UnexpectedException;

  const factory NetworkException.CreateFailedException({
    required String name,
    required String message,
  }) = CreateFailedException;

  const factory NetworkException.UpdateFailedException({
    required String name,
    required String message,
  }) = UpdateFailedException;

  const factory NetworkException.InvalidCredentialsException({
    required String name,
    required String message,
  }) = InvalidCredentialsException;

  const factory NetworkException.RegistrationFailedException({
    required String name,
    required String message,
  }) = RegistrationFailedException;

  const factory NetworkException.InvalidEndpointException({
    required String name,
    required String message,
  }) = InvalidEndpointException;

  const factory NetworkException.TokenVerificationException({
    required String name,
    required String message,
  }) = TokenVerificationException;

  const factory NetworkException.OTPGenerationException({
    required String name,
    required String message,
  }) = OTPGenerationException;

  const factory NetworkException.OTPExpiredException({
    required String name,
    required String message,
  }) = OTPExpiredException;

  const factory NetworkException.OTPVerificationException({
    required String name,
    required String message,
  }) = OTPVerificationException;

  const factory NetworkException.ForeignKeyViolationException({
    required String name,
    required String message,
  }) = ForeignKeyViolationException;

  const factory NetworkException.UnimplementedException({
    required String name,
    required String message,
  }) = UnimplementedException;

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
              case "InvalidPropertiesException":
                return NetworkException.InvalidPropertiesException(
                  name: name,
                  message: message,
                );
              case "NotFoundException":
                return NetworkException.NotFoundException(
                  name: name,
                  message: message,
                );
              case "DuplicateEntryException":
                return NetworkException.DuplicateEntryException(
                  name: name,
                  message: message,
                );
              case "TokenMissingException":
                return NetworkException.TokenMissingException(
                  name: name,
                  message: message,
                );
              case "InternalServerException":
                return NetworkException.InternalServerException(
                  name: name,
                  message: message,
                );
              case "UnauthorizedException":
                return NetworkException.UnauthorizedException(
                  name: name,
                  message: message,
                );
              case "UnexpectedException":
                return NetworkException.UnexpectedException(
                  name: name,
                  message: message,
                );
              case "CreateFailedException":
                return NetworkException.CreateFailedException(
                  name: name,
                  message: message,
                );
              case "UpdateFailedException":
                return NetworkException.UpdateFailedException(
                  name: name,
                  message: message,
                );
              case "InvalidCredentialsException":
                return NetworkException.InvalidCredentialsException(
                  name: name,
                  message: message,
                );
              case "RegistrationFailedException":
                return NetworkException.RegistrationFailedException(
                  name: name,
                  message: message,
                );
              case "InvalidEndpointException":
                return NetworkException.InvalidEndpointException(
                  name: name,
                  message: message,
                );
              case "TokenVerificationException":
                return NetworkException.TokenVerificationException(
                  name: name,
                  message: message,
                );
              case "OTPGenerationException":
                return NetworkException.OTPGenerationException(
                  name: name,
                  message: message,
                );
              case "OTPExpiredException":
                return NetworkException.OTPExpiredException(
                  name: name,
                  message: message,
                );
              case "OTPVerificationException":
                return NetworkException.OTPVerificationException(
                  name: name,
                  message: message,
                );
              case "ForeignKeyViolationException":
                return NetworkException.ForeignKeyViolationException(
                  name: name,
                  message: message,
                );
              case "UnimplementedException":
                return NetworkException.UnimplementedException(
                  name: name,
                  message: message,
                );
              default:
                return NetworkException.UnexpectedException(
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
        return NetworkException.UnexpectedException(
          name: "UnexpectedException",
          message: "Error unrecognized",
        );
      }
    } on FormatException catch (e) {
      return NetworkException.FormatException(
        name: "FormatException",
        message: e.message,
      );
    } catch (_) {
      return NetworkException.UnexpectedException(
        name: "UnexpectedException",
        message: "Error unrecognized",
      );
    }
  }
}
