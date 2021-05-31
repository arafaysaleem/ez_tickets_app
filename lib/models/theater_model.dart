import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/theater_type_enum.dart';
import 'seat_model.dart';

part 'theater_model.freezed.dart';

part 'theater_model.g.dart';

T? toNull<T>(_) => null;

@freezed
class TheaterModel with _$TheaterModel {
  const TheaterModel._();

  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory TheaterModel({
    @JsonKey(toJson: toNull, includeIfNull: false) required int? theaterId,
    required String theaterName,
    required int numOfRows,
    required int seatsPerRow,
    required TheaterType theaterType,
    required List<SeatModel> missing,
    required List<SeatModel> blocked,
  }) = _TheaterModel;

  Map<String, dynamic> toUpdateJson({
    String? theaterName,
    int? numOfRows,
    int? seatsPerRow,
    TheaterType? theaterType,
    List<SeatModel>? missing,
    List<SeatModel>? blocked,
  }) {
    if (theaterName == null &&
        numOfRows == null &&
        seatsPerRow == null &&
        theaterType == null &&
        missing == null &&
        blocked == null
    ) return const {};
    return copyWith(
      theaterId: theaterId,
      numOfRows: numOfRows ?? this.numOfRows,
      seatsPerRow: seatsPerRow ?? this.seatsPerRow,
      theaterType: theaterType ?? this.theaterType,
      missing: missing ?? this.missing,
      blocked: blocked ?? this.blocked,
    ).toJson();
  }

  factory TheaterModel.fromJson(Map<String, dynamic> json) =>
      _$TheaterModelFromJson(json);
}