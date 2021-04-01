import 'package:flutter/material.dart';

import '../../../helper/utils/constants.dart';

class GenreChips extends StatelessWidget {
  final List<String> genres;

  const GenreChips({
    Key? key,
    required this.genres,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (int i = 0; i < 3; i++)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Constants.textGreyColor,
                width: 1,
              ),
            ),
            child: Text(
              genres[i],
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: Constants.textGreyColor,
                fontSize: 12
              ),
            ),
          )
      ],
    );
  }
}
