import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/booking_status_enum.dart';
import '../helper/utils/constants.dart';

part 'booking_model.freezed.dart';

part 'booking_model.g.dart';

@freezed
class BookingModel with _$BookingModel {
  const BookingModel._();

  @JsonSerializable()
  const factory BookingModel({
    @JsonKey(toJson: Constants.toNull, includeIfNull: false) required int? bookingId,
    @JsonKey(includeIfNull: false) required int? userId,
    required int showId,
    required String seatRow,
    required int seatNumber,
    required double price,
    required BookingStatus bookingStatus,
    required DateTime bookingDatetime,
  }) = _BookingModel;

  Map<String, dynamic> toUpdateJson({
    int? userId,
    int? showId,
    String? seatRow,
    int? seatNumber,
    double? price,
    BookingStatus? bookingStatus,
    DateTime? bookingDatetime,
  }) {
    if (userId == null &&
        showId == null &&
        seatRow == null &&
        seatNumber == null &&
        price == null &&
        bookingStatus == null &&
        bookingDatetime == null) return const {};
    return copyWith(
      userId: userId,
      showId: showId ?? this.showId,
      seatRow: seatRow ?? this.seatRow,
      seatNumber: seatNumber ?? this.seatNumber,
      price: price ?? this.price,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      bookingDatetime: bookingDatetime ?? this.bookingDatetime,
    ).toJson();
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);
}
