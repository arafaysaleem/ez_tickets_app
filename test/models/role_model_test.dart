import 'package:flutter_test/flutter_test.dart';

import 'package:ez_ticketz_app/models/role_model.dart';

void main() {
  group('fromJson', () {
    test(
      'GIVEN a valid role json '
      'WHEN json deserialization is performed '
      'THEN a role model is output',
      () {
        //given
        final json = {
          'role_id': 1,
          'full_name': 'Mr.Test',
          'age': 30,
          'picture_url': 'www.placeholders.com/test_image',
        };

        //when
        final actual = RoleModel.fromJson(json);
        const matcher = RoleModel(
          roleId: 1,
          fullName: 'Mr.Test',
          age: 30,
          pictureUrl: 'www.placeholders.com/test_image',
        );

        //then
        expect(actual, matcher);
      },
    );
  });

  group('toJson', () {
    test(
      'GIVEN a role model '
      'WHEN json serialization is performed '
      'THEN a role json is output',
      () {
        //given
        const role = RoleModel(
          roleId: 1,
          fullName: 'Mr.Test',
          age: 30,
          pictureUrl: 'www.placeholders.com/test_image',
        );

        //when
        final actual = role.toJson();
        final matcher = {
          'role_id': 1,
          'full_name': 'Mr.Test',
          'age': 30,
          'picture_url': 'www.placeholders.com/test_image',
        };

        //then
        expect(actual, matcher);
      },
    );
  });

  group('equality', () {
    test(
      'GIVEN two role models '
      'WHEN properties are different '
      'THEN equality returns false',
      () {
        //given
        const role1 = RoleModel(
          roleId: 1,
          fullName: 'Mr.Test',
          age: 30,
          pictureUrl: 'www.placeholders.com/test_image',
        );

        //when
        const role2 = RoleModel(
          roleId: 2,
          fullName: 'Mrs.Test',
          age: 30,
          pictureUrl: 'www.placeholders.com/test_image',
        );

        //then
        expect(role1 == role2, false);
      },
    );

    test(
      'GIVEN two role models '
      'WHEN properties are same '
      'THEN equality returns true',
      () {
        //given
        const role1 = RoleModel(
          roleId: 1,
          fullName: 'Mr.Test',
          age: 30,
          pictureUrl: 'www.placeholders.com/test_image',
        );

        //when
        const role2 = RoleModel(
          roleId: 1,
          fullName: 'Mr.Test',
          age: 30,
          pictureUrl: 'www.placeholders.com/test_image',
        );

        //then
        expect(role1 == role2, true);
      },
    );
  });
}
