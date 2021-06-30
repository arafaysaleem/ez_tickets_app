import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

//Helpers
import '../../../helper/extensions/context_extensions.dart';
import '../../../helper/utils/constants.dart';

class CustomTextField extends StatefulWidget {
  final String? floatingText, hintText;
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
    this.floatingText,
    this.hintText,
    required this.controller,
    required this.keyboardType,
    required this.textInputAction,
    required this.validator,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? errorText;
  bool hidePassword = true;

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
        if (widget.floatingText != null)
          Text(
            widget.floatingText!,
            style: widget.floatingStyle ??
                context.bodyText1.copyWith(
                  color: Constants.textGreyColor,
                  fontSize: 17,
                ),
          ),

        if (widget.floatingText != null) const SizedBox(height: 2),

        //TextField
        SizedBox(
          height: 47,
          child: TextFormField(
            controller: widget.controller,
            autofocus: widget.autofocus,
            maxLength: widget.maxLength,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            style: widget.inputStyle,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            textAlignVertical: TextAlignVertical.center,
            autovalidateMode: AutovalidateMode.disabled,
            cursorColor: Colors.white,
            obscureText: isPasswordField && hidePassword,
            showCursor: true,
            validator: _onValidate,
            onSaved: _onSaved,
            onFieldSubmitted: _onFieldSubmitted,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: widget.hintStyle,
              errorStyle: widget.errorStyle,
              fillColor: widget.fillColor,
              prefixIcon: widget.prefix,
              contentPadding: const EdgeInsets.fromLTRB(17, 10, 1, 10),
              isDense: true,
              filled: true,
              counterText: "",
              border: _normalBorder(),
              focusedBorder: _focusedBorder(),
              focusedErrorBorder: _focusedBorder(),
              suffixIcon: isPasswordField
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          hidePassword = !hidePassword;
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
