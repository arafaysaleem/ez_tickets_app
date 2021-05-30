import 'package:freezed_annotation/freezed_annotation.dart';

part 'seat_model.freezed.dart';
part 'seat_model.g.dart';

@freezed
class SeatModel with _$SeatModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SeatModel({
    required String seatRow,
    required int seatNumber,
  }) = _SeatModel;

  factory SeatModel.fromJson(Map<String, dynamic> json) => _$SeatModelFromJson(json);
}
