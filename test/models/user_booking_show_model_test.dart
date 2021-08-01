import 'package:flutter_test/flutter_test.dart';

import 'package:ez_ticketz_app/enums/show_type_enum.dart';
import 'package:ez_ticketz_app/models/user_booking_show_model.dart';

void main() {
  group('fromJson', () {
    test(
      'GIVEN a valid user booking show json '
      'WHEN a json deserialization is performed '
      'THEN a user booking show model is output',
      () {
        //given
        final json = {
          'show_id': 1,
          'show_type': '2D',
          'show_datetime': '2012-02-27T13:27:00.000',
        };

        //when
        final actual = UserBookingShowModel.fromJson(json);
        final matcher = UserBookingShowModel(
          showId: 1,
          showType: ShowType.i2D,
          showDatetime: DateTime(2012, 2, 27, 13, 27, 0),
        );

        //then
        expect(actual, matcher);
      },
    );
  });

  group('toJson', () {
    test(
      'GIVEN a user booking show model '
      'WHEN a json serialization is performed '
      'THEN a user booking show json is output',
      () {
        //given
        final userBookingShowModel = UserBookingShowModel(
          showId: 1,
          showType: ShowType.i2D,
          showDatetime: DateTime(2012, 2, 27, 13, 27, 0),
        );

        //when
        final actual = userBookingShowModel.toJson();
        final matcher = {
          'show_id': 1,
          'show_type': '2D',
          'show_datetime': '2012-02-27T13:27:00.000',
        };

        //then
        expect(actual, matcher);
      },
    );
  });

  group('equality', () {
    test(
      'GIVEN two user booking show models '
      'WHEN properties are different '
      'THEN equality returns false',
      () {
        //given
        final userBookingShow1 = UserBookingShowModel(
          showId: 1,
          showType: ShowType.i2D,
          showDatetime: DateTime(2012, 2, 27, 13, 27, 0),
        );

        //when
        final userBookingShow2 = UserBookingShowModel(
          showId: 1,
          showType: ShowType.i3D,
          showDatetime: DateTime(2012, 2, 27, 13, 27, 0),
        );

        //then
        expect(userBookingShow1 == userBookingShow2, false);
      },
    );

    test(
      'GIVEN two user booking show models '
      'WHEN properties are same '
      'THEN equality returns true',
      () {
        //given
        final userBookingShow1 = UserBookingShowModel(
          showId: 1,
          showType: ShowType.i2D,
          showDatetime: DateTime(2012, 2, 27, 13, 27, 0),
        );

        //when
        final userBookingShow2 = UserBookingShowModel(
          showId: 1,
          showType: ShowType.i2D,
          showDatetime: DateTime(2012, 2, 27, 13, 27, 0),
        );

        //then
        expect(userBookingShow1 == userBookingShow2, true);
      },
    );
  });
}
