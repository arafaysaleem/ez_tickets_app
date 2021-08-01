import 'package:flutter_test/flutter_test.dart';

import 'package:ez_ticketz_app/enums/show_status_enum.dart';
import 'package:ez_ticketz_app/helper/extensions/string_extension.dart';

void main() {
  group('ShowStatusEnum', () {
    group('name',(){
      test(
        'GIVEN a show status enum '
        'WHEN `.name` extension method is called '
        'THEN the name of the enum is returned',
        () {
          //given
          const enumValue = ShowStatus.ALMOST_FULL;

          final enumName = enumValue.toString().split('.').last;

          //when
          final name = enumValue.name;

          //then
          expect(name, enumName);
        },
      );
    });

    group('toJson',(){
      test(
        'GIVEN a show status enum '
        'WHEN `.toJson` extension method is called '
        'THEN the json key of the enum value is returned',
        () {
          //given
          const enumValue = ShowStatus.ALMOST_FULL;

          final enumJson = enumValue.toString().split('.').last.toLowerCase();

          //when
          final toJson = enumValue.toJson;

          //then
          expect(toJson, enumJson);
        },
      );
    });

    group('inString',(){
      test(
        'GIVEN a show status enum '
        'WHEN `.inString` extension method is called '
        'THEN the string representation of the enum value is returned',
        () {
          //given
          const enumValue = ShowStatus.ALMOST_FULL;

          final enumString =
              enumValue.toString().split('.').last.removeUnderScore.toUpperCase();

          //when
          final inString = enumValue.inString;

          //then
          expect(inString, enumString);
        },
      );
    });
  });
}
