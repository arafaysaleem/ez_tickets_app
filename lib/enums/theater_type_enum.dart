import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: constant_identifier_names

enum TheaterType {
@JsonValue("normal") NORMAL,
@JsonValue("royal") ROYAL,
}

extension ExtMovieType on TheaterType{
  String get name => describeEnum(this);

  String get toJson => name.toLowerCase();
}


