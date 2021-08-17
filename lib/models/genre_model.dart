import 'package:freezed_annotation/freezed_annotation.dart';
import '../helper/typedefs.dart';

part 'genre_model.freezed.dart';

part 'genre_model.g.dart';

@freezed
class GenreModel with _$GenreModel {
  const factory GenreModel({
    required int genreId,
    required String genre,
  }) = _GenreModel;

  factory GenreModel.fromJson(JSON json) =>
      _$GenreModelFromJson(json);
}
