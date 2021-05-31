import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Helpers
import '../../../helper/utils/constants.dart';

//Providers
import '../../../providers/all_providers.dart';

//Models
import '../../../models/seat_model.dart';

class SeatWidget extends StatefulWidget {
  final SeatModel seat;

  const SeatWidget({
    required this.seat,
    Key? key,
  }) : super(key: key);

  @override
  _SeatWidgetState createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          final _theatersProvider = context.read(theatersProvider);
          if(isSelected){
            _theatersProvider.selectSeat(widget.seat);
          }
          else {
            _theatersProvider.unSelectSeat(widget.seat);
          }
        });
      },
      child: isSelected
          ? const DecoratedBox(
        decoration: BoxDecoration(
          color: Constants.redColor,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      )
          : const DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );
  }
}