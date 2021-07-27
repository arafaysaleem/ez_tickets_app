import 'package:flutter_test/flutter_test.dart';

import 'package:ez_ticketz_app/enums/booking_status_enum.dart';
import 'package:ez_ticketz_app/models/booking_model.dart';

void main() {
  group("fromJson", () {
    test(
      "GIVEN a json serialization is needed"
      "WHEN a valid booking json is input"
      "THEN a booking model is output",
      () {
        //given
        final json = {
          "booking_id": 1,
          "user_id": 1,
          "show_id": 1,
          "seat_row": "A",
          "seat_number": 10,
          "price": 700.2,
          "booking_datetime": "2012-02-27T13:27:00.000",
          "booking_status": "confirmed",
        };

        //when
        final actual = BookingModel.fromJson(json);
        final matcher = BookingModel(
          bookingId: 1,
          userId: 1,
          showId: 1,
          seatRow: "A",
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
      "GIVEN a json serialization is needed"
      "WHEN a valid booking json with 'seat' key is input"
      "THEN 'seat' is ignored and a booking model is output",
      () {
        //given
        final json = {
          "booking_id": 1,
          "user_id": 1,
          "show_id": 1,
          "seat_row": "A",
          "seat": "A-10",
          "seat_number": 10,
          "price": 700.2,
          "booking_datetime": "2012-02-27T13:27:00.000",
          "booking_status": "confirmed",
        };

        //when
        final actual = BookingModel.fromJson(json);
        final matcher = BookingModel(
          bookingId: 1,
          userId: 1,
          showId: 1,
          seatRow: "A",
          seatNumber: 10,
          price: 700.2,
          bookingDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          bookingStatus: BookingStatus.CONFIRMED,
        );

        //then
        expect(actual, matcher);
      },
    );
  });

  group("toJson", () {
    test(
      "GIVEN a json deserialization is needed "
      "WHEN a booking model is converted "
      "AND it has a booking id "
      "AND/OR it has a seat row "
      "AND/OR it has a seat number "
      "THEN a booking json without booking id, seat row and seat number is output",
      () {
        //given
        final booking = BookingModel(
          bookingId: 1,
          seatRow: "A",
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
          "user_id": 1,
          "show_id": 1,
          "price": 700.2,
          "booking_datetime": "2012-02-27T13:27:00.000",
          "booking_status": "confirmed",
        };

        //then
        expect(actual, matcher);
      },
    );

    test(
      "GIVEN a json deserialization is needed "
      "WHEN a booking model is converted "
      "AND it has null booking id "
      "AND/OR it has a seat row "
      "AND/OR it has a seat number "
      "THEN a booking json without booking id, seat row and seat number is output",
      () {
        //given
        final booking = BookingModel(
          bookingId: null,
          seatRow: "A",
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
          "user_id": 1,
          "show_id": 1,
          "price": 700.2,
          "booking_datetime": "2012-02-27T13:27:00.000",
          "booking_status": "confirmed",
        };

        //then
        expect(actual, matcher);
      },
    );

    test(
      "GIVEN a json deserialization is needed "
      "WHEN a booking model is converted "
      "AND/OR it doesn't have a seat row "
      "AND/OR it doesn't have a seat number "
      "THEN a booking json without seat row and seat number is output",
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
          "user_id": 1,
          "show_id": 1,
          "price": 700.2,
          "booking_datetime": "2012-02-27T13:27:00.000",
          "booking_status": "confirmed",
        };

        //then
        expect(actual, matcher);
      },
    );

    test(
      "GIVEN a json deserialization is needed "
      "WHEN a booking model with seat is converted "
      "THEN a booking json with seat is output",
      () {
        //given
        final booking = BookingModel(
          bookingId: null,
          userId: 1,
          showId: 1,
          seat: "A-10",
          price: 700.2,
          bookingDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          bookingStatus: BookingStatus.CONFIRMED,
        );

        //when
        final actual = booking.toJson();
        final matcher = {
          "user_id": 1,
          "show_id": 1,
          "seat": "A-10",
          "price": 700.2,
          "booking_datetime": "2012-02-27T13:27:00.000",
          "booking_status": "confirmed",
        };

        //then
        expect(actual, matcher);
      },
    );

    test(
      "GIVEN a json deserialization is needed "
      "WHEN a booking model is converted "
      "AND user id null "
      "THEN a booking json is output without user id",
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
        final actual = booking.toJson();
        final matcher = {
          "show_id": 1,
          "price": 700.2,
          "booking_datetime": "2012-02-27T13:27:00.000",
          "booking_status": "confirmed",
        };

        //then
        expect(actual, matcher);
      },
    );

    test(
      "GIVEN a json deserialization is needed "
      "WHEN a booking model is converted "
      "AND show id null "
      "THEN a booking json is output without show id",
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
        final actual = booking.toJson();
        final matcher = {
          "user_id": 1,
          "price": 700.2,
          "booking_datetime": "2012-02-27T13:27:00.000",
          "booking_status": "confirmed",
        };

        //then
        expect(actual, matcher);
      },
    );

    test(
      "GIVEN a json deserialization is needed "
      "WHEN a booking model is converted "
      "AND user id null "
      "AND show id null "
      "THEN a booking json is output without user id and show id",
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
        final actual = booking.toJson();
        final matcher = {
          "price": 700.2,
          "booking_datetime": "2012-02-27T13:27:00.000",
          "booking_status": "confirmed",
        };

        //then
        expect(actual, matcher);
      },
    );
  });

  group("equality", () {
    test(
      "GIVEN two booking models "
      "WHEN properties are different "
      "THEN equality returns false",
      () {
        //given
        final booking1 = BookingModel(
          bookingId: 1,
          seatRow: "A",
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
          seatRow: "A",
          seatNumber: 10,
          userId: 1,
          showId: 1,
          price: 700.2,
          bookingDatetime: DateTime(2012, 3, 27, 13, 27, 0), //different month
          bookingStatus: BookingStatus.CONFIRMED,
        );

        //then
        expect(booking1 == booking2, false);
      },
    );

    test(
      "GIVEN two booking models "
      "WHEN properties are same "
      "THEN equality returns true",
      () {
        //given
        final booking1 = BookingModel(
          bookingId: 1,
          seatRow: "A",
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
          seatRow: "A",
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
