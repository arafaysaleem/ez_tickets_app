import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: constant_identifier_names

/// A collection of types that a theater can be.
enum TheaterType {
@JsonValue("normal") NORMAL,
@JsonValue("royal") ROYAL,
}

/// A utility with extensions for enum name and serialized value.
extension ExtTheaterType on TheaterType{
  String get name => describeEnum(this);

  String get toJson => name.toLowerCase();
}


