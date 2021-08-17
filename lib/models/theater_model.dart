import 'package:freezed_annotation/freezed_annotation.dart';

import '../helper/utils/constants.dart';
import '../helper/typedefs.dart';
import '../enums/theater_type_enum.dart';
import 'seat_model.dart';

part 'theater_model.freezed.dart';

part 'theater_model.g.dart';

@freezed
class TheaterModel with _$TheaterModel {
  const TheaterModel._();

  const factory TheaterModel({
    @JsonKey(toJson: Constants.toNull, includeIfNull: false) required int? theaterId,
    required String theaterName,
    required int numOfRows,
    required int seatsPerRow,
    required TheaterType theaterType,
    required List<SeatModel> missing,
    required List<SeatModel> blocked,
  }) = _TheaterModel;

  JSON toUpdateJson({
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
    ) return const <String, Object>{};
    return copyWith(
      theaterId: theaterId,
      numOfRows: numOfRows ?? this.numOfRows,
      seatsPerRow: seatsPerRow ?? this.seatsPerRow,
      theaterType: theaterType ?? this.theaterType,
      missing: missing ?? this.missing,
      blocked: blocked ?? this.blocked,
    ).toJson();
  }

  factory TheaterModel.fromJson(JSON json) =>
      _$TheaterModelFromJson(json);
}
