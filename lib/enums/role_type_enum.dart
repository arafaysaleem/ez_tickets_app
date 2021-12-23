import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: constant_identifier_names

import '../helper/extensions/string_extension.dart';

/// A collection of roles that movie actors can have.
@JsonEnum()
enum RoleType {
  @JsonValue('director') DIRECTOR,
  @JsonValue('producer') PRODUCER,
  @JsonValue('cast') CAST,
}

/// A utility with extensions for enum name and serialized value.
extension ExtRoleType on RoleType{
  String get toJson => name.toLowerCase();
  String get inString => name.capitalize;
}

