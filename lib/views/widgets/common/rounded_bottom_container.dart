import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import '../../../helper/utils/constants.dart';

class RoundedBottomContainer extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback? onTap;

  const RoundedBottomContainer({Key? key, required this.children, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = 25.0;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Constants.scaffoldGreyColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //back arrow
          InkWell(
              child: Padding(
                padding: EdgeInsets.only(left: padding-5,top: 40),
                child: Icon(
                  Icons.arrow_back_sharp,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              onTap: onTap ?? () => context.router.pop(),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(padding, 28, padding, 27),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
