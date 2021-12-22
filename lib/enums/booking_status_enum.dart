import 'package:freezed_annotation/freezed_annotation.dart';
// ignore_for_file: constant_identifier_names

/// A collection of statuses that bookings can have.
@JsonEnum()
enum BookingStatus {
  CONFIRMED,
  CANCELLED,
  RESERVED,
}

/// A utility with extensions for enum name and serialized value.
extension ExtBookingStatus on BookingStatus{
  String get toJson => name.toLowerCase();
}


