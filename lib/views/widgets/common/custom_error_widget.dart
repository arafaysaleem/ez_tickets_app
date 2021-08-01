import 'package:flutter/material.dart';

//Helpers
import '../../../helper/utils/constants.dart';
import '../../../helper/extensions/context_extensions.dart';

//Services
import '../../../services/networking/network_exception.dart';

//Widgets
import 'custom_text_button.dart';

class CustomErrorWidget extends StatelessWidget {
  final NetworkException error;
  final Color backgroundColor;
  final double height;
  final VoidCallback retryCallback;

  const CustomErrorWidget._({
    required this.error,
    required this.backgroundColor,
    required this.retryCallback,
    required this.height,
  });

  const factory CustomErrorWidget.dark({
    required NetworkException error,
    required VoidCallback retryCallback,
    double? height,
  }) = _CustomErrorWidgetDark;

  const factory CustomErrorWidget.light({
    required NetworkException error,
    required VoidCallback retryCallback,
    double? height,
  }) = _CustomErrorWidgetLight;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        height: height,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.fromLTRB(30, 25, 30, 35),
        child: Center(
          child: Column(
            children: [
              Text(
                'Oops',
                style: textTheme.headline1!.copyWith(
                  color: Constants.primaryColor,
                  fontSize: 45,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                error.message,
                textAlign: TextAlign.center,
                style: textTheme.headline5!.copyWith(fontSize: 21),
              ),
              const Spacer(),
              CustomTextButton.gradient(
                width: double.infinity,
                child: Center(
                  child: Text(
                    'RETRY',
                    style: textTheme.bodyText2!.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                onPressed: retryCallback,
                gradient: Constants.buttonGradientRed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomErrorWidgetDark extends CustomErrorWidget {
  const _CustomErrorWidgetDark({
    required NetworkException error,
    required VoidCallback retryCallback,
    double? height,
  }) : super._(
          error: error,
          backgroundColor: Constants.scaffoldGreyColor,
          retryCallback: retryCallback,
          height: height ?? double.infinity,
        );
}

class _CustomErrorWidgetLight extends CustomErrorWidget {
  const _CustomErrorWidgetLight({
    required NetworkException error,
    required VoidCallback retryCallback,
    double? height,
  }) : super._(
          error: error,
          backgroundColor: const Color(0xFFEF9A9A),
          retryCallback: retryCallback,
          height: height ?? double.infinity,
        );
}
