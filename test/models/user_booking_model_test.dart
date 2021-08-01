import 'package:flutter_test/flutter_test.dart';

import 'package:ez_ticketz_app/enums/booking_status_enum.dart';
import 'package:ez_ticketz_app/enums/show_type_enum.dart';

import 'package:ez_ticketz_app/models/booking_model.dart';
import 'package:ez_ticketz_app/models/user_booking_model.dart';
import 'package:ez_ticketz_app/models/user_booking_show_model.dart';

void main() {
  late UserBookingShowModel _userBookingShowModel;
  late BookingModel _bookingModel1, _bookingModel2;

  const _userBookingShowJson = {
    'show_id': 1,
    'show_type': '2D',
    'show_datetime': '2012-02-27T13:27:00.000',
  };
  const _bookingsJson = [
    {
      'booking_id': 1,
      'user_id': 1,
      'show_id': 1,
      'seat_row': 'A',
      'seat_number': 10,
      'price': 700.2,
      'booking_datetime': '2012-02-27T13:27:00.000',
      'booking_status': 'confirmed',
    },
    {
      'booking_id': 2,
      'user_id': 1,
      'show_id': 1,
      'seat_row': 'A',
      'seat_number': 11,
      'price': 700.2,
      'booking_datetime': '2012-02-27T13:30:00.000',
      'booking_status': 'confirmed',
    },
  ];

  /// Always initialize non final variables using setUp, so it resets variables
  /// before all test and hence any mutations by the previous ones won't carry.
  setUp((){
    _userBookingShowModel = UserBookingShowModel(
      showId: 1,
      showType: ShowType.i2D,
      showDatetime: DateTime(2012, 2, 27, 13, 27, 0),
    );
    _bookingModel1 = BookingModel(
      bookingId: 1,
      userId: 1,
      showId: 1,
      seatRow: 'A',
      seatNumber: 10,
      price: 700.2,
      bookingDatetime: DateTime(2012, 2, 27, 13, 27, 0),
      bookingStatus: BookingStatus.CONFIRMED,
    );
    _bookingModel2 = BookingModel(
      bookingId: 2,
      userId: 1,
      showId: 1,
      seatRow: 'A',
      seatNumber: 11,
      price: 700.2,
      bookingDatetime: DateTime(2012, 2, 27, 13, 30, 0),
      bookingStatus: BookingStatus.CONFIRMED,
    );
  });

  group('fromJson', () {
    test(
      'GIVEN a valid user booking json '
      'WHEN a json deserialization is performed '
      'THEN a user booking model is output',
      () {
        //given
        const userBookingJson = {
          'title': 'Some Movie',
          'poster_url': 'www.placeholder.com/some-poster',
          'show': _userBookingShowJson,
          'bookings': _bookingsJson,
        };

        //when
        final actual = UserBookingModel.fromJson(userBookingJson);

        final bookingModels = [ _bookingModel1, _bookingModel2 ];

        final matcher = UserBookingModel(
          title: 'Some Movie',
          posterUrl: 'www.placeholder.com/some-poster',
          show: _userBookingShowModel,
          bookings: bookingModels,
        );

        //then
        expect(actual, matcher);
      },
    );
  });

  group('toJson', () {
    /// Override booking models with new ones containing `seat` key
    setUp((){
      _bookingModel1 = BookingModel(
        bookingId: 1,
        userId: 1,
        showId: 1,
        seat: 'A-10',
        price: 700.2,
        bookingDatetime: DateTime(2012, 2, 27, 13, 27, 0),
        bookingStatus: BookingStatus.CONFIRMED,
      );
      _bookingModel2 = BookingModel(
        bookingId: 2,
        userId: 1,
        showId: 1,
        seat: 'A-11',
        price: 700.2,
        bookingDatetime: DateTime(2012, 2, 27, 13, 30, 0),
        bookingStatus: BookingStatus.CONFIRMED,
      );
    });

    test(
      'GIVEN a user booking model '
      'WHEN a json serialization is performed '
      'THEN a user booking json is output',
      () {
        //given
        final bookingModels = [ _bookingModel1, _bookingModel2 ];

        final userBookingModel = UserBookingModel(
          title: 'Some Movie',
          posterUrl: 'www.placeholder.com/some-poster',
          show: _userBookingShowModel,
          bookings: bookingModels,
        );

        //when
        final actual = userBookingModel.toJson();

        const bookingsJson = [
          {
            'user_id': 1,
            'show_id': 1,
            'seat': 'A-10',
            'price': 700.2,
            'booking_datetime': '2012-02-27T13:27:00.000',
            'booking_status': 'confirmed',
          },
          {
            'user_id': 1,
            'show_id': 1,
            'seat': 'A-11',
            'price': 700.2,
            'booking_datetime': '2012-02-27T13:30:00.000',
            'booking_status': 'confirmed',
          },
        ];

        const matcher = {
          'title': 'Some Movie',
          'poster_url': 'www.placeholder.com/some-poster',
          'show': _userBookingShowJson,
          'bookings': bookingsJson,
        };

        //then
        expect(actual, matcher);
      },
    );
  });

  group('equality', () {
    late List<BookingModel> _bookingModels;

    setUp(() => _bookingModels = [ _bookingModel1, _bookingModel2 ]);

    test(
      'GIVEN two user booking models '
      'WHEN properties are different '
      'THEN equality returns false',
      () {
        //given
        final userBookingModel1 = UserBookingModel(
          title: 'Some Movie',
          posterUrl: 'www.placeholder.com/some-poster',
          show: _userBookingShowModel,
          bookings: _bookingModels,
        );

        //when
        final userBookingModel2 = UserBookingModel(
          title: 'Some Different Movie', //different name
          posterUrl: 'www.placeholder.com/some-poster',
          show: _userBookingShowModel,
          bookings: _bookingModels,
        );

        //then
        expect(userBookingModel1 == userBookingModel2, false);
      },
    );

    test(
      'GIVEN two user booking models '
      'WHEN properties are same '
      'THEN equality returns true',
      () {
        //given
        final userBookingModel1 = UserBookingModel(
          title: 'Some Movie',
          posterUrl: 'www.placeholder.com/some-poster',
          show: _userBookingShowModel,
          bookings: _bookingModels,
        );

        //when
        final userBookingShowModel2 = UserBookingShowModel(
          showId: 1,
          showType: ShowType.i2D,
          showDatetime: DateTime(2012, 2, 27, 13, 27, 0),
        );

        final bookingModels2 = [
          BookingModel(
            bookingId: 1,
            userId: 1,
            showId: 1,
            seatRow: 'A',
            seatNumber: 10,
            price: 700.2,
            bookingDatetime: DateTime(2012, 2, 27, 13, 27, 0),
            bookingStatus: BookingStatus.CONFIRMED,
          ),
          BookingModel(
            bookingId: 2,
            userId: 1,
            showId: 1,
            seatRow: 'A',
            seatNumber: 11,
            price: 700.2,
            bookingDatetime: DateTime(2012, 2, 27, 13, 30, 0),
            bookingStatus: BookingStatus.CONFIRMED,
          )
        ];

        final userBookingModel2 = UserBookingModel(
          title: 'Some Movie',
          posterUrl: 'www.placeholder.com/some-poster',
          show: userBookingShowModel2,
          bookings: bookingModels2,
        );

        //then
        expect(userBookingModel1 == userBookingModel2, true);
      },
    );
  });
}
