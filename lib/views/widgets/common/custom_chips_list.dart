import 'package:flutter/material.dart';

import '../../../helper/utils/constants.dart';

class CustomChipsList extends StatelessWidget {
  final List<String> chipContents;
  final double chipHeight, chipGap;
  final double? chipWidth;
  final double fontSize;
  final FontWeight? fontWeight;
  final double borderWidth;
  final ScrollPhysics physics;
  final Color borderColor, backgroundColor, contentColor;

  const CustomChipsList({
    Key? key,
    this.fontWeight,
    this.chipWidth,
    this.chipGap = 0.0,
    this.fontSize = 12,
    this.borderWidth = 1.0,
    this.physics = const NeverScrollableScrollPhysics(),
    this.borderColor = Constants.textGreyColor,
    this.backgroundColor = Colors.white,
    this.contentColor = Constants.textGreyColor,
    required this.chipContents,
    required this.chipHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: chipHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for(var i = 0; i < chipContents.length; i++)
            Padding(
              padding: EdgeInsets.only(left: i == 0 ? 0 : chipGap),
              child: Container(
                width: chipWidth,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: borderColor, width: borderWidth),
                ),
                child: Center(
                  child: Text(
                    chipContents[i],
                    style: TextStyle(
                        color: contentColor,
                        fontSize: fontSize,
                        height: 1,
                        fontWeight: fontWeight
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
