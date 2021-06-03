import 'package:freezed_annotation/freezed_annotation.dart';

import 'booking_model.dart';

part 'user_booking_model.freezed.dart';
part 'user_booking_model.g.dart';

@freezed
class UserBookingModel with _$UserBookingModel {
    @JsonSerializable()
    const factory UserBookingModel({
      required int showId,
      required String title,
      required String posterUrl,
      required List<BookingModel> bookings,
    }) = _UserBookingModel;

    factory UserBookingModel.fromJson(Map<String, dynamic> json) => _$UserBookingModelFromJson(json);
}
