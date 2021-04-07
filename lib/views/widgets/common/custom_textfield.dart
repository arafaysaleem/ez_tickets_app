import 'package:flutter/material.dart';

import '../../../helper/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  final String floatingText, hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final String? Function(String? value) validator;
  final void Function(String? value)? onSaved;

  const CustomTextField({
    Key? key,
    this.onSaved,
    required this.floatingText,
    required this.hintText,
    required this.keyboardType,
    required this.textInputAction,
    required this.validator,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Floating text
        Text(
          floatingText,
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
            controller: controller,
            textAlignVertical: TextAlignVertical.center,
            showCursor: true,
            cursorColor: Colors.white,
            maxLines: 1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => validator(value!.trim()),
            onSaved: (value) {
              value = value!.trim();
              controller.text = value;
              if(onSaved != null) onSaved!(value);
            },
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 17),
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 18,
                color: Constants.textWhite80Color,
              ),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(9)),
                borderSide: BorderSide.none,
              ),
              fillColor: theme.scaffoldBackgroundColor,
              filled: true,
            ),
          ),
        ),
      ],
    );
  }
}
