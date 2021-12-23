import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Enums
import '../../../enums/show_status_enum.dart';
import '../../../enums/show_type_enum.dart';

//Helpers
import '../../../helper/utils/constants.dart';
import '../../../helper/extensions/context_extensions.dart';

//Providers
import '../../../providers/shows_provider.dart';

class ShowDetailsBox extends HookConsumerWidget {
  const ShowDetailsBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showTime = ref.watch(selectedShowTimeProvider);
    return Container(
      decoration: BoxDecoration(
        color: Constants.scaffoldGreyColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: Constants.primaryColor),
      ),
      height: 65,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 17,horizontal: 35),
      child: Row(
        children: [
          Text(
            showTime.showType.inString,
            style: context.headline3.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              height: 1.4,
              fontSize: 19,
            ),
          ),

          //Divider line
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: VerticalDivider(
              thickness: 1.1,
              width: 0,
              color: Colors.white,
            ),
          ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Status
                Text(
                  showTime.showStatus.inString,
                  style: context.headline3.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),

                //Seating level icon
                if (showTime.showStatus == ShowStatus.FULL)
                  const Icon(
                    Icons.warning_rounded,
                    size: 25,
                    color: Colors.red,
                  )
                else if (showTime.showStatus == ShowStatus.ALMOST_FULL)
                  const Icon(
                    Icons.error_rounded,
                    size: 25,
                    color: Colors.amber,
                  )
                else if (showTime.showStatus == ShowStatus.FREE)
                  const Icon(
                    Icons.check_circle_sharp,
                    size: 25,
                    color: Color(0xFF64DD17),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
