import 'package:flutter_test/flutter_test.dart';
import 'package:ez_ticketz_app/helper/extensions/int_extension.dart';

void main() {
  group('IntExt', () {
    group('milliseconds', () {
      test(
        'GIVEN a valid integer '
        'WHEN extension method `.milliseconds is called '
        'THEN a Datetime object returned '
        'AND the milliseconds are equal to that `integer`',
        () {
          //given
          const integer = 500;

          //when
          final millisecondsDuration = integer.milliseconds;

          //then
          expect(millisecondsDuration, isA<Duration>());
          expect(millisecondsDuration.inMilliseconds, integer);
        },
      );
    });

    group('microseconds', () {
      test(
        'GIVEN a valid integer '
        'WHEN extension method `.microseconds is called '
        'THEN a Datetime object returned '
        'AND the microseconds are equal to that `integer`',
        () {
          //given
          const integer = 5000;

          //when
          final microsecondsDuration = integer.microseconds;

          //then
          expect(microsecondsDuration, isA<Duration>());
          expect(microsecondsDuration.inMicroseconds, integer);
        },
      );
    });

    group('seconds', () {
      test(
        'GIVEN a valid integer '
        'WHEN extension method `.seconds is called '
        'THEN a Datetime object returned '
        'AND the seconds are equal to that `integer`',
        () {
          //given
          const integer = 5;

          //when
          final secondsDuration = integer.seconds;

          //then
          expect(secondsDuration, isA<Duration>());
          expect(secondsDuration.inSeconds, integer);
        },
      );
    });
  });
}
