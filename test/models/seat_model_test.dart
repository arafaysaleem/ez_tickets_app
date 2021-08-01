import 'package:flutter_test/flutter_test.dart';

import 'package:ez_ticketz_app/models/seat_model.dart';

void main() {
  group('fromJson', () {
    test(
      'GIVEN a valid seat json '
      'WHEN json deserialization is performed '
      'THEN a seat model is output',
      () {
        //given
        final json = {
          'seat_row': 'A',
          'seat_number': 1,
        };

        //when
        final actual = SeatModel.fromJson(json);
        const matcher = SeatModel(
          seatRow: 'A',
          seatNumber: 1,
        );

        //then
        expect(actual, matcher);
      },
    );
  });

  group('toJson', () {
    test(
      'GIVEN a seat model '
      'WHEN json serialization is performed '
      'THEN a seat json is output',
      () {
        //given
        const seat = SeatModel(
          seatRow: 'A',
          seatNumber: 1,
        );

        //when
        final actual = seat.toJson();
        final matcher = {
          'seat_row': 'A',
          'seat_number': 1,
        };

        //then
        expect(actual, matcher);
      },
    );
  });

  group('equality', () {
    test(
      'GIVEN two seat models '
      'WHEN properties are different '
      'THEN equality returns false',
      () {
        //given
        const seat1 = SeatModel(
          seatRow: 'A',
          seatNumber: 1,
        );

        //when
        const seat2 = SeatModel(
          seatRow: 'B',
          seatNumber: 2,
        );

        //then
        expect(seat1 == seat2, false);
      },
    );

    test(
      'GIVEN two seat models '
      'WHEN properties are same '
      'THEN equality returns true',
      () {
        //given
        const seat1 = SeatModel(
          seatRow: 'A',
          seatNumber: 1,
        );

        //when
        const seat2 = SeatModel(
          seatRow: 'A',
          seatNumber: 1,
        );

        //then
        expect(seat1 == seat2, true);
      },
    );
  });
}
