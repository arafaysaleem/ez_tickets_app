import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double width;
  final double borderRadius;
  final BoxFit? fit;
  final EdgeInsetsGeometry? margin;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CustomNetworkImage({
    double? width,
    double? borderRadius,
    this.margin,
    this.fit,
    this.height,
    this.placeholder,
    this.errorWidget,
    required this.imageUrl,
  })   : width = width ?? double.infinity,
        borderRadius = borderRadius ?? 20;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      placeholder: (_,__) => Padding(
        padding: margin ?? EdgeInsets.zero,
        child: placeholder ?? const SizedBox.shrink(),
      ),
      errorWidget: (_,__,___) => Padding(
        padding: margin ?? EdgeInsets.zero,
        child: errorWidget ?? const SizedBox.shrink(),
      ),
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
