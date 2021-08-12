import 'package:hooks_riverpod/hooks_riverpod.dart';

//Enums
import '../enums/user_role_enum.dart';

//Models
import '../models/user_model.dart';

//Services
import '../services/local_storage/key_value_storage_service.dart';
import '../services/networking/network_exception.dart';
import '../services/repositories/auth_repository.dart';

//States
import 'states/auth_state.dart';
import 'states/forgot_password_state.dart';
import 'states/future_state.dart';

final changePasswordStateProvider = StateProvider(
  (ref) => const FutureState<String>.idle(),
);

final forgotPasswordStateProvider = StateProvider(
  (ref) => const ForgotPasswordState.email(),
);

class AuthProvider extends StateNotifier<AuthState> {
  late UserModel? _currentUser;
  final AuthRepository _authRepository;
  final KeyValueStorageService _keyValueStorageService;
  final Reader _reader;
  String _password = '';

  AuthProvider({
    required AuthRepository authRepository,
    required KeyValueStorageService keyValueStorageService,
    required Reader reader,
  })  : _authRepository = authRepository,
        _keyValueStorageService = keyValueStorageService,
        _reader = reader,
        super(const AuthState.unauthenticated()) {
    init();
  }

  int get currentUserId => _currentUser!.userId!;

  String get currentUserFullName => _currentUser!.fullName;

  String get currentUserEmail => _currentUser!.email;

  String get currentUserAddress => _currentUser!.address;

  String get currentUserContact => _currentUser!.contact;

  String get currentUserPassword => _password;

  void updateToken(String value) {
    _keyValueStorageService.setAuthToken(value);
  }

  void _updatePassword(String value) {
    _password = value;
    _keyValueStorageService.setAuthPassword(value);
  }

  void init() async {
    final authenticated = _keyValueStorageService.getAuthState();
    _currentUser = _keyValueStorageService.getAuthUser();
    _password = await _keyValueStorageService.getAuthPassword();
    if (!authenticated || _currentUser == null || _password.isEmpty) {
      logout();
    } else {
      state = AuthState.authenticated(fullName: _currentUser!.fullName);
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final data = {'email': email, 'password': password};
    state = const AuthState.authenticating();
    try {
      _currentUser = await _authRepository.sendLoginData(
        data: data,
        updateTokenCallback: updateToken,
      );
      state = AuthState.authenticated(fullName: _currentUser!.fullName);
      _updatePassword(password);
      _updateAuthProfile();
    } on NetworkException catch (e) {
      state = AuthState.failed(reason: e.message);
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String fullName,
    required String contact,
    required String address,
    UserRole role = UserRole.API_USER,
  }) async {
    if (contact.startsWith('0')) contact = contact.substring(1);
    contact = '+92$contact';
    final user = UserModel(
      userId: null,
      fullName: fullName,
      email: email,
      address: address,
      contact: contact,
      role: role,
    );
    state = const AuthState.authenticating();
    try {
      _currentUser = await _authRepository.sendRegisterData(
        data: user.toJson(),
        updateTokenCallback: updateToken,
      );
      state = AuthState.authenticated(fullName: _currentUser!.fullName);
      _updatePassword(password);
      _updateAuthProfile();
    } on NetworkException catch (e) {
      state = AuthState.failed(reason: e.message);
    }
  }

  Future<void> forgotPassword(String email) async {
    final data = {'email': email};
    final _forgotPasswordState = _reader(forgotPasswordStateProvider);
    _forgotPasswordState.state = const ForgotPasswordState.loading(
      loading: 'Verifying user email',
    );
    try {
      final result = await _authRepository.sendForgotPasswordData(data: data);
      _forgotPasswordState.state = ForgotPasswordState.otp(
        otpSentMessage: result,
      );
    } on NetworkException catch (e) {
      _forgotPasswordState.state = ForgotPasswordState.failed(reason: e.message);
    }
  }

  Future<void> verifyOtp({required String email, required String otp}) async {
    final data = {
      'email': email,
      'OTP': int.tryParse(otp)!,
    };
    final _forgotPasswordState = _reader(forgotPasswordStateProvider);
    _forgotPasswordState.state = const ForgotPasswordState.loading(
      loading: 'Verifying otp code',
    );
    try {
      final result = await _authRepository.sendOtpData(data: data);
      _forgotPasswordState.state = ForgotPasswordState.resetPassword(
        otpVerifiedMessage: result,
      );
    } on NetworkException catch (e) {
      _forgotPasswordState.state = ForgotPasswordState.failed(reason: e.message);
    }
  }

  Future<void> resetPassword({
    required String email,
    required String password,
  }) async {
    final data = {'email': email, 'password': password};
    final _forgotPasswordState = _reader(forgotPasswordStateProvider);
    _forgotPasswordState.state = const ForgotPasswordState.loading(
      loading: 'Verifying otp code',
    );
    try {
      final result = await _authRepository.sendResetPasswordData(data: data);
      _forgotPasswordState.state = ForgotPasswordState.success(
        success: result,
      );
    } on NetworkException catch (e) {
      _forgotPasswordState.state = ForgotPasswordState.failed(reason: e.message);
    }
  }

  Future<void> changePassword({required String newPassword}) async {
    final data = {
      'email': currentUserEmail,
      'password': currentUserPassword,
      'new_password': newPassword,
    };
    final _changePasswordState = _reader(changePasswordStateProvider);
    _changePasswordState.state = const FutureState.loading();
    try {
      final result = await _authRepository.sendChangePasswordData(data: data);
      _updatePassword(newPassword);
      _changePasswordState.state = FutureState.data(data: result);
    } on NetworkException catch (e) {
      _changePasswordState.state = FutureState.failed(reason: e.message);
    }
  }

  void _updateAuthProfile() {
    _keyValueStorageService.setAuthState(state);
    _keyValueStorageService.setAuthUser(_currentUser!);
  }

  void logout() {
    _currentUser = null;
    _password = '';
    state = const AuthState.unauthenticated();
    _keyValueStorageService.resetKeys();
  }
}
