import 'package:flutter_test/flutter_test.dart';

import 'package:ez_ticketz_app/enums/movie_type_enum.dart';
import 'package:ez_ticketz_app/models/genre_model.dart';
import 'package:ez_ticketz_app/models/movie_model.dart';

void main() {
  const _genresJson = [
    {'genre_id': 1, 'genre': 'Horror'},
    {'genre_id': 2, 'genre': 'Comedy'},
    {'genre_id': 3, 'genre': 'Sci-Fi'},
  ];

  const _genreModels = [
    GenreModel(genreId: 1, genre: 'Horror'),
    GenreModel(genreId: 2, genre: 'Comedy'),
    GenreModel(genreId: 3, genre: 'Sci-Fi'),
  ];

  group('fromJson', () {
    test(
      'GIVEN a valid movie json '
      'WHEN json deserialization is performed '
      'THEN a movie model is output',
      () {
        //given
        const json = {
          'movie_id': 1,
          'title': 'Test Movie',
          'summary': 'Some summary',
          'trailer_url': 'www.placeholders.com/test_video',
          'poster_url': 'www.placeholders.com/test_image',
          'year': 2021,
          'rating': 4.5,
          'movie_type': 'now_showing',
          'genres': _genresJson,
        };

        //when
        final actual = MovieModel.fromJson(json);
        final matcher = MovieModel(
          movieId: 1,
          year: 2021,
          rating: 4.5,
          title: 'Test Movie',
          summary: 'Some summary',
          trailerUrl: 'www.placeholders.com/test_video',
          posterUrl: 'www.placeholders.com/test_image',
          genres: _genreModels,
          movieType: MovieType.NOW_SHOWING,
        );

        //then
        expect(actual, matcher);
      },
    );

    test(
      'GIVEN a valid movie json '
      'AND rating key is missing'
      'WHEN json deserialization is performed '
      'THEN a movie model is output '
      "AND it's rating defaults to 0.0",
      () {
        //given
        const json = {
          'movie_id': 1,
          'title': 'Test Movie',
          'summary': 'Some summary',
          'trailer_url': 'www.placeholders.com/test_video',
          'poster_url': 'www.placeholders.com/test_image',
          'year': 2021,
          'movie_type': 'now_showing',
          'genres': _genresJson,
        };

        //when
        final actual = MovieModel.fromJson(json);
        final matcher = MovieModel(
          movieId: 1,
          year: 2021,
          rating: 0.0,
          title: 'Test Movie',
          summary: 'Some summary',
          trailerUrl: 'www.placeholders.com/test_video',
          posterUrl: 'www.placeholders.com/test_image',
          genres: _genreModels,
          movieType: MovieType.NOW_SHOWING,
        );

        //then
        expect(actual, matcher);
      },
    );
  });

  group('toJson', () {
    test(
      'GIVEN a movie model '
      'WHEN json serialization is performed '
      'THEN a movie json is output',
      () {
        //given
        final model = MovieModel(
          movieId: 1,
          year: 2021,
          rating: 4.5,
          title: 'Test Movie',
          summary: 'Some summary',
          trailerUrl: 'www.placeholders.com/test_video',
          posterUrl: 'www.placeholders.com/test_image',
          genres: _genreModels,
          movieType: MovieType.NOW_SHOWING,
        );

        //when
        final actual = model.toJson();
        const matcher = {
          'title': 'Test Movie',
          'summary': 'Some summary',
          'trailer_url': 'www.placeholders.com/test_video',
          'poster_url': 'www.placeholders.com/test_image',
          'year': 2021,
          'rating': 4.5,
          'movie_type': 'now_showing',
          'genres': [1, 2, 3],
        };

        //then
        expect(actual, matcher);
      },
    );

    test(
      'GIVEN a movie model '
      'WHEN json serialization is performed '
      'THEN a movie json is output '
      "AND it's `genres` key contains a list of genre ids",
      () {
        //given
        final model = MovieModel(
          movieId: 1,
          year: 2021,
          rating: 4.5,
          title: 'Test Movie',
          summary: 'Some summary',
          trailerUrl: 'www.placeholders.com/test_video',
          posterUrl: 'www.placeholders.com/test_image',
          genres: _genreModels,
          movieType: MovieType.NOW_SHOWING,
        );

        //when
        final actual = model.toJson();

        //then
        expect(actual['genres'], [1, 2, 3]);
      },
    );

    test(
      'GIVEN a movie model '
      "AND it's movie id is null"
      'WHEN json serialization is performed '
      'THEN a movie json is output '
      "AND it doesn't have a movie_id key",
      () {
        //given
        final model = MovieModel(
          movieId: null,
          year: 2021,
          rating: 4.5,
          title: 'Test Movie',
          summary: 'Some summary',
          trailerUrl: 'www.placeholders.com/test_video',
          posterUrl: 'www.placeholders.com/test_image',
          genres: _genreModels,
          movieType: MovieType.NOW_SHOWING,
        );

        //when
        final actual = model.toJson();

        //then
        expect(actual.containsKey('movie_id'), false);
      },
    );

    test(
      'GIVEN a movie model '
      "AND it's movie id is non-null"
      'WHEN json serialization is performed '
      'THEN a movie json is output '
      "AND it doesn't have a movie_id key",
      () {
        //given
        final model = MovieModel(
          movieId: 1,
          year: 2021,
          rating: 4.5,
          title: 'Test Movie',
          summary: 'Some summary',
          trailerUrl: 'www.placeholders.com/test_video',
          posterUrl: 'www.placeholders.com/test_image',
          genres: _genreModels,
          movieType: MovieType.NOW_SHOWING,
        );

        //when
        final actual = model.toJson();

        //then
        expect(actual.containsKey('movie_id'), false);
      },
    );

    test(
      'GIVEN a movie model '
      "AND it's rating isn't passed a value"
      'WHEN json serialization is performed '
      'THEN a movie json is output '
      "AND it's rating key is 0.0",
      () {
        //given
        final model = MovieModel(
          movieId: 1,
          year: 2021,
          title: 'Test Movie',
          summary: 'Some summary',
          trailerUrl: 'www.placeholders.com/test_video',
          posterUrl: 'www.placeholders.com/test_image',
          genres: _genreModels,
          movieType: MovieType.NOW_SHOWING,
        );

        //when
        final actual = model.toJson();

        //then
        expect(actual['rating'], 0.0);
      },
    );
  });

  group('toUpdateJson', () {
    test(
      'GIVEN a movie model '
      'WHEN json serialization is performed for updating'
      'AND all arguments are null '
      'THEN an empty json is output',
      () {
        //given
        final model = MovieModel(
          movieId: 1,
          year: 2021,
          rating: 4.5,
          title: 'Test Movie',
          summary: 'Some summary',
          trailerUrl: 'www.placeholders.com/test_video',
          posterUrl: 'www.placeholders.com/test_image',
          genres: _genreModels,
          movieType: MovieType.NOW_SHOWING,
        );

        //when
        final actual = model.toUpdateJson();

        //then
        expect(actual.isEmpty, true);
      },
    );

    test(
      'GIVEN a movie model '
      'WHEN json serialization is performed for updating'
      'AND some arguments with new values are given '
      'THEN a movie json is output '
      'AND it has new values for the provided arguments',
      () {
        //given
        final model = MovieModel(
          movieId: 1,
          year: 2021,
          rating: 4.5,
          title: 'Test Movie',
          summary: 'Some summary',
          trailerUrl: 'www.placeholders.com/test_video',
          posterUrl: 'www.placeholders.com/test_image',
          genres: _genreModels,
          movieType: MovieType.NOW_SHOWING,
        );

        //when
        const newMovieType = MovieType.COMING_SOON;
        final actual = model.toUpdateJson(
          movieType: newMovieType,
        );
        final matcher = {
          'title': 'Test Movie',
          'summary': 'Some summary',
          'trailer_url': 'www.placeholders.com/test_video',
          'poster_url': 'www.placeholders.com/test_image',
          'year': 2021,
          'rating': 4.5,
          'movie_type': 'coming_soon',
          'genres': [1, 2, 3],
        };

        //then
        expect(actual, matcher);
      },
    );
  });

  group('initial', () {
    test(
      'GIVEN a set of default values for different properties'
      'WHEN factory constructor `initial` is called'
      'THEN an movie model is output '
      "AND it's properties match those set of properties",
      () {
        //given
        const defaultString = '';
        const defaultInt = 0;
        const int? defaultMovieId = null;
        const defaultList = <GenreModel>[];
        const defaultMovieType = MovieType.COMING_SOON;

        //when
        final model = MovieModel.initial();

        //then
        expect(model.title, defaultString);
        expect(model.summary, defaultString);
        expect(model.posterUrl, defaultString);
        expect(model.trailerUrl, defaultString);
        expect(model.year, defaultInt);
        expect(model.movieId, defaultMovieId);
        expect(model.genres, defaultList);
        expect(model.movieType, defaultMovieType);
      },
    );
  });

  group('getGenreName', () {
    test(
      'GIVEN a movie model '
      'WHEN the variable genreNames is accessed '
      'THEN a list of genre names is output',
      () {
        //given
        final model = MovieModel(
          movieId: 1,
          year: 2021,
          rating: 4.5,
          title: 'Test Movie',
          summary: 'Some summary',
          trailerUrl: 'www.placeholders.com/test_video',
          posterUrl: 'www.placeholders.com/test_image',
          genres: _genreModels,
          movieType: MovieType.NOW_SHOWING,
        );

        //when
        final genreNames = model.genreNames;

        //then
        expect(genreNames, ['Horror', 'Comedy', 'Sci-Fi']);
      },
    );
  });

  group('equality', () {
    test(
      'GIVEN two movie models '
      'WHEN properties are different '
      'THEN equality returns false',
      () {
        //given
        final model1 = MovieModel(
          movieId: 1,
          year: 2021,
          rating: 4.5,
          title: 'Test Movie',
          summary: 'Some summary',
          trailerUrl: 'www.placeholders.com/test_video',
          posterUrl: 'www.placeholders.com/test_image',
          genres: _genreModels,
          movieType: MovieType.NOW_SHOWING,
        );

        //when
        final model2 = MovieModel(
          movieId: 1,
          year: 2022,
          rating: 6.5,
          title: 'Test Movie 2',
          summary: 'Some summary',
          trailerUrl: 'www.placeholders.com/test_video',
          posterUrl: 'www.placeholders.com/test_image',
          genres: _genreModels,
          movieType: MovieType.COMING_SOON,
        );

        //then
        expect(model1 == model2, false);
      },
    );

    test(
      'GIVEN two movie models '
      'WHEN properties are same '
      'THEN equality returns true',
      () {
        //given
        final model1 = MovieModel(
          movieId: 1,
          year: 2021,
          rating: 4.5,
          title: 'Test Movie',
          summary: 'Some summary',
          trailerUrl: 'www.placeholders.com/test_video',
          posterUrl: 'www.placeholders.com/test_image',
          genres: _genreModels,
          movieType: MovieType.NOW_SHOWING,
        );

        //when
        const genreModels2 = [
          GenreModel(genreId: 1, genre: 'Horror'),
          GenreModel(genreId: 2, genre: 'Comedy'),
          GenreModel(genreId: 3, genre: 'Sci-Fi'),
        ];
        final model2 = MovieModel(
          movieId: 1,
          year: 2021,
          rating: 4.5,
          title: 'Test Movie',
          summary: 'Some summary',
          trailerUrl: 'www.placeholders.com/test_video',
          posterUrl: 'www.placeholders.com/test_image',
          genres: genreModels2,
          movieType: MovieType.NOW_SHOWING,
        );

        //then
        expect(model1 == model2, true);
      },
    );
  });
}
