import 'package:flutter/material.dart';

abstract class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder();

  const factory ImagePlaceholder.skeleton({
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) = _ImagePlaceholderSkeleton;

  const factory ImagePlaceholder.error({
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
  }) = _ImagePlaceholderError;

  const factory ImagePlaceholder.custom({
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    required Widget child,
  }) = _ImagePlaceholderCustom;

  @override
  Widget build(BuildContext context);
}

class _ImagePlaceholderSkeleton extends ImagePlaceholder {
  final double borderRadius;
  final EdgeInsetsGeometry? margin, padding;

  const _ImagePlaceholderSkeleton({
    double? borderRadius,
    this.padding,
    this.margin,
  })  : this.borderRadius = borderRadius ?? 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      margin: margin,
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: BorderRadius.circular(borderRadius - 5),
        ),
      ),
    );
  }
}

class _ImagePlaceholderError extends ImagePlaceholder {
  final double borderRadius;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin, padding;

  const _ImagePlaceholderError({
    double? borderRadius,
    this.padding,
    this.margin,
    this.backgroundColor,
  })   : this.borderRadius = borderRadius ?? 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.red[200],
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      margin: margin,
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.error_outline_sharp, color: Colors.red, size: 30,),
          SizedBox(height: 10),
          Text(
            "Loading failed",
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}

class _ImagePlaceholderCustom extends ImagePlaceholder {
  final double borderRadius;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin, padding;
  final Widget child;

  const _ImagePlaceholderCustom({
    double? borderRadius,
    this.padding,
    this.margin,
    this.backgroundColor,
    required this.child,
  })   : this.borderRadius = borderRadius ?? 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.red[200],
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      margin: margin,
      padding: padding,
      child: child,
    );
  }
}