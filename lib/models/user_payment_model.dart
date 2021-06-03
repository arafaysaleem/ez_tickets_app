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
      required _UserPaymentMovieModel movie,
    }) = _UserPaymentModel;

    factory UserPaymentModel.fromJson(Map<String, dynamic> json) => _$UserPaymentModelFromJson(json);
}

@freezed
class _UserPaymentMovieModel with _$_UserPaymentMovieModel {
  @JsonSerializable()
  const factory _UserPaymentMovieModel({
    required String title,
    required String posterUrl,
  }) = __UserPaymentMovieModel;

  factory _UserPaymentMovieModel.fromJson(Map<String, dynamic> json) => _$_UserPaymentMovieModelFromJson(json);
}


