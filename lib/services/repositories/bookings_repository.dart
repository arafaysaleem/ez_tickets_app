import 'package:dio/dio.dart';

//models
import '../../models/booking_model.dart';
import '../../models/user_booking_model.dart';
import '../../models/seat_model.dart';

//services
import '../networking/api_endpoint.dart';
import '../networking/api_service.dart';

//helpers
import '../../helper/typedefs.dart';

class BookingsRepository {
  final ApiService _apiService;
  final CancelToken? _cancelToken;

  BookingsRepository({
    required ApiService apiService,
    CancelToken? cancelToken,
  })  : _apiService = apiService,
        _cancelToken = cancelToken;

  Future<List<BookingModel>> fetchAll() async {
    return await _apiService.getCollectionData<BookingModel>(
      endpoint: ApiEndpoint.bookings(BookingEndpoint.BASE),
      cancelToken: _cancelToken,
      converter: (responseBody) => BookingModel.fromJson(responseBody),
    );
  }

  Future<BookingModel> fetchOne({
    required int bookingId,
  }) async {
    return await _apiService.getDocumentData<BookingModel>(
      endpoint: ApiEndpoint.bookings(BookingEndpoint.BY_ID, id: bookingId),
      cancelToken: _cancelToken,
      converter: (responseBody) => BookingModel.fromJson(responseBody),
    );
  }

  Future<int> create({
    required JSON data,
  }) async {
    return await _apiService.setData<int>(
      endpoint: ApiEndpoint.bookings(BookingEndpoint.BASE),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['body']['booking_id'] as int,
    );
  }

  Future<String> update({
    required int bookingId,
    required JSON data,
  }) async {
    return await _apiService.updateData<String>(
      endpoint: ApiEndpoint.bookings(BookingEndpoint.BY_ID, id: bookingId),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<String> delete({
    required int bookingId,
    JSON? data,
  }) async {
    return await _apiService.deleteData<String>(
      endpoint: ApiEndpoint.bookings(BookingEndpoint.BY_ID, id: bookingId),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<List<SeatModel>> fetchShowBookings({
    required int showId,
  }) async {
    return await _apiService.getDocumentData<List<SeatModel>>(
      endpoint: ApiEndpoint.bookings(BookingEndpoint.SHOWS, id: showId),
      cancelToken: _cancelToken,
      converter: (responseBody) {
        return responseBody['booked_seats'].map<SeatModel>((dynamic seat) {
          return SeatModel.fromJson(seat as JSON);
        }).toList() as List<SeatModel>;
      },
    );
  }

  Future<List<UserBookingModel>> fetchUserBookings({
    required int userId,
  }) async {
    return await _apiService.getCollectionData<UserBookingModel>(
      endpoint: ApiEndpoint.bookings(BookingEndpoint.USERS, id: userId),
      cancelToken: _cancelToken,
      converter: (responseBody) => UserBookingModel.fromJson(responseBody),
    );
  }

  Future<List<BookingModel>> fetchFilteredBookings({
    JSON? queryParameters,
  }) async {
    return await _apiService.getCollectionData<BookingModel>(
      endpoint: ApiEndpoint.bookings(BookingEndpoint.FILTERS),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => BookingModel.fromJson(responseBody),
    );
  }

  void cancelRequests() {
    _apiService.cancelRequests(cancelToken: _cancelToken);
  }
}