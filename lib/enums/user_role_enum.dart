import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: constant_identifier_names

/// A collection of roles that a user can be.
@JsonEnum()
enum UserRole {
  ADMIN,
  API_USER,
  SUPER_USER,
}

/// A utility with extensions for enum name and serialized value.
extension ExtUserRole on UserRole{
  String get toJson => name.toLowerCase();
}
