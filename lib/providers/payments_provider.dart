import 'package:clock/clock.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Enums
import '../enums/payment_method_enum.dart';

//Helpers
import '../helper/typedefs.dart';
import '../helper/utils/constants.dart';

//Models
import '../models/payment_model.dart';
import '../models/user_payment_model.dart';

//States
import 'states/payment_state.dart';

//Services
import '../services/networking/network_exception.dart';
import '../services/repositories/payments_repository.dart';

//Providers
import 'all_providers.dart';
import 'shows_provider.dart';

final paymentStateProvider = StateProvider<PaymentState>((ref){
  return const PaymentState.unprocessed();
});

final activePaymentModeProvider = StateProvider<PaymentMethod>((ref){
  return PaymentMethod.CASH;
});

class PaymentsProvider {

  final PaymentsRepository _paymentsRepository;
  final Ref _ref;

  PaymentsProvider({
    required PaymentsRepository paymentsRepository,
    required Ref ref,
  })  : _paymentsRepository = paymentsRepository,
        _ref = ref,
        super();

  Future<List<PaymentModel>> getAllPayments({
    PaymentMethod? paymentMethod,
  }) async {
    final QueryParams? queryParams = {
      if (paymentMethod != null) 'payment_method': paymentMethod.toJson,
    };
    return await _paymentsRepository.fetchAll(queryParameters: queryParams);
  }

  Future<PaymentModel> getPaymentById({
    required int paymentId,
  }) async {
    return await _paymentsRepository.fetchOne(paymentId: paymentId);
  }

  Future<List<UserPaymentModel>> getUserPayments({
    required int userId,
  }) async {
    return await _paymentsRepository.fetchUserPayments(userId: userId);
  }

  Future<void> makePayment() async {
    final _paymentStateProv = _ref.read(paymentStateProvider.state);
    _paymentStateProv.state = const PaymentState.unprocessed();
    await Future<void>.delayed(const Duration(seconds: 3)).then((_) {
      _paymentStateProv.state = const PaymentState.processing();
    });
    final _activePaymentMethod = _ref.read(activePaymentModeProvider);
    try {
      switch(_activePaymentMethod){
        case PaymentMethod.CASH:
        case PaymentMethod.COD: await _reserveTickets(); break;
        case PaymentMethod.CARD: await _confirmCardPayment(); break;
        default: await _reserveTickets(); break;
      }
      _paymentStateProv.state = const PaymentState.successful();
      _ref.read(theatersProvider).clearSelectedSeats();
    } on NetworkException catch (e) {
      _paymentStateProv.state = PaymentState.failed(reason: e.message);
    }
  }

  Future<void> _reserveTickets() async {
    final _bookingsProvider = _ref.read(bookingsProvider);
    await _bookingsProvider.bookSelectedSeats();
  }

  // Future<void> _confirmCashPayment() async {
  //   final userId = _ref.read(authProvider.notifier).currentUserId;
  //   final showId = _ref.read(selectedShowTimeProvider).showId;
  //   final _bookingsProvider = _ref.read(bookingsProvider);
  //   final bookings = await _bookingsProvider.getFilteredBookings(
  //     userId: userId,
  //     showId: showId,
  //     bookingStatus: BookingStatus.RESERVED,
  //   );
  //   var amount = 0.0;
  //   final bookingIds = <int>[];
  //   for(var booking in bookings){
  //     amount += booking.price;
  //     bookingIds.add(booking.bookingId!);
  //   }
  //   await _makeAPayment(
  //     userId: userId,
  //     showId: showId,
  //     amount: amount,
  //     paymentDatetime: clock.now(),
  //     bookingIds: bookingIds,
  //     paymentMethod: _ref.read(activePaymentModeProvider),
  //   );
  // }

  Future<void> _confirmCardPayment() async {
    final userId = _ref.read(authProvider.notifier).currentUserId;
    final showId = _ref.read(selectedShowTimeProvider).showId;
    final _bookingsProvider = _ref.read(bookingsProvider);
    final bookingIds = await _bookingsProvider.bookSelectedSeats();
    final selectedSeats = _ref.read(theatersProvider).selectedSeats;
    final amount = selectedSeats.length * Constants.ticketPrice;
    await _makeAPayment(
      userId: userId,
      showId: showId,
      amount: amount,
      paymentDatetime: clock.now(),
      bookingIds: bookingIds,
      paymentMethod: PaymentMethod.CARD,
    );
  }

  Future<PaymentModel> _makeAPayment({
    required int userId,
    required int showId,
    required double amount,
    required DateTime paymentDatetime,
    required List<int> bookingIds,
    required PaymentMethod paymentMethod,
  }) async {
    final payment = PaymentModel(
      paymentId: null,
      userId: userId,
      showId: showId,
      amount: amount,
      paymentDatetime: paymentDatetime,
      bookings: bookingIds,
      paymentMethod: paymentMethod,
    );
    final paymentId = await _paymentsRepository.create(data: payment.toJson());

    return payment.copyWith(paymentId: paymentId);
  }

  // Future<String> _editPayment({
  //   required PaymentModel payment,
  //   int? userId,
  //   int? showId,
  //   double? amount,
  //   DateTime? paymentDatetime,
  //   PaymentMethod? paymentMethod,
  // }) async {
  //   final data = payment.toUpdateJson(
  //     userId: userId,
  //     showId: showId,
  //     amount: amount,
  //     paymentDatetime: paymentDatetime,
  //     paymentMethod: paymentMethod,
  //   );
  //   if (data.isEmpty) return "Nothing to update!";
  //   return await _paymentsRepository.update(
  //       paymentId: payment.paymentId!, data: data);
  // }

  Future<String> removePayment({
    required int paymentId,
  }) async {
    return await _paymentsRepository.delete(paymentId: paymentId);
  }

  void cancelNetworkRequest() {
    _paymentsRepository.cancelRequests();
  }
}
