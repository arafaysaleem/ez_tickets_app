import 'package:flutter_test/flutter_test.dart';

import 'package:ez_ticketz_app/enums/payment_method_enum.dart';
import 'package:ez_ticketz_app/models/payment_model.dart';

void main() {
  group('fromJson', () {
    test(
      'GIVEN a valid payment json '
      'WHEN json deserialization is performed '
      'THEN a payment model is output',
      () {
        //given
        const json = {
          'payment_id': 1,
          'show_id': 1,
          'user_id': 1,
          'amount': 999.9,
          'payment_datetime': '2012-02-27T13:27:00.000',
          'payment_method': 'card',
          'bookings': [0, 1, 2],
        };

        //when
        final actual = PaymentModel.fromJson(json);
        final matcher = PaymentModel(
          paymentId: 1,
          amount: 999.9,
          userId: 1,
          showId: 1,
          paymentDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          paymentMethod: PaymentMethod.CARD,
          bookings: null,
        );

        //then
        expect(actual, matcher);
      },
    );

    test(
      'GIVEN a valid payment json '
      "AND it's bookings key is non-null "
      'WHEN json deserialization is performed '
      'THEN a payment model is output '
      "AND it's bookings are null",
      () {
        //given
        const json = {
          'payment_id': 1,
          'show_id': 1,
          'user_id': 1,
          'amount': 999.9,
          'payment_datetime': '2012-02-27T13:27:00.000',
          'payment_method': 'card',
          'bookings': [0, 1, 2],
        };

        //when
        final actual = PaymentModel.fromJson(json);

        //then
        expect(actual.bookings, null);
      },
    );

    test(
      'GIVEN a valid payment json '
      "AND it's bookings key is null "
      'WHEN json deserialization is performed '
      'THEN a payment model is output '
      "AND it's bookings are null",
      () {
        //given
        const json = {
          'payment_id': 1,
          'show_id': 1,
          'user_id': 1,
          'amount': 999.9,
          'payment_datetime': '2012-02-27T13:27:00.000',
          'payment_method': 'card',
          'bookings': null,
        };

        final actual = PaymentModel.fromJson(json);

        //then
        expect(actual.bookings, null);
      },
    );
  });

  group('toJson', () {
    test(
      'GIVEN a payment model '
      'WHEN json serialization is performed '
      'THEN a payment json is output',
      () {
        //given
        final model = PaymentModel(
          paymentId: null,
          amount: 999.9,
          userId: 1,
          showId: 1,
          paymentDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          paymentMethod: PaymentMethod.CARD,
          bookings: [0, 1, 2],
        );

        //when
        final actual = model.toJson();
        final matcher = {
          'show_id': 1,
          'user_id': 1,
          'amount': 999.9,
          'payment_datetime': '2012-02-27T13:27:00.000',
          'payment_method': 'card',
          'bookings': [0, 1, 2],
        };

        //then
        expect(actual, matcher);
      },
    );

    test(
      'GIVEN a payment model '
      "AND it's payment id is null"
      'WHEN json serialization is performed '
      'THEN a payment json is output '
      "AND it doesn't have a payment_id key",
      () {
        //given
        final model = PaymentModel(
          paymentId: null,
          amount: 999.9,
          userId: 1,
          showId: 1,
          paymentDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          paymentMethod: PaymentMethod.CARD,
          bookings: [0, 1, 2],
        );

        //when
        final actual = model.toJson();

        //then
        expect(actual.containsKey('payment_id'), false);
      },
    );

    test(
      'GIVEN a payment model '
      "AND it's payment id is non-null"
      'WHEN json serialization is performed '
      'THEN a payment json is output '
      "AND it doesn't have a payment_id key",
      () {
        //given
        final model = PaymentModel(
          paymentId: 1,
          amount: 999.9,
          userId: 1,
          showId: 1,
          paymentDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          paymentMethod: PaymentMethod.CARD,
          bookings: [0, 1, 2],
        );

        //when
        final actual = model.toJson();

        //then
        expect(actual.containsKey('payment_id'), false);
      },
    );

    test(
      'GIVEN a payment model '
      "AND it's bookings is null"
      'WHEN json serialization is performed '
      'THEN a payment json is output '
      "AND it doesn't have a bookings key",
      () {
        //given
        final model = PaymentModel(
          paymentId: 1,
          amount: 999.9,
          userId: 1,
          showId: 1,
          paymentDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          paymentMethod: PaymentMethod.CARD,
          bookings: null,
        );

        //when
        final actual = model.toJson();

        //then
        expect(actual.containsKey('bookings'), false);
      },
    );

    test(
      'GIVEN a payment model '
      "AND it's bookings is non-null"
      'WHEN json serialization is performed '
      'THEN a payment json is output '
      'AND it has a bookings key',
      () {
        //given
        final bookings = [0, 1, 2];
        final model = PaymentModel(
          paymentId: 1,
          amount: 999.9,
          userId: 1,
          showId: 1,
          paymentDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          paymentMethod: PaymentMethod.CARD,
          bookings: bookings,
        );

        //when
        final actual = model.toJson();

        //then
        expect(actual.containsKey('bookings'),true);
        expect(actual['bookings'], bookings);
      },
    );
  });

  group('toUpdateJson', () {
    test(
      'GIVEN a payment model '
      'WHEN json serialization is performed for updating'
      'AND all arguments are null '
      'THEN an empty json is output',
      () {
        //given
        final model = PaymentModel(
          paymentId: null,
          amount: 999.9,
          userId: 1,
          showId: 1,
          paymentDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          paymentMethod: PaymentMethod.CARD,
          bookings: [0, 1, 2],
        );

        //when
        final actual = model.toUpdateJson();

        //then
        expect(actual.isEmpty, true);
      },
    );

    test(
      'GIVEN a payment model '
      'WHEN json serialization is performed for updating'
      'AND some arguments with new values are given '
      'THEN a payment json is output '
      'AND it has new values for the provided arguments',
      () {
        //given
        final model = PaymentModel(
          paymentId: null,
          amount: 999.9,
          userId: 1,
          showId: 1,
          paymentDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          paymentMethod: PaymentMethod.CARD,
          bookings: [0, 1, 2],
        );

        //when
        const newPaymentMethod = PaymentMethod.CASH;
        final actual = model.toUpdateJson(
          paymentMethod: newPaymentMethod,
        );
        final matcher = {
          'show_id': 1,
          'user_id': 1,
          'amount': 999.9,
          'payment_datetime': '2012-02-27T13:27:00.000',
          'payment_method': 'cash',
          'bookings': [0, 1, 2],
        };

        //then
        expect(actual, matcher);
      },
    );
  });

  group('equality', () {
    test(
      'GIVEN two payment models '
      'WHEN properties are different '
      'THEN equality returns false',
      () {
        //given
        final payment1 = PaymentModel(
          paymentId: 1,
          amount: 999.9,
          userId: 1,
          showId: 1,
          paymentDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          paymentMethod: PaymentMethod.CARD,
          bookings: null,
        );

        //when
        final payment2 = PaymentModel(
          paymentId: 1,
          amount: 999.9,
          userId: 1,
          showId: 1,
          paymentDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          paymentMethod: PaymentMethod.CARD,
          bookings: [0, 1, 2],
        );

        //then
        expect(payment1 == payment2, false);
      },
    );

    test(
      'GIVEN two payment models '
      'WHEN properties are same '
      'THEN equality returns true',
      () {
        //given
        final payment1 = PaymentModel(
          paymentId: 1,
          amount: 999.9,
          userId: 1,
          showId: 1,
          paymentDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          paymentMethod: PaymentMethod.CARD,
          bookings: [0, 1, 2],
        );

        //when
        final payment2 = PaymentModel(
          paymentId: 1,
          amount: 999.9,
          userId: 1,
          showId: 1,
          paymentDatetime: DateTime(2012, 2, 27, 13, 27, 0),
          paymentMethod: PaymentMethod.CARD,
          bookings: [0, 1, 2],
        );

        //then
        expect(payment1 == payment2, true);
      },
    );
  });
}
