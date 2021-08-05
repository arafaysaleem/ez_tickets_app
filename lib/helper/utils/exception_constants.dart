// ignore_for_file: constant_identifier_names
import 'package:flutter/foundation.dart';

/// A utility class that holds constants for our custom exception names.
/// This class has no constructor and all variables are `static`.
@immutable
class ExceptionConstants {
  const ExceptionConstants._();

  /// The name of the exception for an expired bearer token.
  static const String TokenExpiredException = 'TokenExpiredException';

  /// The name of the exception for a prematurely cancelled request.
  static const String CancelException = 'CancelException';

  /// The name of the exception for a failed connection attempt.
  static const String ConnectTimeoutException = 'ConnectTimeoutException';

  /// The name of the exception for failing to send a request.
  static const String SendTimeoutException = 'SendTimeoutException';

  /// The name of the exception for failing to receive a response.
  static const String ReceiveTimeoutException = 'ReceiveTimeoutException';

  /// The name of the exception for no internet connectivity.
  static const String SocketException = 'SocketException';

  /// A better name for the socket exception.
  static const String FetchDataException = 'FetchDataException';

  /// The name of the exception for an incorrect parameter in a request/response.
  static const String FormatException = 'FormatException';

  /// The name of the exception for an unknown type of failure.
  static const String UnrecognizedException = 'UnrecognizedException';
}
