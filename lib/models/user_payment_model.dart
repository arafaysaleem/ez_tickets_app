import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/payment_method_enum.dart';

part 'user_payment_model.freezed.dart';
part 'user_payment_model.g.dart';

@freezed
class UserPaymentModel with _$UserPaymentModel {
    @JsonSerializable()
    const factory UserPaymentModel({
      required int paymentId,
      required double amount,
      required DateTime paymentDatetime,
      required PaymentMethod paymentMethod,
      required UserPaymentMovieModel movie,
    }) = _UserPaymentModel;

    factory UserPaymentModel.fromJson(Map<String, dynamic> json) => _$UserPaymentModelFromJson(json);
}

@visibleForTesting
@freezed
class UserPaymentMovieModel with _$UserPaymentMovieModel {
  @JsonSerializable()
  const factory UserPaymentMovieModel({
    required String title,
    required String posterUrl,
  }) = _UserPaymentMovieModel;

  factory UserPaymentMovieModel.fromJson(Map<String, dynamic> json) => _$UserPaymentMovieModelFromJson(json);
}


