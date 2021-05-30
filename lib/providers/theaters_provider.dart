import 'package:hooks_riverpod/hooks_riverpod.dart';

//Services
import '../services/repositories/theaters_repository.dart';

//Enums
import '../enums/theater_type_enum.dart';

//Models
import '../models/theater_model.dart';

//Providers
import 'all_providers.dart';

final showTheaterFuture = FutureProvider.family.autoDispose<TheaterModel, int>(
      (ref, theaterId) async {
    final _theatersProvider = ref.watch(theatersProvider);

    final theater = await _theatersProvider.getTheaterById(theaterId: theaterId);

    return theater;
  },
);

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

  // Future<TheaterModel> uploadNewTheater({
  //   required int movieId,
  //   required int theaterId,
  //   required DateTime startTime,
  //   required DateTime endTime,
  //   required DateTime date,
  //   required TheaterType theaterType,
  //   required TheaterStatus theaterStatus,
  // }) async {
  //   final data = <String, dynamic>{
  //     "movie_id": movieId,
  //     "theater_id": theaterId,
  //     "start_time": startTime,
  //     "end_time": endTime,
  //     "date": date,
  //     "theater_type": theaterType.toJson,
  //     "theater_status": theaterStatus.toJson,
  //   };
  //   final theaterId = await _theatersRepository.create(data: data);
  //   final theaterTime = TheaterTimeModel(
  //     theaterId: theaterId,
  //     startTime: startTime,
  //     endTime: endTime,
  //     theaterStatus: theaterStatus,
  //     theaterType: theaterType,
  //     theaterId: theaterId,
  //   );
  //
  //   final theater = TheaterModel(
  //       date: date,
  //       movieId: movieId,
  //       theaterTimes: [theaterTime]
  //   );
  //   return theater;
  // }
  //
  // Future<String> editTheater({
  //   required int theaterId,
  //   int? movieId,
  //   int? theaterId,
  //   DateTime? startTime,
  //   DateTime? endTime,
  //   DateTime? date,
  //   TheaterType? theaterType,
  //   TheaterStatus? theaterStatus,
  // }) async {
  //   final data = <String, dynamic>{
  //     if (movieId != null) "movie_id": movieId,
  //     if (theaterId != null) "theater_id": theaterId,
  //     if (startTime != null) "start_time": startTime,
  //     if (endTime != null) "end_time": endTime,
  //     if (date != null) "date": date,
  //     if (theaterType != null) "theater_type": theaterType.toJson,
  //     if (theaterStatus != null) "theater_status": theaterStatus.toJson,
  //   };
  //   if (data.isEmpty) return "Nothing to update!";
  //   return await _theatersRepository.update(theaterId: theaterId, data: data);
  // }
  //
  // Future<String> removeTheater({
  //   required int theaterId,
  // }) async {
  //   return await _theatersRepository.delete(theaterId: theaterId);
  // }

  void cancelNetworkRequest() {
    _theatersRepository.cancelRequests();
  }
}
