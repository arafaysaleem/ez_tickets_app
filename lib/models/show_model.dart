import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/show_status_enum.dart';
import '../enums/show_type_enum.dart';

part 'show_model.freezed.dart';
part 'show_model.g.dart';

@freezed
class ShowModel with _$ShowModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ShowModel({
    required int showId,
    required DateTime date,
    required DateTime startTime,
    required DateTime endTime,
    required ShowStatus showStatus,
    required ShowType showType,
    required int movieId,
    required int theaterId,
  }) = _ShowModel;

  factory ShowModel.fromJson(Map<String, dynamic> json) =>
      _$ShowModelFromJson(json);
}
