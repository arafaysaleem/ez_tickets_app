import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: constant_identifier_names

/// A collection of types that movies can be.
@JsonEnum()
enum MovieType {
  @JsonValue('now_showing') NOW_SHOWING,
  @JsonValue('coming_soon') COMING_SOON,
  @JsonValue('removed') REMOVED,
  ALL_MOVIES,
}

/// A utility with extensions for enum name and serialized value.
extension ExtMovieType on MovieType{
  String get toJson => name.toLowerCase();
}

