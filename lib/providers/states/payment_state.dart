import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_state.freezed.dart';

@freezed
class PaymentState with _$PaymentState {

  const factory PaymentState.unprocessed() = UNPROCESSED;

  const factory PaymentState.processing() = PROCESSING;

  const factory PaymentState.successful() =
  SUCCESSFUL;

  const factory PaymentState.failed({required String reason}) = FAILED;
}

