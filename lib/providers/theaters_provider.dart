import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../helper/typedefs.dart';

//Enums
import '../enums/theater_type_enum.dart';

//Models
import '../models/seat_model.dart';
import '../models/show_seating_model.dart';
import '../models/theater_model.dart';

//Services
import '../services/repositories/theaters_repository.dart';
import 'all_providers.dart';

//Providers
import 'shows_provider.dart';

final selectedTheaterNameProvider = StateProvider<String>((_) => '');

/// Does not use `ref.maintainState = true` bcz we wanted to load theater seats
/// everytime because it can receive frequent updates.
final showSeatingFuture = FutureProvider.autoDispose<ShowSeatingModel>((ref) async {
  final _selectedShowTime = ref.watch(selectedShowTimeProvider);
  final _theaterId = _selectedShowTime.theaterId;
  final _showId = _selectedShowTime.showId;

  /// For any provider that can notify listeners, watch it's notifier instead
  /// of state to prevent rebuilds upon listener's notifications.
  final _theatersProvider = ref.watch(theatersProvider.notifier);
  final theater = await _theatersProvider.getTheaterById(theaterId: _theaterId);

  final _bookingsProvider = ref.watch(bookingsProvider);
  final bookedSeats =
      await _bookingsProvider.getShowBookedSeats(showId: _showId);

  ref.watch(selectedTheaterNameProvider.notifier).state = theater.theaterName;

  return ShowSeatingModel(
    showTime: _selectedShowTime,
    theater: theater,
    bookedSeats: bookedSeats,
  );
});

class TheatersProvider extends ChangeNotifier {
  final TheatersRepository _theatersRepository;
  final Map<int,TheaterModel> _theatersMap = {};
  final List<SeatModel> _selectedSeats = [];

  UnmodifiableListView<SeatModel> get selectedSeats =>
      UnmodifiableListView<SeatModel>(_selectedSeats);

  List<String> get selectedSeatNames => _selectedSeats
      .map((seat) => '${seat.seatRow}-${seat.seatNumber}')
      .toList();

  TheatersProvider(this._theatersRepository);

  void toggleSeat({required SeatModel seat, required bool select}) {
    if (select) {
      _selectedSeats.add(seat);
    } else {
      _selectedSeats.remove(seat);
    }
    notifyListeners();
  }

  void clearSelectedSeats() => _selectedSeats.clear();

  Future<List<TheaterModel>> getAllTheaters({
    TheaterType? theaterType,
  }) async {
    final QueryParams? queryParams = {
      if (theaterType != null) 'theater_type': theaterType.toJson,
    };
    final theaters = await _theatersRepository.fetchAll(queryParameters: queryParams);
    for(var theater in theaters) {
      _theatersMap[theater.theaterId!] = theater;
    }
    return theaters;
  }

  Future<TheaterModel> getTheaterById({
    required int theaterId,
  }) async {
    //Check local list for preloaded theaters, return if found.
    if(_theatersMap.containsKey(theaterId)) return _theatersMap[theaterId]!;

    //Else load it from network and cache it in the Map.
    final theater = await _theatersRepository.fetchOne(theaterId: theaterId);
    _theatersMap[theaterId] = theater;
    return theater;
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
    if (data.isEmpty) return 'Nothing to update!';
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
