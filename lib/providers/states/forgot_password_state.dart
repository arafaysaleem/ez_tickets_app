import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_state.freezed.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.email() = FORGOT_PW_EMAIL;

  const factory ForgotPasswordState.otp({
    required String otpSentMessage,
  }) = FORGOT_PW_OTP;

  const factory ForgotPasswordState.resetPassword({
    required String otpVerifiedMessage,
  }) = FORGOT_PW_RESET_PASSWORD;

  const factory ForgotPasswordState.loading({
    required String loading,
  }) = LOADING;

  const factory ForgotPasswordState.failed({
    required String reason,
    required ForgotPasswordState lastState,
  }) = FORGOT_PW_FAILED;

  const factory ForgotPasswordState.success({
    String? success,
  }) = FORGOT_PW_SUCCESS;
}
