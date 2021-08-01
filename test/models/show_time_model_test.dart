import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ez_ticketz_app/enums/show_status_enum.dart';
import 'package:ez_ticketz_app/enums/show_type_enum.dart';
import 'package:ez_ticketz_app/models/show_time_model.dart';

void main() {
  group('fromJson', () {
    test(
      'GIVEN a valid show time json '
      'WHEN a json deserialization is performed'
      'THEN a show time model is output',
      () {
        //given
        final json = {
          'show_id': 1,
          'start_time': '2012-02-27T13:27:00.000',
          'end_time': '2012-02-27T14:27:00.000',
          'show_status': 'full',
          'show_type': '2D',
          'theater_id': 1,
        };

        //when
        final actual = ShowTimeModel.fromJson(json);
        final matcher = ShowTimeModel(
          showId: 1,
          theaterId: 1,
          showType: ShowType.i2D,
          showStatus: ShowStatus.FULL,
          startTime: DateTime(2012, 2, 27, 13, 27, 0),
          endTime: DateTime(2012, 2, 27, 14, 27, 0),
        );

        //then
        expect(actual, matcher);
      },
    );
  });

  group('toJson', () {
    test(
      'GIVEN show time model '
      'WHEN a json serialization is performed '
      'THEN show time json is output',
      () {
        //given
        final model = ShowTimeModel(
          showId: 1,
          theaterId: 1,
          showType: ShowType.i2D,
          showStatus: ShowStatus.FULL,
          startTime: DateTime(2012, 2, 27, 13, 27, 0),
          endTime: DateTime(2012, 2, 27, 14, 27, 0),
        );

        //when
        final actual = model.toJson();
        final matcher = {
          'start_time': '2012-02-27T13:27:00.000',
          'end_time': '2012-02-27T14:27:00.000',
          'show_status': 'full',
          'show_type': '2D',
          'theater_id': 1,
        };

        //then
        expect(actual, matcher);
      },
    );

    test(
      'GIVEN a show time model '
      'AND without specifying a show id'
      'WHEN json serialization is performed '
      'THEN a show time json is output '
      "AND it doesn't have a show_id key",
      () {
        //given
        final model = ShowTimeModel(
          theaterId: 1,
          showType: ShowType.i2D,
          showStatus: ShowStatus.FULL,
          startTime: DateTime(2012, 2, 27, 13, 27, 0),
          endTime: DateTime(2012, 2, 27, 14, 27, 0),
        );

        //when
        final actual = model.toJson();

        //then
        expect(actual.containsKey('show_id'), false);
      },
    );

    test(
      'GIVEN a show time model '
      'AND with a show id specified'
      'WHEN json serialization is performed '
      'THEN a show time json is output '
      "AND it doesn't have a show_id key",
      () {
        //given
        final model = ShowTimeModel(
          showId: 10,
          theaterId: 1,
          showType: ShowType.i2D,
          showStatus: ShowStatus.FULL,
          startTime: DateTime(2012, 2, 27, 13, 27, 0),
          endTime: DateTime(2012, 2, 27, 14, 27, 0),
        );

        //when
        final actual = model.toJson();

        //then
        expect(actual.containsKey('show_id'), false);
      },
    );
  });

  group('initial', () {
    test(
      'GIVEN a set of default values for different properties'
      'WHEN factory constructor `initial` is called'
      'THEN an show time model is output '
      "AND it's properties match those set of properties",
      () {
        //given
        const defaultInt = 0;
        final defaultDatetime = DateTime.now();
        const defaultShowStatus = ShowStatus.FREE;
        const defaultShowType = ShowType.i2D;

        //when
        final model = withClock(Clock.fixed(defaultDatetime), (){
          return ShowTimeModel.initial();
        });

        //then
        expect(model.startTime, defaultDatetime);
        expect(model.endTime, defaultDatetime);
        expect(model.theaterId, defaultInt);
        expect(model.showType, defaultShowType);
        expect(model.showStatus, defaultShowStatus);
      },
    );
  });

  group('equality', () {
    test(
      'GIVEN two show time models '
      'WHEN properties are different '
      'THEN equality returns false',
      () {
        //given
        final model1 = ShowTimeModel(
          showId: 1,
          theaterId: 1,
          showType: ShowType.i2D,
          showStatus: ShowStatus.FULL,
          startTime: DateTime(2012, 2, 27, 13, 27, 0),
          endTime: DateTime(2012, 2, 27, 14, 27, 0),
        );

        //when
        final model2 = ShowTimeModel(
          showId: 1,
          theaterId: 1,
          showType: ShowType.i2D,
          showStatus: ShowStatus.FREE,
          startTime: DateTime(2012, 2, 27, 13, 27, 0),
          endTime: DateTime(2012, 2, 27, 14, 27, 0),
        );

        //then
        expect(model1 == model2, false);
      },
    );

    test(
      'GIVEN two show time models '
      'WHEN properties are same '
      'THEN equality returns true',
      () {
        //given
        final model1 = ShowTimeModel(
          showId: 1,
          theaterId: 1,
          showType: ShowType.i2D,
          showStatus: ShowStatus.FULL,
          startTime: DateTime(2012, 2, 27, 13, 27, 0),
          endTime: DateTime(2012, 2, 27, 14, 27, 0),
        );

        //when
        final model2 = ShowTimeModel(
          showId: 1,
          theaterId: 1,
          showType: ShowType.i2D,
          showStatus: ShowStatus.FULL,
          startTime: DateTime(2012, 2, 27, 13, 27, 0),
          endTime: DateTime(2012, 2, 27, 14, 27, 0),
        );

        //then
        expect(model1 == model2, true);
      },
    );
  });
}
