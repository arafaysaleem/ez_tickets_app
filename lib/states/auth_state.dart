import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.unauthenticated() = UNAUTHENTICATED;

  const factory AuthState.authenticating() = AUTHENTICATING;

  const factory AuthState.authenticated({required String fullName}) =
      AUTHENTICATED;

  const factory AuthState.failed({required String reason}) = FAILED;

  static AuthState fromString(String authState, [String? argument]) {
    switch (authState) {
      case "UNAUTHENTICATED":
        return AuthState.unauthenticated();
      case "AUTHENTICATING":
        return AuthState.authenticating();
      case "AUTHENTICATED":
        return AuthState.authenticated(fullName: argument!);
      case "FAILED":
        return AuthState.failed(reason: argument!);
      default:
        return AuthState.unauthenticated();
    }
  }

  @override
  String toString() {
    return this.when(
      unauthenticated: () => "UNAUTHENTICATED",
      authenticating: () => "AUTHENTICATING",
      authenticated: (_) => "AUTHENTICATED",
      failed: (_) => "FAILED",
    );
  }
}
