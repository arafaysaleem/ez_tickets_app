import 'package:hooks_riverpod/hooks_riverpod.dart';

//Services
import '../services/networking/network_exception.dart';

//Repositories
import '../services/repositories/auth_repository.dart';

//States
import 'states/forgot_password_state.dart';

class ForgotPasswordProvider extends StateNotifier<ForgotPasswordState> {
  final _otpDigits = ['0', '0', '0', '0'];
  final AuthRepository _authRepository;

  ForgotPasswordProvider(this._authRepository)
      : super(const ForgotPasswordState.email());

  String get _otpCode => _otpDigits.fold('', (otp, digit) => '$otp$digit');

  void setOtpDigit(int i, String digit) {
    _otpDigits[i] = digit;
  }

  Future<void> requestOtpCode(String email) async {
    final lastState = state;
    state = const ForgotPasswordState.loading(loading: 'Verifying user email');
    try {
      final data = {'email': email};
      final result = await _authRepository.sendForgotPasswordData(data: data);
      state = ForgotPasswordState.otp(otpSentMessage: result);
    } on NetworkException catch (e) {
      state = ForgotPasswordState.failed(
        reason: e.message,
        lastState: lastState,
      );
    }
  }

  Future<void> verifyOtp(String email) async {
    final lastState = state;
    state = const ForgotPasswordState.loading(loading: 'Verifying otp code');
    try {
      final data = {'email': email, 'OTP': int.tryParse(_otpCode)!};
      final result = await _authRepository.sendOtpData(data: data);
      state = ForgotPasswordState.resetPassword(otpVerifiedMessage: result);
    } on NetworkException catch (e) {
      state = ForgotPasswordState.failed(
        reason: e.message,
        lastState: lastState,
      );
    }
  }

  Future<void> resetPassword({
    required String email,
    required String password,
  }) async {
    final lastState = state;
    state = const ForgotPasswordState.loading(loading: 'Verifying otp code');
    try {
      final data = {'email': email, 'password': password};
      final result = await _authRepository.sendResetPasswordData(data: data);
      state = ForgotPasswordState.success(
        success: result,
      );
    } on NetworkException catch (e) {
      state = ForgotPasswordState.failed(
        reason: e.message,
        lastState: lastState,
      );
    }
  }

  void retryForgotPassword(ForgotPasswordState lastState) {
    state = lastState;
  }
}
