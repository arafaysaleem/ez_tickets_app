import 'package:flutter_test/flutter_test.dart';
import 'package:ez_ticketz_app/enums/theater_type_enum.dart';

void main() {
  group('TheaterTypeEnum', () {
    group('name', () {
      test(
        'GIVEN a theater type enum '
        'WHEN `.name` extension method is called '
        'THEN the name of the enum is returned',
        () {
          //given
          const enumValue = TheaterType.NORMAL;

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
        'GIVEN a theater type enum '
        'WHEN `.toJson` extension method is called '
        'THEN the json key of the enum value is returned',
        () {
          //given
          const enumValue = TheaterType.NORMAL;

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
