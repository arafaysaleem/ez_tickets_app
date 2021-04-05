import 'package:flutter/material.dart';

import '../../helper/utils/constants.dart';

class MoviePosterPlaceholder extends StatelessWidget {
  const MoviePosterPlaceholder({
    this.height,
    this.padding,
    Alignment? childAlign,
  }) : this.childAlign = childAlign ?? Alignment.center;

  final double? height;
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
        borderRadius: const BorderRadius.all(Radius.circular(20)),
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
