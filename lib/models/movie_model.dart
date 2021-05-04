import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/movie_type_enum.dart';
import 'genre_model.dart';

part 'movie_model.freezed.dart';

part 'movie_model.g.dart';

T? toNull<T>(_) => null;

List<int> toJsonGenres(List<GenreModel> genres) {
  return genres.map((genre) => genre.genreId).toList(growable: false);
}

@freezed
class MovieModel with _$MovieModel {
  MovieModel._();

  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  factory MovieModel({
    @JsonKey(toJson: toNull, includeIfNull: false) required int? movieId,
    required int year,
    required String title,
    required String summary,
    required String trailerUrl,
    required String posterUrl,
    required double? rating,
    @JsonKey(toJson: toJsonGenres) required List<GenreModel> genres,
    required MovieType movieType,
  }) = _MovieModel;

  factory MovieModel.initial(){
    return MovieModel(
      movieId: null,
      year: 0,
      title: "",
      summary: "",
      trailerUrl: "",
      posterUrl: "",
      rating: null,
      genres: [],
      movieType: MovieType.COMING_SOON,
    );
  }

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  late final List<String> genreNames =
      genres.map((genre) => genre.genre).toList(growable: false);
}
