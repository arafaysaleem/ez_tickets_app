import 'package:ez_ticketz_app/models/role_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ez_ticketz_app/enums/role_type_enum.dart';
import 'package:ez_ticketz_app/models/movie_role_model.dart';

void main() {
  group("fromJson", () {
    test(
      "GIVEN a json serialization is needed"
      "WHEN a valid movie role json is input"
      "THEN a movie role model is output",
      () {
        //given
        const roleJson = {
          "role_id": 1,
          "full_name": "Mr.Test",
          "age": 30,
          "picture_url": "www.placeholders.com/test_image",
        };
        final movieRoleJson = {
          "movie_id": 1,
          "role": roleJson,
          "role_type": RoleType.CAST.toJson,
        };

        //when
        final actual = MovieRoleModel.fromJson(movieRoleJson);
        final roleModel = RoleModel.fromJson(roleJson);
        final matcher = MovieRoleModel(
          movieId: 1,
          role: roleModel,
          roleType: RoleType.CAST,
        );

        //then
        expect(actual, matcher);
      },
    );
  });

  group("toJson", () {
    test(
      "GIVEN a json deserialization is needed"
      "WHEN a movie role model is converted"
      "THEN a movie role json is output",
      () {
        //given
        const roleModel = RoleModel(
          roleId: 1,
          fullName: "Mr.Test",
          age: 30,
          pictureUrl: "www.placeholders.com/test_image",
        );
        const movieRole = MovieRoleModel(
          movieId: 1,
          role: roleModel,
          roleType: RoleType.CAST,
        );

        //when
        final actual = movieRole.toCustomJson();
        final matcher = {
          "role_id": 1,
          "role_type": RoleType.CAST.toJson,
        };

        //then
        expect(actual, matcher);
      },
    );
  });

  group("equality", () {
    test(
      "GIVEN two movie role models"
      "WHEN properties are different"
      "THEN equality returns false",
      () {
        //given
        const roleModel = RoleModel(
          roleId: 1,
          fullName: "Mr.Test",
          age: 30,
          pictureUrl: "www.placeholders.com/test_image",
        );
        const movieRole1 = MovieRoleModel(
          movieId: 1,
          role: roleModel,
          roleType: RoleType.DIRECTOR,
        );

        //when
        const movieRole2 = MovieRoleModel(
          movieId: 1,
          role: roleModel,
          roleType: RoleType.PRODUCER,
        );

        //then
        expect(movieRole1 == movieRole2, false);
      },
    );

    test(
      "GIVEN two movie role models"
      "WHEN properties are same"
      "THEN equality returns true",
      () {
        //given
        const roleModel = RoleModel(
          roleId: 1,
          fullName: "Mr.Test",
          age: 30,
          pictureUrl: "www.placeholders.com/test_image",
        );
        const movieRole1 = MovieRoleModel(
          movieId: 1,
          role: roleModel,
          roleType: RoleType.DIRECTOR,
        );

        //when
        const movieRole2 = MovieRoleModel(
          movieId: 1,
          role: roleModel,
          roleType: RoleType.DIRECTOR,
        );

        //then
        expect(movieRole1 == movieRole2, true);
      },
    );
  });
}
