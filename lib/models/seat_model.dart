import 'package:freezed_annotation/freezed_annotation.dart';

import '../helper/typedefs.dart';

part 'seat_model.freezed.dart';
part 'seat_model.g.dart';

@freezed
class SeatModel with _$SeatModel {
  const factory SeatModel({
    required String seatRow,
    required int seatNumber,
  }) = _SeatModel;

  factory SeatModel.fromJson(JSON json) => _$SeatModelFromJson(json);
}
