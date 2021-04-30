import 'package:flutter/material.dart';

//Constants
import '../../../helper/utils/constants.dart';

//Services
import '../../../services/networking/network_exception.dart';

//Widgets
import 'custom_text_button.dart';

class CustomErrorWidget extends StatelessWidget {
  final NetworkException error;
  final Color backgroundColor;

  const CustomErrorWidget._(this.error, this.backgroundColor);

  factory CustomErrorWidget.dark(
    NetworkException error,
  ) = _CustomErrorWidgetDark;

  factory CustomErrorWidget.light(
    NetworkException error,
  ) = _CustomErrorWidgetLight;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        height: 350,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.fromLTRB(30, 25, 30, 35),
        child: Center(
          child: Column(
            children: [
              Text(
                "Oops",
                style: textTheme.headline1!.copyWith(
                  color: Constants.primaryColor,
                  fontSize: 45,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                error.message,
                style: textTheme.headline5!.copyWith(
                  fontSize: 21,
                ),
              ),
              const Spacer(),
              CustomTextButton.gradient(
                width: double.infinity,
                child: Center(
                  child: Text(
                    "RETRY",
                    style: textTheme.bodyText2!.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 1.1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                onPressed: () {},
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
  _CustomErrorWidgetDark(NetworkException error)
      : super._(error, Constants.scaffoldGreyColor);
}

class _CustomErrorWidgetLight extends CustomErrorWidget {
  _CustomErrorWidgetLight(
    NetworkException error,
  ) : super._(error, Colors.red[200]!);
}
