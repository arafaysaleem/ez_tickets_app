import 'package:freezed_annotation/freezed_annotation.dart';

import '../helper/typedefs.dart';
import '../enums/payment_method_enum.dart';

part 'user_payment_model.freezed.dart';
part 'user_payment_model.g.dart';

@freezed
class UserPaymentModel with _$UserPaymentModel {
    const factory UserPaymentModel({
      required int paymentId,
      required double amount,
      required DateTime paymentDatetime,
      required PaymentMethod paymentMethod,
      required UserPaymentMovieModel movie,
    }) = _UserPaymentModel;

    factory UserPaymentModel.fromJson(JSON json) => _$UserPaymentModelFromJson(json);
}

@freezed
@visibleForTesting
class UserPaymentMovieModel with _$UserPaymentMovieModel {
  const factory UserPaymentMovieModel({
    required String title,
    required String posterUrl,
  }) = _UserPaymentMovieModel;

  factory UserPaymentMovieModel.fromJson(JSON json) => _$UserPaymentMovieModelFromJson(json);
}


