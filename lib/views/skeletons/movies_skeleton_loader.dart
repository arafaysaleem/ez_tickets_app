import 'package:flutter/material.dart';

//Helpers
import '../../helper/utils/constants.dart';
import '../../helper/extensions/context_extensions.dart';

//Widgets
import '../widgets/common/shimmer_loader.dart';

class MoviesSkeletonLoader extends StatelessWidget {
  const MoviesSkeletonLoader();

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    return Container(
      color: Constants.scaffoldGreyColor,
      height: screenHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //Movie icon
          const Expanded(
            child: Icon(
              Icons.movie_creation_rounded,
              color: Constants.darkSkeletonColor,
              size: 65,
            ),
          ),

          //Movie Carousel Skeleton
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //Left container
              ShimmerLoader(
                child: Container(
                  height: 0.63 * screenHeight,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Constants.lightSkeletonColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(0, 20, 20, 260),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Constants.darkSkeletonColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              //Center container
              ShimmerLoader(
                child: Container(
                  height: 0.675 * screenHeight,
                  width: 240,
                  decoration: const BoxDecoration(
                    color: Constants.lightSkeletonColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(20,20,20,Constants.bottomInsetsLow),
                  child: Column(
                    children: const [
                      //Image Box
                      SizedBox(
                        width: double.infinity,
                        height: 265,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Constants.darkSkeletonColor,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ),

                      Spacer(),

                      //Title Box
                      SizedBox(
                        height: 40,
                        width: 160,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Constants.darkSkeletonColor,
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                        ),
                      ),

                      Spacer(),

                      //Chips Box
                      SizedBox(
                        height: 30,
                        width: double.infinity,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Constants.darkSkeletonColor,
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                        ),
                      ),

                      Spacer(),

                      //Ratings Box
                      SizedBox(
                        height: 20,
                        width: 140,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Constants.darkSkeletonColor,
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                        ),
                      ),

                      Spacer(),

                      //Button Box
                      SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Constants.darkSkeletonColor,
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              //Right Container
              ShimmerLoader(
                child: Container(
                  height: 0.63 * screenHeight,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Constants.lightSkeletonColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 260),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Constants.darkSkeletonColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
