import 'package:flutter/material.dart';

//Routing
import '../../../routes/app_router.dart';

//Helpers
import '../../../helper/utils/constants.dart';

class RoundedBottomContainer extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback? onBackTap;
  final EdgeInsets? padding;

  const RoundedBottomContainer({
    Key? key,
    required this.children,
    this.onBackTap,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
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
            child: const Padding(
              padding: EdgeInsets.only(left: 25.0 - 5, top: 40),
              child: Icon(
                Icons.arrow_back_sharp,
                size: 32,
                color: Colors.white,
              ),
            ),
            onTap: onBackTap ?? () => AppRouter.pop(),
          ),

          Padding(
            padding: padding ?? const EdgeInsets.fromLTRB(25.0, 28, 25.0, 27),
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
