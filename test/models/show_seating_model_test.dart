//Enums
import 'package:ez_ticketz_app/enums/show_status_enum.dart';
import 'package:ez_ticketz_app/enums/show_type_enum.dart';
import 'package:ez_ticketz_app/enums/theater_type_enum.dart';

//Models
import 'package:ez_ticketz_app/models/seat_model.dart';
import 'package:ez_ticketz_app/models/show_seating_model.dart';
import 'package:ez_ticketz_app/models/show_time_model.dart';
import 'package:ez_ticketz_app/models/theater_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const _theaterModel = TheaterModel(
    theaterId: 1,
    theaterName: 'A',
    numOfRows: 10,
    seatsPerRow: 10,
    theaterType: TheaterType.NORMAL,
    missing: [
      SeatModel(seatRow: 'A', seatNumber: 3),
      SeatModel(seatRow: 'B', seatNumber: 3),
      SeatModel(seatRow: 'C', seatNumber: 3),
      SeatModel(seatRow: 'D', seatNumber: 3),
    ],
    blocked: [
      SeatModel(seatRow: 'E', seatNumber: 1),
      SeatModel(seatRow: 'E', seatNumber: 2),
      SeatModel(seatRow: 'E', seatNumber: 3),
      SeatModel(seatRow: 'E', seatNumber: 4),
    ],
  );

  final _showTimeModel = ShowTimeModel(
    showId: 1,
    theaterId: 1,
    showType: ShowType.i2D,
    showStatus: ShowStatus.FULL,
    startTime: DateTime(2012, 2, 27, 13, 27, 0),
    endTime: DateTime(2012, 2, 27, 14, 27, 0),
  );

  const _bookedSeatModels = [
    SeatModel(seatRow: 'A', seatNumber: 1),
    SeatModel(seatRow: 'A', seatNumber: 2),
    SeatModel(seatRow: 'A', seatNumber: 4),
    SeatModel(seatRow: 'A', seatNumber: 5),
  ];

  group('equality', () {
    test(
      'GIVEN two show seating models '
      'WHEN properties are different '
      'THEN equality returns false',
      () {
        //given
        final model1 = ShowSeatingModel(
          showTime: _showTimeModel,
          theater: _theaterModel,
          bookedSeats: _bookedSeatModels,
        );

        //when
        final model2 = ShowSeatingModel(
          showTime: _showTimeModel,
          theater: _theaterModel,
          bookedSeats: const [
            SeatModel(seatRow: 'B', seatNumber: 1),
            SeatModel(seatRow: 'B', seatNumber: 2),
            SeatModel(seatRow: 'B', seatNumber: 4),
            SeatModel(seatRow: 'B', seatNumber: 5),
          ],
        );

        //then
        expect(model1 == model2, false);
      },
    );

    test(
      'GIVEN two show seating models '
      'WHEN properties are same '
      'THEN equality returns true',
      () {
        //given
        final model1 = ShowSeatingModel(
          showTime: _showTimeModel,
          theater: _theaterModel,
          bookedSeats: _bookedSeatModels,
        );

        //when
        const theaterModel2 = TheaterModel(
          theaterId: 1,
          theaterName: 'A',
          numOfRows: 10,
          seatsPerRow: 10,
          theaterType: TheaterType.NORMAL,
          missing: [
            SeatModel(seatRow: 'A', seatNumber: 3),
            SeatModel(seatRow: 'B', seatNumber: 3),
            SeatModel(seatRow: 'C', seatNumber: 3),
            SeatModel(seatRow: 'D', seatNumber: 3),
          ],
          blocked: [
            SeatModel(seatRow: 'E', seatNumber: 1),
            SeatModel(seatRow: 'E', seatNumber: 2),
            SeatModel(seatRow: 'E', seatNumber: 3),
            SeatModel(seatRow: 'E', seatNumber: 4),
          ],
        );
        final showTimeModel2 = ShowTimeModel(
          showId: 1,
          theaterId: 1,
          showType: ShowType.i2D,
          showStatus: ShowStatus.FULL,
          startTime: DateTime(2012, 2, 27, 13, 27, 0),
          endTime: DateTime(2012, 2, 27, 14, 27, 0),
        );
        const bookedSeatModels2 = [
          SeatModel(seatRow: 'A', seatNumber: 1),
          SeatModel(seatRow: 'A', seatNumber: 2),
          SeatModel(seatRow: 'A', seatNumber: 4),
          SeatModel(seatRow: 'A', seatNumber: 5),
        ];
        final model2 = ShowSeatingModel(
          showTime: showTimeModel2,
          theater: theaterModel2,
          bookedSeats: bookedSeatModels2,
        );

        //then
        expect(model1 == model2, true);
      },
    );
  });
}
