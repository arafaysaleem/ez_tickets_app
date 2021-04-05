import 'package:flutter/material.dart';

import '../../helper/utils/constants.dart';

class MoviePosterPlaceholder extends StatelessWidget {
  const MoviePosterPlaceholder({
    this.height,
    this.padding,
    Alignment? childAlign,
    double? borderRadius,
  })  : this.childAlign = childAlign ?? Alignment.center,
        this.borderRadius = borderRadius ?? 20;

  final double? height;
  final double borderRadius;
  final AlignmentGeometry childAlign;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: Constants.scaffoldColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Align(
        alignment: childAlign,
        child: Icon(
          Icons.movie_creation_rounded,
          color: Constants.primaryColor,
          size: 45,
        ),
      ),
    );
  }
}
