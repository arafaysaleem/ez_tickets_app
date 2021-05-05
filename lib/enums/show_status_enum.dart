import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: constant_identifier_names

import '../helper/extensions/string_extension.dart';

enum ShowStatus {
  @JsonValue("free") FREE,
  @JsonValue("almost_free") ALMOST_FULL,
  @JsonValue("full") FULL,
}

extension ExtShowStatus on ShowStatus{
  String get name => describeEnum(this);
  String get toJson => name.toLowerCase();
  String get inString => name.removeUnderScore.toUpperCase();
}


