import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/show_status_enum.dart';
import '../enums/show_type_enum.dart';

part 'show_model.freezed.dart';
part 'show_model.g.dart';

T? toNull<T>(_) => null;

@freezed
class ShowModel with _$ShowModel {
  const ShowModel._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ShowModel({
    @JsonKey(toJson: toNull, includeIfNull: false)
    @Default(0) int showId,
    required DateTime date,
    required DateTime startTime,
    required DateTime endTime,
    required ShowStatus showStatus,
    required ShowType showType,
    required int movieId,
    required int theaterId,
  }) = _ShowModel;

  factory ShowModel.initial(){
    final dummyDate = DateTime.now();
    return ShowModel(
      date: dummyDate,
      startTime: dummyDate,
      endTime: dummyDate,
      movieId: 0,
      theaterId: 0,
      showType: ShowType.i2D,
      showStatus: ShowStatus.FREE
    );
  }

  factory ShowModel.fromJson(Map<String, dynamic> json) =>
      _$ShowModelFromJson(json);
}
