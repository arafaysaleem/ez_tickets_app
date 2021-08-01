import 'package:flutter_test/flutter_test.dart';
import 'package:ez_ticketz_app/enums/movie_type_enum.dart';

void main() {
  group('MovieTypeEnum', () {
    group('name', () {
      test(
        'GIVEN a movie type enum '
        'WHEN `.name` extension method is called '
        'THEN the name of the enum is returned',
        () {
          //given
          const enumValue = MovieType.COMING_SOON;

          final enumName = enumValue.toString().split('.').last;

          //when
          final name = enumValue.name;

          //then
          expect(name, enumName);
        },
      );
    });

    group('toJson', () {
      test(
        'GIVEN a movie type enum '
        'WHEN `.toJson` extension method is called '
        'THEN the json key of the enum value is returned',
        () {
          //given
          const enumValue = MovieType.NOW_SHOWING;

          final enumJson = enumValue.toString().split('.').last.toLowerCase();

          //when
          final toJson = enumValue.toJson;

          //then
          expect(toJson, enumJson);
        },
      );
    });
  });
}
