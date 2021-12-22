import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: constant_identifier_names

/// A collection of types that movies can be.
@JsonEnum()
enum MovieType {
  NOW_SHOWING,
  COMING_SOON,
  REMOVED,
  ALL_MOVIES,
}

/// A utility with extensions for enum name and serialized value.
extension ExtMovieType on MovieType{
  String get toJson => name.toLowerCase();
}

