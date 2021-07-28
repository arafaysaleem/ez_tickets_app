import 'package:ez_ticketz_app/enums/payment_method_enum.dart';
import 'package:ez_ticketz_app/models/user_payment_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("UserPaymentMovieModel", () {
    group("fromJson", () {
      test(
        "GIVEN a json serialization is needed "
        "WHEN a valid user payment movie json is input "
        "THEN a user payment movie model is output",
        () {
          //given
          final json = {
            "title": "Some Movie",
            "poster_url": "www.placeholder.com/some-poster",
          };

          //when
          final actual = UserPaymentMovieModel.fromJson(json);
          const matcher = UserPaymentMovieModel(
            title: "Some Movie",
            posterUrl: "www.placeholder.com/some-poster",
          );

          //then
          expect(actual, matcher);
        },
      );
    });

    group("toJson", () {
      test(
        "GIVEN a json deserialization is needed "
        "WHEN a user payment movie model is converted "
        "THEN a user payment movie json is output",
        () {
          //given
          const userPaymentMovie = UserPaymentMovieModel(
            title: "Some Movie",
            posterUrl: "www.placeholder.com/some-poster",
          );

          //when
          final actual = userPaymentMovie.toJson();
          final matcher = {
            "title": "Some Movie",
            "poster_url": "www.placeholder.com/some-poster",
          };

          //then
          expect(actual, matcher);
        },
      );
    });

    group("equality", () {
      test(
        "GIVEN two user payment movie models "
        "WHEN properties are different "
        "THEN equality returns false",
        () {
          //given
          const userPaymentMovie1 = UserPaymentMovieModel(
            title: "Some Movie",
            posterUrl: "www.placeholder.com/some-poster",
          );

          //when
          const userPaymentMovie2 = UserPaymentMovieModel(
            title: "Some Different Movie",
            posterUrl: "www.placeholder.com/some-poster",
          );

          //then
          expect(userPaymentMovie1 == userPaymentMovie2, false);
        },
      );

      test(
        "GIVEN two user payment movie models "
        "WHEN properties are same "
        "THEN equality returns true",
        () {
          //given
          const userPaymentMovie1 = UserPaymentMovieModel(
            title: "Some Movie",
            posterUrl: "www.placeholder.com/some-poster",
          );

          //when
          const userPaymentMovie2 = UserPaymentMovieModel(
            title: "Some Movie",
            posterUrl: "www.placeholder.com/some-poster",
          );

          //then
          expect(userPaymentMovie1 == userPaymentMovie2, true);
        },
      );
    });
  });

  group("UserPaymentModel", () {
    group("fromJson", () {
      test(
        "GIVEN a json serialization is needed "
        "WHEN a valid user payment json is input "
        "THEN a user payment model is output",
        () {
          //given
          const paymentMovieJson = {
            "title": "Some Movie",
            "poster_url": "www.placeholder.com/some-poster",
          };
          const userPaymentJson = {
            "payment_id": 1,
            "amount": 1500.9,
            "payment_datetime": "2012-02-27T13:27:00.000",
            "payment_method": "cash",
            "movie": paymentMovieJson,
          };

          //when
          final actual = UserPaymentModel.fromJson(userPaymentJson);
          const paymentMovieModel = UserPaymentMovieModel(
            title: "Some Movie",
            posterUrl: "www.placeholder.com/some-poster",
          );
          final matcher = UserPaymentModel(
            paymentId: 1,
            amount: 1500.9,
            paymentDatetime: DateTime(2012, 2, 27, 13, 27, 0),
            paymentMethod: PaymentMethod.CASH,
            movie: paymentMovieModel,
          );

          //then
          expect(actual, matcher);
        },
      );
    });

    group("toJson", () {
      test(
        "GIVEN a json deserialization is needed "
        "WHEN a user payment model is converted "
        "THEN a user payment json is output",
        () {
          //given
          const paymentMovieModel = UserPaymentMovieModel(
            title: "Some Movie",
            posterUrl: "www.placeholder.com/some-poster",
          );
          final userPaymentModel = UserPaymentModel(
            paymentId: 1,
            amount: 1500.9,
            paymentDatetime: DateTime(2012, 2, 27, 13, 27, 0),
            paymentMethod: PaymentMethod.CASH,
            movie: paymentMovieModel,
          );

          //when
          final actual = userPaymentModel.toJson();
          const paymentMovieJson = {
            "title": "Some Movie",
            "poster_url": "www.placeholder.com/some-poster",
          };
          const matcher = {
            "payment_id": 1,
            "amount": 1500.9,
            "payment_datetime": "2012-02-27T13:27:00.000",
            "payment_method": "cash",
            "movie": paymentMovieJson,
          };

          //then
          expect(actual, matcher);
        },
      );
    });

    group("equality", () {
      test(
        "GIVEN two user payment movie models "
        "WHEN properties are different "
        "THEN equality returns false",
        () {
          //given
          const paymentMovieModel1 = UserPaymentMovieModel(
            title: "Some Movie",
            posterUrl: "www.placeholder.com/some-poster",
          );
          final userPaymentModel1 = UserPaymentModel(
            paymentId: 1,
            amount: 1500.9,
            paymentDatetime: DateTime(2012, 2, 27, 13, 27, 0),
            paymentMethod: PaymentMethod.CASH,
            movie: paymentMovieModel1,
          );

          //when
          const paymentMovieModel2 = UserPaymentMovieModel(
            title: "Some Different Movie",
            posterUrl: "www.placeholder.com/some-poster",
          );
          final userPaymentModel2 = UserPaymentModel(
            paymentId: 1,
            amount: 1500.9,
            paymentDatetime: DateTime(2012, 2, 27, 13, 27, 0),
            paymentMethod: PaymentMethod.CASH,
            movie: paymentMovieModel2,
          );

          //then
          expect(userPaymentModel1 == userPaymentModel2, false);
        },
      );

      test(
        "GIVEN two user payment movie models "
        "WHEN properties are same "
        "THEN equality returns true",
        () {
          //given
          const paymentMovieModel1 = UserPaymentMovieModel(
            title: "Some Different Movie",
            posterUrl: "www.placeholder.com/some-poster",
          );
          final userPaymentModel1 = UserPaymentModel(
            paymentId: 1,
            amount: 1500.9,
            paymentDatetime: DateTime(2012, 2, 27, 13, 27, 0),
            paymentMethod: PaymentMethod.CASH,
            movie: paymentMovieModel1,
          );

          //when
          const paymentMovieModel2 = UserPaymentMovieModel(
            title: "Some Different Movie",
            posterUrl: "www.placeholder.com/some-poster",
          );
          final userPaymentModel2 = UserPaymentModel(
            paymentId: 1,
            amount: 1500.9,
            paymentDatetime: DateTime(2012, 2, 27, 13, 27, 0),
            paymentMethod: PaymentMethod.CASH,
            movie: paymentMovieModel2,
          );

          //then
          expect(userPaymentModel1 == userPaymentModel2, true);
        },
      );
    });
  });
}
