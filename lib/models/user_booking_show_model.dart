import 'package:freezed_annotation/freezed_annotation.dart';

import '../helper/typedefs.dart';
import '../enums/show_type_enum.dart';

part 'user_booking_show_model.freezed.dart';
part 'user_booking_show_model.g.dart';

@freezed
class UserBookingShowModel with _$UserBookingShowModel {
    const factory UserBookingShowModel({
      required int showId,
      required ShowType showType,
      required DateTime showDatetime,
    }) = _UserBookingShowModel;

    factory UserBookingShowModel.fromJson(JSON json) => _$UserBookingShowModelFromJson(json);
}
