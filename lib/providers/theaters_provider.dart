import 'package:hooks_riverpod/hooks_riverpod.dart';

//Enums
import '../enums/theater_type_enum.dart';
import '../models/seat_model.dart';

//Models
import '../models/theater_model.dart';

//Services
import '../services/repositories/theaters_repository.dart';

//Providers
import 'shows_provider.dart';
import 'all_providers.dart';

final showTheaterFuture = FutureProvider.autoDispose<TheaterModel>((ref) async {
  final _theatersProvider = ref.watch(theatersProvider);
  final _theaterId = ref.watch(selectedShowTimeProvider).state.theaterId;

  final theater = await _theatersProvider.getTheaterById(theaterId: _theaterId);
  return theater;
});

class TheatersProvider {
  final TheatersRepository _theatersRepository;

  TheatersProvider(this._theatersRepository);

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
    required int theaterId,
    String? theaterName,
    int? numOfRows,
    int? seatsPerRow,
    TheaterType? theaterType,
    List<SeatModel>? missing,
    List<SeatModel>? blocked,
  }) async {
    final data = <String, dynamic>{
      if (theaterName != null) "theater_name": theaterName,
      if (numOfRows != null) "num_of_rows": numOfRows,
      if (seatsPerRow != null) "seats_per_row": seatsPerRow,
      if (theaterType != null) "theater_type": theaterType.toJson,
      if (missing != null) "missing": missing.map((s) => s.toJson()).toList(),
      if (blocked != null) "blocked": blocked.map((s) => s.toJson()).toList(),
    };
    if (data.isEmpty) return "Nothing to update!";
    return await _theatersRepository.update(theaterId: theaterId, data: data);
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
