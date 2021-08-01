import 'package:flutter_test/flutter_test.dart';
import 'package:ez_ticketz_app/enums/show_type_enum.dart';

void main() {
  group('ShowTypeEnum', () {
    group('name', () {
      test(
        'GIVEN a show type enum '
        'WHEN `.name` extension method is called '
        'THEN the name of the enum is returned',
        () {
          //given
          const enumValue = ShowType.i2D;

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
        'GIVEN a show type enum '
        'WHEN `.toJson` extension method is called '
        'THEN the json key of the enum value is returned',
        () {
          //given
          const enumValue = ShowType.i2D;

          final enumJson = enumValue.toString().split('.').last.substring(1);

          //when
          final toJson = enumValue.toJson;

          //then
          expect(toJson, enumJson);
        },
      );
    });
  });
}
