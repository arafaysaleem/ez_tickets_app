import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

enum UserRole {
  @JsonValue("admin") ADMIN,
  @JsonValue("api_user") API_USER,
  @JsonValue("super_user") SUPER_USER,
}

extension ExtUserRole on UserRole{
  String get name => describeEnum(this);

  String get toJson => this.name.toLowerCase();
}
