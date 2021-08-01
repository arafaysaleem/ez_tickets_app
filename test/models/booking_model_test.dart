import 'package:flutter_test/flutter_test.dart';

import 'package:ez_ticketz_app/enums/booking_status_enum.dart';
import 'package:ez_ticketz_app/models/booking_model.dart';

void main() {
  group('fromJson', () {
    test(
      'GIVEN a valid booking json '
      'WHEN json deserialization is performed'
      'THEN a booking model is output',
      () {
        //given
        final json = {
          'booking_id': 1,
          'user_id': 1,
          'show_id': 1,
          'seat_row': 'A',
          'seat_number': 10,
          'price': 700.2,
          'booking_datetime': '2012-02-27T13:27:00.000',
          'booking_status': 'confirmed',
        };

        //when
        final actual = BookingModel.fromJson(json);
        final matcher = BookingModel(
          bookingId: 1,
          userId: 1,
          showId: 1,
          seatRow: 'A',
          seatNumber: 10,
          price: 700.2,
          bookingDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          bookingStatus: BookingStatus.CONFIRMED,
        );

        //then
        expect(actual, matcher);
      },
    );

    test(
      'GIVEN a valid booking json '
      'AND seat is non-null '
      'WHEN a json deserialization is performed '
      'THEN a booking model is output'
      "AND it's seat is null",
      () {
        //given
        final json = {
          'booking_id': 1,
          'user_id': 1,
          'show_id': 1,
          'seat_row': 'A',
          'seat': 'A-10',
          'seat_number': 10,
          'price': 700.2,
          'booking_datetime': '2012-02-27T13:27:00.000',
          'booking_status': 'confirmed',
        };

        //when
        final model = BookingModel.fromJson(json);

        //then
        expect(model.seat, null);
      },
    );
  });

  group('toJson', () {
    test(
      'GIVEN a booking model '
      "AND it's booking id is non-null "
      "AND it's seat row is null or non-null "
      "AND it's seat number is null or non-null"
      'WHEN json serialization is performed '
      'THEN a booking json is output'
      "AND it doesn't contain a key booking_id "
      "AND it doesn't contain a key seat_row "
      "AND it doesn't contain a key seat_number",
      () {
        //given
        final booking = BookingModel(
          bookingId: 1,
          seatRow: 'A',
          seatNumber: 10,
          userId: 1,
          showId: 1,
          price: 700.2,
          bookingDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          bookingStatus: BookingStatus.CONFIRMED,
        );

        //when
        final actual = booking.toJson();
        final matcher = {
          'user_id': 1,
          'show_id': 1,
          'price': 700.2,
          'booking_datetime': '2012-02-27T13:27:00.000',
          'booking_status': 'confirmed',
        };

        //then
        expect(actual, matcher);
      },
    );

    test(
      'GIVEN a booking model '
      "AND it's booking id is null "
      "AND it's seat row is null or non-null "
      "AND it's seat number is null or non-null"
      'WHEN json serialization is performed '
      'THEN a booking json is output'
      "AND it doesn't contain a key booking_id "
      "AND it doesn't contain a key seat_row "
      "AND it doesn't contain a key seat_number",
      () {
        //given
        final booking = BookingModel(
          bookingId: null,
          seatRow: 'A',
          seatNumber: 10,
          userId: 1,
          showId: 1,
          price: 700.2,
          bookingDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          bookingStatus: BookingStatus.CONFIRMED,
        );

        //when
        final actual = booking.toJson();
        final matcher = {
          'user_id': 1,
          'show_id': 1,
          'price': 700.2,
          'booking_datetime': '2012-02-27T13:27:00.000',
          'booking_status': 'confirmed',
        };

        //then
        expect(actual, matcher);
      },
    );

    test(
      'GIVEN a booking model '
      "AND it's seat row is null or non-null "
      "AND it's seat number is null or non-null"
      'WHEN json serialization is performed '
      'THEN a booking json is output'
      "AND it doesn't contain a key seat_row "
      "AND it doesn't contain a key seat_number",
      () {
        //given
        final booking = BookingModel(
          bookingId: null,
          userId: 1,
          showId: 1,
          price: 700.2,
          bookingDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          bookingStatus: BookingStatus.CONFIRMED,
        );

        //when
        final actual = booking.toJson();
        final matcher = {
          'user_id': 1,
          'show_id': 1,
          'price': 700.2,
          'booking_datetime': '2012-02-27T13:27:00.000',
          'booking_status': 'confirmed',
        };

        //then
        expect(actual, matcher);
      },
    );

    test(
      'GIVEN a booking model '
      "AND it's seat is non-null "
      'WHEN json serialization is performed '
      'THEN a booking json is output '
      'AND it contains a seat key',
      () {
        //given
        final booking = BookingModel(
          bookingId: null,
          userId: 1,
          showId: 1,
          seat: 'A-10',
          price: 700.2,
          bookingDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          bookingStatus: BookingStatus.CONFIRMED,
        );

        //when
        final actual = booking.toJson();

        //then
        expect(actual.containsKey('seat'), true);
        expect(actual['seat'], 'A-10');
      },
    );

    test(
      'GIVEN a booking model '
      "AND it's user id is null "
      'WHEN json serialization is performed '
      'THEN a booking json is output '
      "AND it doesn't contain a key user_id",
      () {
        //given
        final booking = BookingModel(
          bookingId: null,
          userId: null,
          showId: 1,
          price: 700.2,
          bookingDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          bookingStatus: BookingStatus.CONFIRMED,
        );

        //when
        final model = booking.toJson();

        //then
        expect(model.containsKey('user_id'), false);
      },
    );

    test(
      'GIVEN a booking model '
      "AND it's show id is null "
      'WHEN json serialization is performed '
      'THEN a booking json is output '
      "AND it doesn't contain a key show_id",
      () {
        //given
        final booking = BookingModel(
          bookingId: null,
          showId: null,
          userId: 1,
          price: 700.2,
          bookingDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          bookingStatus: BookingStatus.CONFIRMED,
        );

        //when
        final model = booking.toJson();

        //then
        expect(model.containsKey('show_id'), false);
      },
    );

    test(
      'GIVEN a booking model '
      "AND it's show id is null "
      "AND it's user id is null "
      'WHEN json serialization is performed '
      'THEN a booking json is output '
      "AND it doesn't contain a key show_id "
      "AND it doesn't contain a key user_id",
      () {
        //given
        final booking = BookingModel(
          bookingId: null,
          userId: null,
          showId: null,
          price: 700.2,
          bookingDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          bookingStatus: BookingStatus.CONFIRMED,
        );

        //when
        final model = booking.toJson();

        //then
        expect(model.containsKey('user_id'), false);
        expect(model.containsKey('show_id'), false);
      },
    );
  });

  group('toUpdateJson', () {
    test(
      'GIVEN a booking model '
      'WHEN json serialization is performed for updating'
      'AND all arguments are null '
      'THEN an empty json is output',
      () {
        //given
        final model = BookingModel(
          bookingId: 1,
          seatRow: 'A',
          seatNumber: 10,
          userId: 1,
          showId: 1,
          price: 700.2,
          bookingDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          bookingStatus: BookingStatus.CONFIRMED,
        );

        //when
        final actual = model.toUpdateJson();

        //then
        expect(actual.isEmpty, true);
      },
    );

    test(
      'GIVEN a booking model '
      'WHEN json serialization is performed for updating'
      'AND some arguments with new values are given '
      'THEN a booking json is output '
      'AND it has new values for the provided arguments',
      () {
        //given
        final model = BookingModel(
          bookingId: 1,
          seatRow: 'A',
          seatNumber: 10,
          userId: null,
          showId: 1,
          price: 700.2,
          bookingDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          bookingStatus: BookingStatus.CONFIRMED,
        );

        //when
        const newBookingStatus = BookingStatus.RESERVED;
        final actual = model.toUpdateJson(
          bookingStatus: newBookingStatus,
        );
        final matcher = {
          'show_id': 1,
          'price': 700.2,
          'booking_datetime': '2012-02-27T13:27:00.000',
          'booking_status': newBookingStatus.toJson,
        };

        //then
        expect(actual, matcher);
      },
    );
  });

  group('equality', () {
    test(
      'GIVEN two booking models '
      'WHEN properties are different '
      'THEN equality returns false',
      () {
        //given
        final booking1 = BookingModel(
          bookingId: 1,
          seatRow: 'A',
          seatNumber: 10,
          userId: 1,
          showId: 1,
          price: 700.2,
          bookingDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          bookingStatus: BookingStatus.CONFIRMED,
        );

        //when
        final booking2 = BookingModel(
          bookingId: 1,
          seatRow: 'A',
          seatNumber: 10,
          userId: 1,
          showId: 1,
          price: 700.2,
          bookingDatetime: DateTime(2012, 3, 27, 13, 27, 0),
          //different month
          bookingStatus: BookingStatus.CONFIRMED,
        );

        //then
        expect(booking1 == booking2, false);
      },
    );

    test(
      'GIVEN two booking models '
      'WHEN properties are same '
      'THEN equality returns true',
      () {
        //given
        final booking1 = BookingModel(
          bookingId: 1,
          seatRow: 'A',
          seatNumber: 10,
          userId: 1,
          showId: 1,
          price: 700.2,
          bookingDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          bookingStatus: BookingStatus.CONFIRMED,
        );

        //when
        final booking2 = BookingModel(
          bookingId: 1,
          seatRow: 'A',
          seatNumber: 10,
          userId: 1,
          showId: 1,
          price: 700.2,
          bookingDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          bookingStatus: BookingStatus.CONFIRMED,
        );

        //then
        expect(booking1 == booking2, true);
      },
    );
  });
}
