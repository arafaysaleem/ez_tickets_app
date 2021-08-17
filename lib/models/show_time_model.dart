import 'package:clock/clock.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../helper/utils/constants.dart';
import '../helper/typedefs.dart';
import '../enums/show_status_enum.dart';
import '../enums/show_type_enum.dart';

part 'show_time_model.freezed.dart';
part 'show_time_model.g.dart';

@freezed
class ShowTimeModel with _$ShowTimeModel {
  const ShowTimeModel._();

  const factory ShowTimeModel({
    @JsonKey(toJson: Constants.toNull, includeIfNull: false)
    @Default(0) int showId,
    required DateTime startTime,
    required DateTime endTime,
    required ShowStatus showStatus,
    required ShowType showType,
    required int theaterId,
  }) = _ShowTimeModel;

  factory ShowTimeModel.initial(){
    final dummyTime = clock.now();
    return ShowTimeModel(
        startTime: dummyTime,
        endTime: dummyTime,
        theaterId: 0,
        showType: ShowType.i2D,
        showStatus: ShowStatus.FREE
    );
  }

  factory ShowTimeModel.fromJson(JSON json) =>
      _$ShowTimeModelFromJson(json);
}
