import 'package:freezed_annotation/freezed_annotation.dart';

enum UserRole {
  @JsonValue("admin") ADMIN,
  @JsonValue("api_user") API_USER,
  @JsonValue("super_user") SUPER_USER,
}
