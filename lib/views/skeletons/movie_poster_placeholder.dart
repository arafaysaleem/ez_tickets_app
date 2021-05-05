import 'package:flutter/material.dart';

import '../../helper/utils/constants.dart';

class MoviePosterPlaceholder extends StatelessWidget {
  final double? height;
  final double borderRadius, iconSize;
  final AlignmentGeometry childXAlign;
  final EdgeInsetsGeometry? margin;
  final EdgeInsets? padding;

  const MoviePosterPlaceholder({
    this.height,
    this.padding,
    this.margin,
    Alignment? childXAlign,
    MainAxisAlignment? childYAlign,
    double? borderRadius,
    double? iconSize,
    double? fontSize,
  })  : childXAlign = childXAlign ?? Alignment.center,
        borderRadius = borderRadius ?? 20,
        iconSize = iconSize ?? 65;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: Constants.scaffoldColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Align(
        alignment: childXAlign,
        child: Icon(
          Icons.movie_creation_rounded,
          color: Constants.primaryColor,
          size: iconSize,
        ),
      ),
    );
  }
}
