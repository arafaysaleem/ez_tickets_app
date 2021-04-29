import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

enum MovieType {
  @JsonValue("now_showing") NOW_SHOWING,
  @JsonValue("coming_soon") COMING_SOON,
  @JsonValue("removed") REMOVED,
}

extension ExtMovieType on MovieType{
  String get name => describeEnum(this);

  String get toJson => this.name.toLowerCase();
}

