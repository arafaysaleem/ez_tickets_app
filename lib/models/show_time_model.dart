import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/show_status_enum.dart';
import '../enums/show_type_enum.dart';

part 'show_time_model.freezed.dart';
part 'show_time_model.g.dart';

T? toNull<T>(_) => null;

@freezed
class ShowTimeModel with _$ShowTimeModel {
  const ShowTimeModel._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ShowTimeModel({
    @JsonKey(toJson: toNull, includeIfNull: false)
    @Default(0) int showId,
    required DateTime startTime,
    required DateTime endTime,
    required ShowStatus showStatus,
    required ShowType showType,
    required int theaterId,
  }) = _ShowTimeModel;

  factory ShowTimeModel.initial(){
    final dummyTime = DateTime.now();
    return ShowTimeModel(
        startTime: dummyTime,
        endTime: dummyTime,
        theaterId: 0,
        showType: ShowType.i2D,
        showStatus: ShowStatus.FREE
    );
  }

  factory ShowTimeModel.fromJson(Map<String, dynamic> json) =>
      _$ShowTimeModelFromJson(json);
}
