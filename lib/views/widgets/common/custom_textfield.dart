import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  const CustomTextField({
    Key? key,
    this.onSaved,
    this.prefix,
    this.errorTextAlign = Alignment.centerRight,
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
    String? error = widget.validator(value.trim());
    setState(() {
      errorText = error;
    });
  }

  String? _onValidate(String? value) {
    String? error = widget.validator(value!.trim());
    setState(() {
      errorText = error;
    });
    return error;
  }

  OutlineInputBorder _focusedBorder() {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(9)),
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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Floating text
        Text(
          widget.floatingText,
          style: textTheme.bodyText1!.copyWith(
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
            style: TextStyle(
              fontSize: 17,
              color: Constants.textWhite80Color,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(17, 10, 1, 10),
              isDense: true,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontSize: 17,
                color: Constants.textWhite80Color,
              ),
              errorStyle: const TextStyle(height: 0, color: Colors.transparent),
              border: _normalBorder(),
              focusedBorder: _focusedBorder(),
              focusedErrorBorder: _focusedBorder(),
              fillColor: theme.scaffoldBackgroundColor,
              filled: true,
              prefixIcon: widget.prefix,
              suffixIcon: isPasswordField
                  ? InkWell(
                    onTap: (){
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    child: Icon(
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
              style: textTheme.bodyText1!.copyWith(
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
