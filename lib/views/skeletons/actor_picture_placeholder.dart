import 'package:flutter/material.dart';

import '../../helper/utils/constants.dart';

class ActorPicturePlaceholder extends StatelessWidget {
  const ActorPicturePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        color: Constants.scaffoldColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: const Center(
        child: Icon(
          Icons.person_rounded,
          color: Constants.primaryColor,
          size: 45,
        ),
      ),
    );
  }
}
