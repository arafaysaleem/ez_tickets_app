import 'package:freezed_annotation/freezed_annotation.dart';

import 'booking_model.dart';
import 'user_booking_show_model.dart';

part 'user_booking_model.freezed.dart';
part 'user_booking_model.g.dart';

@freezed
class UserBookingModel with _$UserBookingModel {
    @JsonSerializable()
    const factory UserBookingModel({
      required String title,
      required String posterUrl,
      required UserBookingShowModel show,
      required List<BookingModel> bookings,
    }) = _UserBookingModel;

    factory UserBookingModel.fromJson(Map<String, dynamic> json) => _$UserBookingModelFromJson(json);
}
