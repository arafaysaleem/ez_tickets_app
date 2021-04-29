import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

enum RoleType {
  @JsonValue("director") DIRECTOR,
  @JsonValue("producer") PRODUCER,
  @JsonValue("cast") CAST,
}

extension ExtRoleType on RoleType{
  String get name => describeEnum(this);

  String get toJson => this.name.toLowerCase();
}

