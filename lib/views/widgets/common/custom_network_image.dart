import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../skeletons/image_placeholder.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;

  final Widget Function(
    BuildContext context,
    ImageProvider imageProvider,
  )? imageBuilder;

  final Widget Function(
    BuildContext context,
    String url,
  )? placeholder;

  final Widget Function(
    BuildContext context,
    String url,
    dynamic error,
  )? errorWidget;

  final double height, width;

  final EdgeInsetsGeometry? padding, margin;

  factory CustomNetworkImage.container({
    required String imageUrl,
    required double height,
    double? width,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    final Widget Function(
      BuildContext context,
      String url,
    )?
        placeholder,
    final Widget Function(
      BuildContext context,
      String url,
      dynamic error,
    )?
        errorWidget,
  }) = _CustomNetworkImageWithContainer;

  const CustomNetworkImage({
    Key? key,
    EdgeInsetsGeometry? padding,
    double? width,
    this.margin,
    this.imageBuilder,
    this.placeholder,
    this.errorWidget,
    required this.imageUrl,
    required this.height,
  })   : this.padding = padding ?? const EdgeInsets.all(20),
        this.width = width ?? double.infinity,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: imageBuilder,
      height: height,
      width: width,
      placeholder: placeholder ??
          (ctx, url) => ImagePlaceholder.skeleton(
                padding: padding,
                margin: margin,
              ),
      errorWidget: errorWidget ??
          (ctx, url, errors) => ImagePlaceholder.error(
                padding: padding,
                margin: margin,
              ),
    );
  }
}

class _CustomNetworkImageWithContainer extends CustomNetworkImage {
  _CustomNetworkImageWithContainer({
    required String imageUrl,
    required double height,
    double? width,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    final Widget Function(
      BuildContext context,
      String url,
    )?
        placeholder,
    final Widget Function(
      BuildContext context,
      String url,
      dynamic error,
    )?
        errorWidget,
  }) : super(
            imageUrl: imageUrl,
            height: height,
            width: width,
            padding: padding,
            margin: margin,
            placeholder: placeholder,
            errorWidget: errorWidget,
            imageBuilder: (ctx, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: margin,
                ));
}
