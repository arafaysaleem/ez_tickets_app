import 'package:freezed_annotation/freezed_annotation.dart';

part 'future_state.freezed.dart';

@freezed
class FutureState<T> with _$FutureState<T> {

  const factory FutureState.idle() = IDLE;

  const factory FutureState.loading() = LOADING;

  const factory FutureState.data({required T data}) = DATA;

  const factory FutureState.failed({required String reason}) = FAILED;
}


