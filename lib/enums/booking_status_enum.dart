import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: constant_identifier_names

enum BookingStatus {
@JsonValue("confirmed") CONFIRMED,
@JsonValue("cancelled") CANCELLED,
@JsonValue("reserved") RESERVED,
}

extension ExtMovieType on BookingStatus{
  String get name => describeEnum(this);

  String get toJson => name.toLowerCase();
}


