import 'package:flutter/material.dart';

//Helpers
import '../../../helper/utils/constants.dart';

class SeatWidget extends StatefulWidget {
  const SeatWidget({
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