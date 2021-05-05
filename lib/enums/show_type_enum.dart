import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: constant_identifier_names

enum ShowType {
  @JsonValue("2D") i2D,
  @JsonValue("3D") i3D,
}

extension ExtShowType on ShowType{
  String get name => describeEnum(this);
  String get toJson => name.substring(1).toLowerCase();
  String get inString => name.substring(1);  //removes i prefix
}


