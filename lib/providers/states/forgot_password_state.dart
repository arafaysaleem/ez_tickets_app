import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_state.freezed.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.email() = EMAIL;

  const factory ForgotPasswordState.otp({
    required String otpSentMessage,
  }) = OTP;

  const factory ForgotPasswordState.resetPassword({
    required String otpVerifiedMessage,
  }) = RESET_PASSWORD;

  const factory ForgotPasswordState.loading({required String loading}) =
      LOADING;

  const factory ForgotPasswordState.failed({
    required String reason,
    required ForgotPasswordState lastState,
  }) = FAILED;

  const factory ForgotPasswordState.success({String? success}) = SUCCESS;
}
