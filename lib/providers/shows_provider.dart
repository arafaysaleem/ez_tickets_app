import 'package:hooks_riverpod/hooks_riverpod.dart';

//Services
import '../services/repositories/shows_repository.dart';

//Enums
import '../enums/show_status_enum.dart';
import '../enums/show_type_enum.dart';

//Models
import '../models/show_time_model.dart';
import '../models/show_model.dart';

//Providers
import 'all_providers.dart';
import 'movies_provider.dart';

final showsFutureProvider = FutureProvider<List<ShowModel>>(
      (ref) async {
    final _movieId = ref.watch(selectedMovieProvider).state.movieId;
    final _showsProvider = ref.watch(showsProvider);
    final _showDates = await _showsProvider.getAllShows(movieId: _movieId!);
    return _showDates;
  },
);

final selectedShowProvider = StateProvider<ShowModel>((ref) {
  return ref.watch(showsFutureProvider).maybeWhen(
    data: (shows) => shows[0],
    orElse: () => ShowModel.initial(),
  );
});

final selectedShowTimeProvider = StateProvider<ShowTimeModel>(
      (ref) {
    final _selectedShow = ref.watch(selectedShowProvider).state;
    if (_selectedShow.showTimes.isEmpty) return ShowTimeModel.initial();
    return _selectedShow.showTimes[0];
  },
);

class ShowsProvider {
  final ShowsRepository _showsRepository;

  ShowsProvider(this._showsRepository);

  Future<List<ShowModel>> getAllShows({
    required int movieId,
  }) async {
    final Map<String, dynamic>? queryParams = {
      "movie_id": movieId,
    };
    return await _showsRepository.fetchAll(queryParameters: queryParams);
  }

  Future<ShowModel> getShowById({
    required int showId,
  }) async {
    return await _showsRepository.fetchOne(showId: showId);
  }

  Future<ShowModel> uploadNewShow({
    required int movieId,
    required int theaterId,
    required DateTime startTime,
    required DateTime endTime,
    required DateTime date,
    required ShowType showType,
    required ShowStatus showStatus,
  }) async {
    final Map<String,dynamic> data = {
      "movie_id": movieId,
      "theater_id": theaterId,
      "start_time": startTime,
      "end_time": endTime,
      "date": date,
      "show_type": showType.toJson,
      "show_status": showStatus.toJson,
    };
    final showId = await _showsRepository.create(data: data);
    final showTime = ShowTimeModel(
      showId: showId,
      startTime: startTime,
      endTime: endTime,
      showStatus: showStatus,
      showType: showType,
      theaterId: theaterId,
    );

    final show = ShowModel(
        date: date,
        movieId: movieId,
        showTimes: [showTime]
    );
    return show;
  }

  Future<String> editShow({
    required int showId,
    int? movieId,
    int? theaterId,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? date,
    ShowType? showType,
    ShowStatus? showStatus,
  }) async {
    final Map<String, dynamic> data = {
      if (movieId != null) "movie_id": movieId,
      if (theaterId != null) "theater_id": theaterId,
      if (startTime != null) "start_time": startTime,
      if (endTime != null) "end_time": endTime,
      if (date != null) "date": date,
      if (showType != null) "show_type": showType.toJson,
      if (showStatus != null) "show_status": showStatus.toJson,
    };
    if (data.isEmpty) return "Nothing to update!";
    return await _showsRepository.update(showId: showId, data: data);
  }

  Future<String> removeShow({
    required int showId,
  }) async {
    return await _showsRepository.delete(showId: showId);
  }

  void cancelNetworkRequest() {
    _showsRepository.cancelRequests();
  }
}
