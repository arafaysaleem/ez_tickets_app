import 'package:flutter_test/flutter_test.dart';
import 'package:ez_ticketz_app/enums/booking_status_enum.dart';

void main() {
  group('BookingStatusEnum', () {
    group('name', () {
      test(
        'GIVEN a booking status enum '
        'WHEN `.name` extension method is called '
        'THEN the name of the enum is returned',
        () {
          //given
          const enumValue = BookingStatus.RESERVED;

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
        'GIVEN a booking status enum '
        'WHEN `.toJson` extension method is called '
        'THEN the json key of the enum value is returned',
        () {
          //given
          const enumValue = BookingStatus.CONFIRMED;

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
