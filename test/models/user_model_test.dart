import 'package:ez_ticketz_app/enums/user_role_enum.dart';
import 'package:ez_ticketz_app/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromJson', () {
    test(
      'GIVEN a valid user json '
      'WHEN a json deserialization is performed'
      'THEN a user model is output',
      () {
        //given
        final json = {
          'user_id': 1,
          'full_name': 'Test User',
          'email': 'test.email@gmail.com',
          'address': 'ABC-1/BLOCK TEST',
          'contact': '03001234567',
          'role': 'api_user',
        };

        //when
        final actual = UserModel.fromJson(json);
        const matcher = UserModel(
          userId: 1,
          fullName: 'Test User',
          email: 'test.email@gmail.com',
          address: 'ABC-1/BLOCK TEST',
          contact: '03001234567',
          role: UserRole.API_USER,
        );

        //then
        expect(actual, matcher);
      },
    );
  });

  group('toJson', () {
    test(
      'GIVEN a user model with user id '
      'WHEN a json serialization is performed '
      'THEN a user json with user id is output',
      () {
        //given
        const user = UserModel(
          userId: 1,
          fullName: 'Test User',
          email: 'test.email@gmail.com',
          address: 'ABC-1/BLOCK TEST',
          contact: '03001234567',
          role: UserRole.API_USER,
        );

        //when
        final actual = user.toJson();
        final matcher = {
          'user_id': 1,
          'full_name': 'Test User',
          'email': 'test.email@gmail.com',
          'address': 'ABC-1/BLOCK TEST',
          'contact': '03001234567',
          'role': 'api_user',
        };

        //then
        expect(actual, matcher);
      },
    );

    test(
      'GIVEN a user model with user id '
      "AND it's user id is null "
      'WHEN a json serialization is performed '
      'THEN a user json is output '
      "AND it doesn't contain a user_id key",
      () {
        //given
        const user = UserModel(
          userId: null,
          fullName: 'Test User',
          email: 'test.email@gmail.com',
          address: 'ABC-1/BLOCK TEST',
          contact: '03001234567',
          role: UserRole.API_USER,
        );

        //when
        final actual = user.toJson();
        final matcher = {
          'full_name': 'Test User',
          'email': 'test.email@gmail.com',
          'address': 'ABC-1/BLOCK TEST',
          'contact': '03001234567',
          'role': 'api_user',
        };

        //then
        expect(actual, matcher);
      },
    );
  });

  group('equality', () {
    test(
      'GIVEN two user models '
      'WHEN properties are different '
      'THEN equality returns false',
      () {
        //given
        const user1 = UserModel(
          userId: 1,
          fullName: 'Test User',
          email: 'test.email@gmail.com',
          address: 'ABC-1/BLOCK TEST',
          contact: '03001234567',
          role: UserRole.API_USER,
        );

        //when
        const user2 = UserModel(
          userId: 2,
          fullName: 'Test User 2',
          email: 'test.email@gmail.com',
          address: 'ABC-1/BLOCK TEST',
          contact: '03001234567',
          role: UserRole.API_USER,
        );

        //then
        expect(user1 == user2, false);
      },
    );

    test(
      'GIVEN two user models '
      'WHEN properties are same '
      'THEN equality returns true',
      () {
        //given
        const user1 = UserModel(
          userId: 1,
          fullName: 'Test User',
          email: 'test.email@gmail.com',
          address: 'ABC-1/BLOCK TEST',
          contact: '03001234567',
          role: UserRole.API_USER,
        );

        //when
        const user2 = UserModel(
          userId: 1,
          fullName: 'Test User',
          email: 'test.email@gmail.com',
          address: 'ABC-1/BLOCK TEST',
          contact: '03001234567',
          role: UserRole.API_USER,
        );

        //then
        expect(user1 == user2, true);
      },
    );
  });
}
