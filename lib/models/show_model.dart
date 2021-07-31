import 'package:clock/clock.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'show_time_model.dart';

part 'show_model.freezed.dart';
part 'show_model.g.dart';

@freezed
class ShowModel with _$ShowModel {
  const ShowModel._();

  @JsonSerializable()
  const factory ShowModel({
    required DateTime date,
    required int movieId,
    required List<ShowTimeModel> showTimes,
  }) = _ShowModel;

  factory ShowModel.initial(){
    return ShowModel(
      date: clock.now(),
      movieId: 0,
      showTimes: const []
    );
  }

  factory ShowModel.fromJson(Map<String, dynamic> json) =>
      _$ShowModelFromJson(json);
}
