import 'package:flutter/material.dart';

import '../../../helper/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  final String floatingText, hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  const CustomTextField({
    Key? key,
    required this.floatingText,
    required this.hintText,
    required this.keyboardType,
    required this.textInputAction,
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
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            keyboardType: keyboardType,
            cursorColor: Colors.white,
            maxLines: 1,
            textInputAction: textInputAction,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 17),
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 18,
                color: Constants.textWhite80Color,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
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
