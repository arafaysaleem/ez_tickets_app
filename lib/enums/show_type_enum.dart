import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: constant_identifier_names

/// A collection of types that a show can be.
@JsonEnum()
enum ShowType {
  @JsonValue('2D') i2D,
  @JsonValue('3D') i3D,
}

/// A utility with extensions for enum name and serialized value.
extension ExtShowType on ShowType{
  String get inString => name.substring(1);  //removes i prefix
  String get toJson => inString;
}


