import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {

  const factory AuthState.unauthenticated() = UNAUTHENTICATED;

  const factory AuthState.authenticating() = AUTHENTICATING;

  const factory AuthState.authenticated({required String fullName}) =
      AUTHENTICATED;

  const factory AuthState.failed({required String reason}) = FAILED;
}
