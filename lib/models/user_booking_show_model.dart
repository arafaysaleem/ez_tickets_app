import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/show_type_enum.dart';

part 'user_booking_show_model.freezed.dart';
part 'user_booking_show_model.g.dart';

@freezed
class UserBookingShowModel with _$UserBookingShowModel {
    @JsonSerializable(fieldRename: FieldRename.snake)
    const factory UserBookingShowModel({
      required int showId,
      required ShowType showType,
      required DateTime showDatetime,
    }) = _UserBookingShowModel;

    factory UserBookingShowModel.fromJson(Map<String, dynamic> json) => _$UserBookingShowModelFromJson(json);
}
