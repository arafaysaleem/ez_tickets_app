import 'package:flutter_test/flutter_test.dart';

import 'package:ez_ticketz_app/models/genre_model.dart';

void main() {
  group('fromJson', () {
    test(
      'GIVEN a valid genre json '
      'WHEN json deserialization is performed '
      'THEN a genre model is output',
      () {
        //given
        final json = {
          'genre_id': 1,
          'genre': 'Horror',
        };

        //when
        final actual = GenreModel.fromJson(json);
        const matcher = GenreModel(
          genreId: 1,
          genre: 'Horror',
        );

        //then
        expect(actual, matcher);
      },
    );
  });

  group('toJson', () {
    test(
      'GIVEN a genre model '
      'WHEN json serialization is performed '
      'THEN a genre json is output',
      () {
        //given
        const genre = GenreModel(
          genreId: 1,
          genre: 'Horror',
        );

        //when
        final actual = genre.toJson();
        final matcher = {
          'genre_id': 1,
          'genre': 'Horror',
        };

        //then
        expect(actual, matcher);
      },
    );
  });

  group('equality', () {
    test(
      'GIVEN two genre models '
      'WHEN properties are different '
      'THEN equality returns false',
      () {
        //given
        const genre1 = GenreModel(
          genreId: 1,
          genre: 'Horror',
        );

        //when
        const genre2 = GenreModel(
          genreId: 2,
          genre: 'Crime',
        );

        //then
        expect(genre1 == genre2, false);
      },
    );

    test(
      'GIVEN two genre models '
      'WHEN properties are same '
      'THEN equality returns true',
      () {
        //given
        const genre1 = GenreModel(
          genreId: 1,
          genre: 'Horror',
        );

        //when
        const genre2 = GenreModel(
          genreId: 1,
          genre: 'Horror',
        );

        //then
        expect(genre1 == genre2, true);
      },
    );
  });
}
