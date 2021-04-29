import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/movie_type_enum.dart';

import 'movie_role_model.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
abstract class MovieModel with _$MovieModel {

  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory MovieModel({
    required int movieId,
    required String year,
    required String summary,
    required String trailerUrl,
    required String posterUrl,
    required double rating,
    required List<MovieRoleModel> roles,
    required MovieType movieType,
  }) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
}
