import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ez_ticketz_app/enums/show_status_enum.dart';
import 'package:ez_ticketz_app/enums/show_type_enum.dart';
import 'package:ez_ticketz_app/models/show_model.dart';
import 'package:ez_ticketz_app/models/show_time_model.dart';

void main() {
  late ShowTimeModel _showTimeModel1, _showTimeModel2;

  setUp(() {
    _showTimeModel1 = ShowTimeModel(
      showId: 1,
      theaterId: 1,
      showType: ShowType.i2D,
      showStatus: ShowStatus.FULL,
      startTime: DateTime(2012, 2, 27, 13, 27, 0),
      endTime: DateTime(2012, 2, 27, 14, 27, 0),
    );
    _showTimeModel2 = ShowTimeModel(
      showId: 2,
      theaterId: 5,
      showType: ShowType.i3D,
      showStatus: ShowStatus.FREE,
      startTime: DateTime(2012, 2, 27, 13, 27, 0),
      endTime: DateTime(2012, 2, 27, 14, 27, 0),
    );
  });

  group('fromJson', () {
    test(
      'GIVEN a valid show json '
      'WHEN a json deserialization is performed'
      'THEN a show model is output',
      () {
        //given
        const json = {
          'movie_id': 1,
          'date': '2012-02-27T13:27:00.000',
          'show_times': [
            {
              'show_id': 1,
              'start_time': '2012-02-27T13:27:00.000',
              'end_time': '2012-02-27T14:27:00.000',
              'show_status': 'full',
              'show_type': '2D',
              'theater_id': 1,
            },
            {
              'show_id': 2,
              'start_time': '2012-02-27T13:27:00.000',
              'end_time': '2012-02-27T14:27:00.000',
              'show_status': 'free',
              'show_type': '3D',
              'theater_id': 5,
            },
          ],
        };

        //when
        final actual = ShowModel.fromJson(json);
        final matcher = ShowModel(
          date: DateTime(2012, 2, 27, 13, 27, 0),
          movieId: 1,
          showTimes: [_showTimeModel1, _showTimeModel2],
        );

        //then
        expect(actual, matcher);
      },
    );
  });

  group('toJson', () {
    test(
      'GIVEN show model '
      'WHEN a json serialization is performed '
      'THEN show json is output',
      () {
        //given
        final model = ShowModel(
          date: DateTime(2012, 2, 27, 13, 27, 0),
          movieId: 1,
          showTimes: [_showTimeModel1, _showTimeModel2],
        );

        //when
        final actual = model.toJson();
        final matcher = {
          'movie_id': 1,
          'date': '2012-02-27T13:27:00.000',
          'show_times': [
            {
              'start_time': '2012-02-27T13:27:00.000',
              'end_time': '2012-02-27T14:27:00.000',
              'show_status': 'full',
              'show_type': '2D',
              'theater_id': 1,
            },
            {
              'start_time': '2012-02-27T13:27:00.000',
              'end_time': '2012-02-27T14:27:00.000',
              'show_status': 'free',
              'show_type': '3D',
              'theater_id': 5,
            },
          ],
        };

        //then
        expect(actual, matcher);
      },
    );
  });

  group('initial', () {
    test(
      'GIVEN a set of default values for different properties'
      'WHEN factory constructor `initial` is called'
      'THEN an show model is output '
      "AND it's properties match those set of properties",
      () {
        //given
        const defaultInt = 0;
        final defaultDatetime = DateTime.now();
        const defaultList = <ShowTimeModel>[];

        //when
        final model = withClock(Clock.fixed(defaultDatetime), () {
          return ShowModel.initial();
        });

        //then
        expect(model.date, defaultDatetime);
        expect(model.movieId, defaultInt);
        expect(model.showTimes, defaultList);
      },
    );
  });

  group('equality', () {
    test(
      'GIVEN two show models '
      'WHEN properties are different '
      'THEN equality returns false',
      () {
        //given
        final model1 = ShowModel(
          date: DateTime(2012, 2, 27, 13, 27, 0),
          movieId: 1,
          showTimes: [_showTimeModel1, _showTimeModel2],
        );

        //when
        final model2 = ShowModel(
          date: DateTime(2012, 2, 27, 15, 27, 0), //different hour
          movieId: 1,
          showTimes: [_showTimeModel1, _showTimeModel2],
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
        final model1 = ShowModel(
          date: DateTime(2012, 2, 27, 13, 27, 0),
          movieId: 1,
          showTimes: [_showTimeModel1, _showTimeModel2],
        );

        //when
        final showTimes2 = [
          ShowTimeModel(
            showId: 1,
            theaterId: 1,
            showType: ShowType.i2D,
            showStatus: ShowStatus.FULL,
            startTime: DateTime(2012, 2, 27, 13, 27, 0),
            endTime: DateTime(2012, 2, 27, 14, 27, 0),
          ),
          ShowTimeModel(
            showId: 2,
            theaterId: 5,
            showType: ShowType.i3D,
            showStatus: ShowStatus.FREE,
            startTime: DateTime(2012, 2, 27, 13, 27, 0),
            endTime: DateTime(2012, 2, 27, 14, 27, 0),
          )
        ];

        final model2 = ShowModel(
          date: DateTime(2012, 2, 27, 13, 27, 0),
          movieId: 1,
          showTimes: showTimes2,
        );

        //then
        expect(model1 == model2, true);
      },
    );
  });
}
