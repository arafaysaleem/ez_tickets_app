import 'package:clock/clock.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Enums
import '../enums/booking_status_enum.dart';

//Helpers
import '../helper/utils/constants.dart';
import '../helper/typedefs.dart';

//Models
import '../models/booking_model.dart';
import '../models/seat_model.dart';
import '../models/user_booking_model.dart';

//Services
import '../services/repositories/bookings_repository.dart';

//Providers
import 'all_providers.dart';
import 'shows_provider.dart';

final userBookingsProvider = FutureProvider.autoDispose((ref) async {
  final _userId = ref.watch(authProvider.notifier).currentUserId;
  final _bookingsProvider = ref.watch(bookingsProvider);
  return await _bookingsProvider.getUserBookings(userId: _userId);
});

class BookingsProvider {
  final BookingsRepository _bookingsRepository;
  final Ref _ref;

  BookingsProvider({
    required BookingsRepository bookingsRepository,
    required Ref ref,
  })  : _bookingsRepository = bookingsRepository,
        _ref = ref,
        super();

  Future<List<BookingModel>> getAllBookings() async {
    return await _bookingsRepository.fetchAll();
  }

  Future<List<BookingModel>> getFilteredBookings({
    BookingStatus? bookingStatus,
    DateTime? bookingDatetime,
    int? userId,
    int? showId,
  }) async {
    final JSON? queryParams = <String, Object?>{
      if (bookingStatus != null) 'booking_status': bookingStatus.toJson,
      if (bookingDatetime != null) 'booking_datetime': bookingDatetime.toString(),
      if (userId != null) 'user_id': userId,
      if (showId != null) 'show_id': showId,
    };
    return await _bookingsRepository.fetchFilteredBookings(
        queryParameters: queryParams);
  }

  Future<BookingModel> getBookingById({
    required int bookingId,
  }) async {
    return await _bookingsRepository.fetchOne(bookingId: bookingId);
  }

  Future<List<UserBookingModel>> getUserBookings({
    required int userId,
  }) async {
    return await _bookingsRepository.fetchUserBookings(userId: userId);
  }

  Future<List<SeatModel>> getShowBookedSeats({
    required int showId,
  }) async {
    return await _bookingsRepository.fetchShowBookings(showId: showId);
  }

  Future<List<int>> bookSelectedSeats() async {
    final userId = _ref.read(authProvider.notifier).currentUserId;
    final showId = _ref.read(selectedShowTimeProvider).showId;
    final selectedSeats = _ref.read(theatersProvider).selectedSeats;
    final bookingIds = <int>[];
    for (var seat in selectedSeats) {
      final newBooking = await _makeABooking(
        userId: userId,
        showId: showId,
        seatRow: seat.seatRow,
        seatNumber: seat.seatNumber,
        price: Constants.ticketPrice,
        bookingStatus: BookingStatus.RESERVED,
        bookingDatetime: clock.now(),
      );
      bookingIds.add(newBooking.bookingId!);
    }
    return bookingIds;
  }

  /// This method is used add booking for the specified seat.
  Future<BookingModel> _makeABooking({
    required int userId,
    required int showId,
    required String seatRow,
    required int seatNumber,
    required double price,
    required DateTime bookingDatetime,
    required BookingStatus bookingStatus,
  }) async {
    final booking = BookingModel(
      bookingId: null,
      userId: userId,
      showId: showId,
      seat: '$seatRow-$seatNumber',
      price: price,
      bookingStatus: bookingStatus,
      bookingDatetime: bookingDatetime,
    );
    final bookingId = await _bookingsRepository.create(data: booking.toJson());

    return booking.copyWith(bookingId: bookingId);
  }

  // Future<String> _editBooking({
  //   required BookingModel booking,
  //   int? userId,
  //   int? showId,
  //   String? seatRow,
  //   int? seatNumber,
  //   double? price,
  //   BookingStatus? bookingStatus,
  //   DateTime? bookingDatetime,
  // }) async {
  //   final data = booking.toUpdateJson(
  //     userId: userId,
  //     showId: showId,
  //     seatRow: seatRow,
  //     seatNumber: seatNumber,
  //     price: price,
  //     bookingStatus: bookingStatus,
  //     bookingDatetime: bookingDatetime,
  //   );
  //   if (data.isEmpty) return "Nothing to update!";
  //   return await _bookingsRepository.update(
  //     bookingId: booking.bookingId!,
  //     data: data,
  //   );
  // }

  Future<String> removeBooking({
    required int bookingId,
  }) async {
    return await _bookingsRepository.delete(bookingId: bookingId);
  }

  void cancelNetworkRequest() {
    _bookingsRepository.cancelRequests();
  }
}
