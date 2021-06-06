import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';


//Helpers
import '../../../helper/extensions/context_extensions.dart';
import '../../../helper/utils/constants.dart';

class CustomTextField extends StatefulWidget {
  final String floatingText, hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final String? Function(String? value) validator;
  final void Function(String? value)? onSaved;
  final AlignmentGeometry errorTextAlign;
  final Widget? prefix;
  final bool autofocus;
  final int? maxLength;
  final TextStyle hintStyle, errorStyle, inputStyle;
  final TextStyle? floatingStyle;
  final Color fillColor;

  const CustomTextField({
    Key? key,
    this.onSaved,
    this.prefix,
    this.maxLength,
    this.floatingStyle,
    this.errorTextAlign = Alignment.centerRight,
    this.autofocus = false,
    this.hintStyle = const TextStyle(
      fontSize: 17,
      color: Constants.textWhite80Color,
    ),
    this.errorStyle = const TextStyle(
      height: 0,
      color: Colors.transparent,
    ),
    this.inputStyle = const TextStyle(
      fontSize: 17,
      color: Constants.textWhite80Color,
    ),
    this.fillColor = Constants.scaffoldColor,
    required this.controller,
    required this.floatingText,
    required this.hintText,
    required this.keyboardType,
    required this.textInputAction,
    required this.validator,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? errorText;
  bool showPassword = false;

  bool get hasErrorText => errorText != null;

  bool get isPasswordField =>
      widget.keyboardType == TextInputType.visiblePassword;

  void _onSaved(String? value) {
    value = value!.trim();
    widget.controller.text = value;
    if (widget.onSaved != null) widget.onSaved!(value);
  }

  void _onFieldSubmitted(String value) {
    final error = widget.validator(value.trim());
    setState(() {
      errorText = error;
    });
  }

  String? _onValidate(String? value) {
    final error = widget.validator(value!.trim());
    setState(() {
      errorText = error;
    });
    return error;
  }

  OutlineInputBorder _focusedBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(9)),
      borderSide: BorderSide(
        color: Constants.primaryColor,
        width: 2,
      ),
    );
  }

  OutlineInputBorder _normalBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(9)),
      borderSide: BorderSide.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Floating text
        Text(
          widget.floatingText,
          style: widget.floatingStyle ?? context.bodyText1.copyWith(
            color: Constants.textGreyColor,
            fontSize: 17,
          ),
        ),

        const SizedBox(height: 2),

        //TextField
        SizedBox(
          height: 47,
          child: TextFormField(
            controller: widget.controller,
            autofocus: widget.autofocus,
            maxLength: widget.maxLength,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            textAlignVertical: TextAlignVertical.center,
            showCursor: true,
            obscureText: showPassword,
            cursorColor: Colors.white,
            autovalidateMode: AutovalidateMode.disabled,
            validator: _onValidate,
            onSaved: _onSaved,
            onFieldSubmitted: _onFieldSubmitted,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            style: widget.inputStyle,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(17, 10, 1, 10),
              isDense: true,
              counterText: "",
              hintText: widget.hintText,
              hintStyle: widget.hintStyle,
              errorStyle: widget.errorStyle,
              border: _normalBorder(),
              focusedBorder: _focusedBorder(),
              focusedErrorBorder: _focusedBorder(),
              fillColor: widget.fillColor,
              filled: true,
              prefixIcon: widget.prefix,
              suffixIcon: isPasswordField
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: const Icon(
                        Icons.remove_red_eye_sharp,
                        color: Constants.textGreyColor,
                        size: 22,
                      ),
                    )
                  : null,
            ),
          ),
        ),

        if (hasErrorText) ...[
          const SizedBox(height: 2),

          //Error text
          Align(
            alignment: widget.errorTextAlign,
            child: Text(
              errorText!,
              style: context.bodyText1.copyWith(
                fontSize: 16,
                color: Constants.primaryColor,
              ),
            ),
          ),
        ]
      ],
    );
  }
}
