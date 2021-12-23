import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: constant_identifier_names

import '../helper/extensions/string_extension.dart';

/// A collection of payment methods that a user can choose.
@JsonEnum()
enum PaymentMethod {
  @JsonValue('cash') CASH,
  @JsonValue('cod') COD,
  @JsonValue('card') CARD,
}

/// A utility with extensions for enum name and serialized value.
extension ExtPaymentMethod on PaymentMethod {
  String get toJson => name.toLowerCase();
  String get inString => name.capitalize;
}