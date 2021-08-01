import 'package:flutter/material.dart';

//Helpers
import '../../helper/utils/constants.dart';
import '../../helper/extensions/context_extensions.dart';

//Widgets
import '../widgets/common/shimmer_loader.dart';

class ShowsSkeletonLoader extends StatelessWidget {
  const ShowsSkeletonLoader();

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //Date Title
        Text(
          'Select a date',
          style: textTheme.headline5!.copyWith(
            height: 1,
            color: Constants.textGreyColor,
            fontSize: 20,
          ),
        ),

        const SizedBox(height: 15),

        //Dates list
        ShimmerLoader(
          child: Container(
            height: 130,
            decoration: const BoxDecoration(
              color: Constants.lightSkeletonColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            margin: const EdgeInsets.only(left: 20),
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for(var i=0;i<4;i++)
                  const SizedBox(
                    width: 60,
                    height: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Constants.darkSkeletonColor,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),

                const SizedBox(
                  width: 30,
                  height: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Constants.darkSkeletonColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const Spacer(),

        //Time Title
        Text(
          'Select a time',
          style: textTheme.headline5!.copyWith(
            height: 1,
            color: Constants.textGreyColor,
            fontSize: 20,
          ),
        ),

        const SizedBox(height: 15),

        //Show times list
        ShimmerLoader(
          child: Container(
            decoration: const BoxDecoration(
              color: Constants.lightSkeletonColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            height: 85,
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 55,
                  height: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Constants.darkSkeletonColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                  ),
                ),

                for(var i=0;i<2;i++)
                  const SizedBox(
                    width: 110,
                    height: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Constants.darkSkeletonColor,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),

        const Spacer(),

        //Seats details title
        Text(
          'Show details',
          style: textTheme.headline5!.copyWith(
            height: 1,
            color: Constants.textGreyColor,
            fontSize: 20,
          ),
        ),

        const SizedBox(height: 15),

        //Show details box
        ShimmerLoader(
          child: Container(
            decoration: const BoxDecoration(
              color: Constants.lightSkeletonColor,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            height: 65,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 17,horizontal: 20),
            child: const DecoratedBox(
              decoration: BoxDecoration(
                color: Constants.darkSkeletonColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ),

        const Spacer(),

        //Continue button
        const ShimmerLoader(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 55,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Constants.lightSkeletonColor,
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Constants.darkSkeletonColor,
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 5),
      ],
    );
  }
}
