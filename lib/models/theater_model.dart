import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/theater_type_enum.dart';
import 'seat_model.dart';

part 'theater_model.freezed.dart';
part 'theater_model.g.dart';

@freezed
class TheaterModel with _$TheaterModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TheaterModel({
    required int theaterId,
    required String theaterName,
    required int numOfRows,
    required int seatsPerRow,
    required TheaterType theaterType,
    required List<SeatModel> missing,
    required List<SeatModel> blocked,
  }) = _TheaterModel;

  factory TheaterModel.fromJson(Map<String, dynamic> json) => _$TheaterModelFromJson(json);
}
