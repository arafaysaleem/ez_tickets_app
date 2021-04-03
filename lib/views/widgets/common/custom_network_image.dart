import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double width;
  final double borderRadius;
  final BoxFit? fit;
  final EdgeInsetsGeometry? margin;
  final Widget Function(
    BuildContext context,
    String url,
  )? placeholder;
  final Widget Function(
    BuildContext context,
    String url,
    dynamic error,
  )? errorWidget;

  CustomNetworkImage({
    double? width,
    double? borderRadius,
    this.margin,
    this.fit,
    this.height,
    this.placeholder,
    this.errorWidget,
    required this.imageUrl,
  })   : this.width = width ?? double.infinity,
        this.borderRadius = borderRadius ?? 20;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      placeholder: placeholder,
      errorWidget: errorWidget,
      imageBuilder: (ctx, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        margin: margin,
      ),
    );
  }
}
