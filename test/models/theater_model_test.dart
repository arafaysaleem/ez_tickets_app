import 'package:flutter_test/flutter_test.dart';

import 'package:ez_ticketz_app/enums/theater_type_enum.dart';
import 'package:ez_ticketz_app/models/seat_model.dart';
import 'package:ez_ticketz_app/models/theater_model.dart';

void main() {
  const _missingSeatsJson = [
    {
      'seat_row': 'A',
      'seat_number': 3,
    },
    {
      'seat_row': 'B',
      'seat_number': 3,
    },
    {
      'seat_row': 'C',
      'seat_number': 3,
    },
    {
      'seat_row': 'D',
      'seat_number': 3,
    },
  ];

  const _blockedSeatsJson = [
    {
      'seat_row': 'E',
      'seat_number': 1,
    },
    {
      'seat_row': 'E',
      'seat_number': 2,
    },
    {
      'seat_row': 'E',
      'seat_number': 3,
    },
    {
      'seat_row': 'E',
      'seat_number': 4,
    },
  ];

  const _missingSeatModels = [
    SeatModel(
      seatRow: 'A',
      seatNumber: 3,
    ),
    SeatModel(
      seatRow: 'B',
      seatNumber: 3,
    ),
    SeatModel(
      seatRow: 'C',
      seatNumber: 3,
    ),
    SeatModel(
      seatRow: 'D',
      seatNumber: 3,
    ),
  ];

  const _blockedSeatModels = [
    SeatModel(
      seatRow: 'E',
      seatNumber: 1,
    ),
    SeatModel(
      seatRow: 'E',
      seatNumber: 2,
    ),
    SeatModel(
      seatRow: 'E',
      seatNumber: 3,
    ),
    SeatModel(
      seatRow: 'E',
      seatNumber: 4,
    ),
  ];

  group('fromJson', () {
    test(
      'GIVEN a valid theater json '
      'WHEN json deserialization is performed '
      'THEN a theater model is output',
      () {
        //given
        const json = {
          'theater_id': 1,
          'theater_name': 'A',
          'num_of_rows': 10,
          'seats_per_row': 10,
          'theater_type': 'normal',
          'missing': _missingSeatsJson,
          'blocked': _blockedSeatsJson,
        };

        //when
        final actual = TheaterModel.fromJson(json);
        const matcher = TheaterModel(
          theaterId: 1,
          theaterName: 'A',
          numOfRows: 10,
          seatsPerRow: 10,
          theaterType: TheaterType.NORMAL,
          missing: _missingSeatModels,
          blocked: _blockedSeatModels,
        );

        //then
        expect(actual, matcher);
      },
    );
  });

  group('toJson', () {
    test(
      'GIVEN a theater model '
      'WHEN json serialization is performed '
      'THEN a theater json is output',
      () {
        //given
        const model = TheaterModel(
          theaterId: 1,
          theaterName: 'A',
          numOfRows: 10,
          seatsPerRow: 10,
          theaterType: TheaterType.NORMAL,
          missing: _missingSeatModels,
          blocked: _blockedSeatModels,
        );

        //when
        final actual = model.toJson();
        const matcher = {
          'theater_name': 'A',
          'num_of_rows': 10,
          'seats_per_row': 10,
          'theater_type': 'normal',
          'missing': _missingSeatsJson,
          'blocked': _blockedSeatsJson,
        };

        //then
        expect(actual, matcher);
      },
    );

    test(
      'GIVEN a theater model '
      "AND it's theater id is null"
      'WHEN json serialization is performed '
      'THEN a theater json is output '
      "AND it doesn't have a theater_id key",
      () {
        //given
        const model = TheaterModel(
          theaterId: null,
          theaterName: 'A',
          numOfRows: 10,
          seatsPerRow: 10,
          theaterType: TheaterType.NORMAL,
          missing: _missingSeatModels,
          blocked: _blockedSeatModels,
        );

        //when
        final actual = model.toJson();

        //then
        expect(actual.containsKey('theater_id'), false);
      },
    );

    test(
      'GIVEN a theater model '
      "AND it's theater id is non-null"
      'WHEN json serialization is performed '
      'THEN a theater json is output '
      "AND it doesn't have a theater_id key",
      () {
        //given
        const model = TheaterModel(
          theaterId: 1,
          theaterName: 'A',
          numOfRows: 10,
          seatsPerRow: 10,
          theaterType: TheaterType.NORMAL,
          missing: _missingSeatModels,
          blocked: _blockedSeatModels,
        );

        //when
        final actual = model.toJson();

        //then
        expect(actual.containsKey('theater_id'), false);
      },
    );
  });

  group('toUpdateJson', () {
    test(
      'GIVEN a theater model '
      'WHEN json serialization is performed for updating'
      'AND all arguments are null '
      'THEN an empty json is output',
      () {
        //given
        const model = TheaterModel(
          theaterId: null,
          theaterName: 'A',
          numOfRows: 10,
          seatsPerRow: 10,
          theaterType: TheaterType.NORMAL,
          missing: _missingSeatModels,
          blocked: _blockedSeatModels,
        );

        //when
        final actual = model.toUpdateJson();

        //then
        expect(actual.isEmpty, true);
      },
    );

    test(
      'GIVEN a theater model '
      'WHEN json serialization is performed for updating'
      'AND some arguments with new values are given '
      'THEN a theater json is output '
      'AND it has new values for the provided arguments',
      () {
        //given
        const model = TheaterModel(
          theaterId: null,
          theaterName: 'A',
          numOfRows: 10,
          seatsPerRow: 10,
          theaterType: TheaterType.NORMAL,
          missing: _missingSeatModels,
          blocked: _blockedSeatModels,
        );

        //when
        const newTheaterType = TheaterType.ROYAL;
        final actual = model.toUpdateJson(
          theaterType: newTheaterType,
        );
        final matcher = {
          'theater_name': 'A',
          'num_of_rows': 10,
          'seats_per_row': 10,
          'theater_type': 'royal',
          'missing': _missingSeatsJson,
          'blocked': _blockedSeatsJson,
        };

        //then
        expect(actual, matcher);
      },
    );
  });

  group('equality', () {
    test(
      'GIVEN two theater models '
      'WHEN properties are different '
      'THEN equality returns false',
      () {
        //given
        const model1 = TheaterModel(
          theaterId: null,
          theaterName: 'A',
          numOfRows: 10,
          seatsPerRow: 10,
          theaterType: TheaterType.NORMAL,
          missing: _missingSeatModels,
          blocked: _blockedSeatModels,
        );

        //when
        const model2 = TheaterModel(
          theaterId: 1,
          theaterName: 'B',
          numOfRows: 12,
          seatsPerRow: 8,
          theaterType: TheaterType.ROYAL,
          missing: _missingSeatModels,
          blocked: _blockedSeatModels,
        );

        //then
        expect(model1 == model2, false);
      },
    );

    test(
      'GIVEN two theater models '
      'WHEN properties are same '
      'THEN equality returns true',
      () {
        //given
        const model1 = TheaterModel(
          theaterId: null,
          theaterName: 'A',
          numOfRows: 10,
          seatsPerRow: 10,
          theaterType: TheaterType.NORMAL,
          missing: _missingSeatModels,
          blocked: _blockedSeatModels,
        );

        //when
        const missingSeatModels2 = [
          SeatModel(
            seatRow: 'A',
            seatNumber: 3,
          ),
          SeatModel(
            seatRow: 'B',
            seatNumber: 3,
          ),
          SeatModel(
            seatRow: 'C',
            seatNumber: 3,
          ),
          SeatModel(
            seatRow: 'D',
            seatNumber: 3,
          ),
        ];
        const blockedSeatModels2 = [
          SeatModel(
            seatRow: 'E',
            seatNumber: 1,
          ),
          SeatModel(
            seatRow: 'E',
            seatNumber: 2,
          ),
          SeatModel(
            seatRow: 'E',
            seatNumber: 3,
          ),
          SeatModel(
            seatRow: 'E',
            seatNumber: 4,
          ),
        ];
        const model2 = TheaterModel(
          theaterId: null,
          theaterName: 'A',
          numOfRows: 10,
          seatsPerRow: 10,
          theaterType: TheaterType.NORMAL,
          missing: missingSeatModels2,
          blocked: blockedSeatModels2,
        );

        //then
        expect(model1 == model2, true);
      },
    );
  });
}
