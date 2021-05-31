//Enums
import '../enums/booking_status_enum.dart';

//Models
import '../models/booking_model.dart';
import '../models/user_booking_model.dart';
import '../models/seat_model.dart';

//Services
import '../services/repositories/bookings_repository.dart';

class BookingsProvider {
  final BookingsRepository _bookingsRepository;

  BookingsProvider(this._bookingsRepository);

  Future<List<BookingModel>> getAllBookings({
    BookingStatus? bookingStatus,
  }) async {
    final Map<String, String>? queryParams = {
      if (bookingStatus != null) "booking_status": bookingStatus.toJson,
    };
    return await _bookingsRepository.fetchAll(queryParameters: queryParams);
  }

  Future<BookingModel> getBookingById({
    required int bookingId,
  }) async {
    return await _bookingsRepository.fetchOne(bookingId: bookingId);
  }

  Future<BookingModel> makeABooking({
    required int userId,
    required int showId,
    required String seatRow,
    required int seatNumber,
    required double price,
    required BookingStatus bookingStatus,
    required DateTime bookingDatetime,
  }) async {
    final booking = BookingModel(
      bookingId: null,
      userId: userId,
      showId: showId,
      seatRow: seatRow,
      seatNumber: seatNumber,
      price: price,
      bookingStatus: bookingStatus,
      bookingDatetime: bookingDatetime,
    );
    final bookingId = await _bookingsRepository.create(data: booking.toJson());

    return booking.copyWith(bookingId: bookingId);
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

  Future<String> editBooking({
    required BookingModel booking,
    required int userId,
    required int showId,
    required String seatRow,
    required int seatNumber,
    required double price,
    required BookingStatus bookingStatus,
    required DateTime bookingDatetime,
  }) async {
    final data = booking.toUpdateJson(
      userId: userId,
      showId: showId,
      seatRow: seatRow,
      seatNumber: seatNumber,
      price: price,
      bookingStatus: bookingStatus,
      bookingDatetime: bookingDatetime,
    );
    if (data.isEmpty) return "Nothing to update!";
    return await _bookingsRepository.update(
        bookingId: booking.bookingId!, data: data);
  }

  Future<String> removeBooking({
    required int bookingId,
  }) async {
    return await _bookingsRepository.delete(bookingId: bookingId);
  }

  void cancelNetworkRequest() {
    _bookingsRepository.cancelRequests();
  }
}
