import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final double height;
  final double? width;
  final VoidCallback onPressed;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final Border? border;
  final Gradient? gradient;
  final double borderRadius;
  final Widget child;

  const CustomTextButton({
    Key? key,
    double? height,
    double? borderRadius,
    this.width,
    this.gradient,
    this.border,
    this.color,
    this.padding,
    required this.child,
    required this.onPressed,
  })   : borderRadius = borderRadius ?? 7,
        height = height ?? 60,
        super(key: key);

  const factory CustomTextButton.gradient({
    Key? key,
    double? height,
    double? width,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    required Widget child,
    required VoidCallback onPressed,
    required Gradient gradient,
  }) = _CustomTextButtonWithGradient;

  const factory CustomTextButton.outlined({
    Key? key,
    double? height,
    double? width,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    required Border border,
    required Widget child,
    required VoidCallback onPressed,
  }) = _CustomTextButtonOutlined;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textButtonTheme = theme.textButtonTheme;
    return TextButton(
      style: textButtonTheme.style!.copyWith(
        overlayColor: MaterialStateProperty.all(theme.primaryColor),
      ),
      onPressed: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
          gradient: gradient,
          color: color,
        ),
        child: child,
      ),
    );
  }
}

class _CustomTextButtonWithGradient extends CustomTextButton {
  const _CustomTextButtonWithGradient({
    Key? key,
    double? height,
    double? width,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    required Widget child,
    required VoidCallback onPressed,
    required Gradient gradient,
  }) : super(
          key: key,
          height: height,
          width: width,
          padding: padding,
          borderRadius: borderRadius,
          child: child,
          onPressed: onPressed,
          gradient: gradient,
        );
}

class _CustomTextButtonOutlined extends CustomTextButton {
  const _CustomTextButtonOutlined({
    Key? key,
    double? height,
    double? width,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    required Border border,
    required Widget child,
    required VoidCallback onPressed,
  }) : super(
          key: key,
          height: height,
          width: width,
          padding: padding,
          borderRadius: borderRadius,
          border: border,
          child: child,
          onPressed: onPressed,
        );
}
