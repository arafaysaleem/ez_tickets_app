import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double width;
  final double radius;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit? fit;
  final EdgeInsetsGeometry? margin;
  final Widget? placeholder;
  final Widget? errorWidget;
  final VoidCallback? onTap;

  const CustomNetworkImage({
    double? width,
    double? radius,
    this.margin,
    this.fit,
    this.height,
    this.onTap,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    required this.imageUrl,
  })   : width = width ?? double.infinity,
        radius = radius ?? 20;

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
      errorWidget: (_,__,Object? ___) => Padding(
        padding: margin ?? EdgeInsets.zero,
        child: errorWidget ?? const SizedBox.shrink(),
      ),
      imageBuilder: (ctx, imageProvider) => GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider,fit: fit),
            borderRadius: borderRadius ?? BorderRadius.circular(radius),
          ),
          margin: margin,
        ),
      ),
    );
  }
}
