import 'package:flutter_test/flutter_test.dart';
import 'package:ez_ticketz_app/enums/user_role_enum.dart';

void main() {
  group('UserRoleEnum', () {
    group('name', () {
      test(
        'GIVEN a user role enum '
        'WHEN `.name` extension method is called '
        'THEN the name of the enum is returned',
        () {
          //given
          const enumValue = UserRole.API_USER;

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
        'GIVEN a user role enum '
        'WHEN `.toJson` extension method is called '
        'THEN the json key of the enum value is returned',
        () {
          //given
          const enumValue = UserRole.API_USER;

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
