import 'package:freezed_annotation/freezed_annotation.dart';

import 'seat_model.dart';
import 'show_time_model.dart';
import 'theater_model.dart';

part 'show_seating_model.freezed.dart';

@freezed
class ShowSeatingModel with _$ShowSeatingModel {
  const factory ShowSeatingModel({
    required ShowTimeModel showTime,
    required TheaterModel theater,
    required List<SeatModel> bookedSeats,
  }) = _ShowSeatingModel;
}
