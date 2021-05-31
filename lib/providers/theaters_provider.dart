import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Enums
import '../enums/theater_type_enum.dart';

//Models
import '../models/seat_model.dart';
import '../models/theater_model.dart';
import '../models/show_seating_model.dart';

//Services
import '../services/repositories/theaters_repository.dart';

//Providers
import 'shows_provider.dart';
import 'all_providers.dart';

final showSeatingFuture = FutureProvider.autoDispose<ShowSeatingModel>((ref) async {
  final _selectedShowTime = ref.watch(selectedShowTimeProvider).state;

  final _theatersProvider = ref.watch(theatersProvider);
  final _theaterId = _selectedShowTime.theaterId;
  final theater = await _theatersProvider.getTheaterById(theaterId: _theaterId);

  final _bookingsProvider = ref.watch(bookingsProvider);
  final _showId = _selectedShowTime.showId;
  final bookedSeats = await _bookingsProvider.getShowBookedSeats(showId: _showId);

  //create and return a ShowSeatingModel

  return ShowSeatingModel(
    showTime: _selectedShowTime,
    theater: theater,
    bookedSeats: bookedSeats,
  );
});

class TheatersProvider {
  //TODO: Convert to a change notifier
  final TheatersRepository _theatersRepository;

  final List<SeatModel> _selectedSeats = [];

  UnmodifiableListView get selectedSeats => UnmodifiableListView(_selectedSeats);

  TheatersProvider(this._theatersRepository);

  void selectSeat(SeatModel seat){
    _selectedSeats.add(seat);
    print(_selectedSeats);
  }

  void unSelectSeat(SeatModel seat){
    _selectedSeats.remove(seat);
  }

  Future<List<TheaterModel>> getAllTheaters({
    TheaterType? theaterType,
  }) async {
    final Map<String, String>? queryParams = {
      if (theaterType != null) "theater_type": theaterType.toJson,
    };
    return await _theatersRepository.fetchAll(queryParameters: queryParams);
  }

  Future<TheaterModel> getTheaterById({
    required int theaterId,
  }) async {
    return await _theatersRepository.fetchOne(theaterId: theaterId);
  }

  Future<TheaterModel> uploadNewTheater({
    required String theaterName,
    required int numOfRows,
    required int seatsPerRow,
    required TheaterType theaterType,
    required List<SeatModel> missing,
    required List<SeatModel> blocked,
  }) async {
    final theater = TheaterModel(
      theaterId: null,
      theaterName: theaterName,
      numOfRows: numOfRows,
      seatsPerRow: seatsPerRow,
      theaterType: theaterType,
      missing: missing,
      blocked: blocked,
    );
    final theaterId = await _theatersRepository.create(data: theater.toJson());

    return theater.copyWith(theaterId: theaterId);
  }

  Future<String> editTheater({
    required TheaterModel theater,
    String? theaterName,
    int? numOfRows,
    int? seatsPerRow,
    TheaterType? theaterType,
    List<SeatModel>? missing,
    List<SeatModel>? blocked,
  }) async {
    final data = theater.toUpdateJson(
      theaterName: theaterName,
      numOfRows: numOfRows,
      seatsPerRow: seatsPerRow,
      theaterType: theaterType,
      missing: missing,
      blocked: blocked,
    );
    if (data.isEmpty) return "Nothing to update!";
    return await _theatersRepository.update(
        theaterId: theater.theaterId!, data: data);
  }

  Future<String> removeTheater({
    required int theaterId,
  }) async {
    return await _theatersRepository.delete(theaterId: theaterId);
  }

  void cancelNetworkRequest() {
    _theatersRepository.cancelRequests();
  }
}
