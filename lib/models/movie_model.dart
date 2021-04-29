import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/movie_type_enum.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

T? toNull<T>(_) => null;

@freezed
class MovieModel with _$MovieModel {

  @JsonSerializable(fieldRename: FieldRename.snake)
  factory MovieModel({
    @JsonKey(toJson: toNull, includeIfNull: false)
    required int movieId,
    required String title,
    required String year,
    required String summary,
    required String trailerUrl,
    required String posterUrl,
    required double rating,
    required MovieType movieType,
  }) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
}
