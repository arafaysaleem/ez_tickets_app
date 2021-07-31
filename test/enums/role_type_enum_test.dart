import 'package:flutter_test/flutter_test.dart';

import 'package:ez_ticketz_app/enums/role_type_enum.dart';
import 'package:ez_ticketz_app/helper/extensions/string_extension.dart';

void main() {
  group("RoleTypeEnum", () {
    group("name", () {
      test(
        "GIVEN a role type enum "
        "WHEN `.name` extension method is called "
        "THEN the name of the enum is returned",
        () {
          //given
          const enumValue = RoleType.DIRECTOR;

          final enumName = enumValue.toString().split(".").last;

          //when
          final name = enumValue.name;

          //then
          expect(name, enumName);
        },
      );
    });

    group("toJson", () {
      test(
        "GIVEN a role type enum "
        "WHEN `.toJson` extension method is called "
        "THEN the json key of the enum value is returned",
        () {
          //given
          const enumValue = RoleType.DIRECTOR;

          final enumJson = enumValue.toString().split(".").last.toLowerCase();

          //when
          final toJson = enumValue.toJson;

          //then
          expect(toJson, enumJson);
        },
      );
    });

    group("inString", () {
      test(
        "GIVEN a role type enum "
        "WHEN `.inString` extension method is called "
        "THEN the string representation of the enum value is returned",
        () {
          //given
          const enumValue = RoleType.DIRECTOR;

          final enumString = enumValue.toString().split(".").last.capitalize;

          //when
          final inString = enumValue.inString;

          //then
          expect(inString, enumString);
        },
      );
    });
  });
}
