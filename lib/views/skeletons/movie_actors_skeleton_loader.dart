import 'package:flutter/material.dart';

//Helpers
import '../../helper/utils/constants.dart';

//Widgets
import '../widgets/common/shimmer_loader.dart';

class MovieActorsSkeletonLoader extends StatelessWidget {
  const MovieActorsSkeletonLoader();

  @override
  Widget build(BuildContext context) {
    return ShimmerLoader(
      child: SizedBox(
        height: 140,
        child: Row(
          children: [
            const SizedBox(width: 5),

            for(var i = 0;i<3;i++)
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                children: const [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Constants.lightSkeletonColor,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),

                  SizedBox(height: 5),

                  SizedBox(
                    height: 15,
                    width: 80,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Constants.lightSkeletonColor,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),

                  SizedBox(height: 3),

                  SizedBox(
                    height: 10,
                    width: 60,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Constants.lightSkeletonColor,
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                      ),
                    ),
                  ),
                ],

            ),
              ),
          ],
        ),
      ),
    );
  }
}
