import 'package:flutter/material.dart';

//Helpers
import '../../helper/utils/constants.dart';

//Widgets
import '../widgets/common/shimmer_loader.dart';

class UserBookingsSkeletonLoader extends StatelessWidget {
  const UserBookingsSkeletonLoader();

  @override
  Widget build(BuildContext context) {
    return ShimmerLoader(
      child: ListView.separated(
        itemCount: 4,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (ctx,i) => const SizedBox(height: 20),
        itemBuilder: (ctx,i) => const _UserBookingSkeleton(),
      ),
    );
  }
}

class _UserBookingSkeleton extends StatelessWidget {
  const _UserBookingSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          //Booking overview
          SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                //Booking details
                _BookingDetailsSkeleton(),

                //No of seats
                SizedBox(
                  height: double.infinity,
                  width: 45,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Constants.darkSkeletonColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          //Movie Image
          const Positioned(
            bottom: 13,
            left: 13,
            child: SizedBox(
              height: 125,
              width: 100,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Constants.darkSkeletonColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Icon(
                    Icons.movie_creation_rounded,
                    color: Constants.lightSkeletonColor,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingDetailsSkeleton extends StatelessWidget {
  const _BookingDetailsSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Constants.lightSkeletonColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(125, 10, 10, 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            //Movie data
            SizedBox(
              height: 25,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Constants.darkSkeletonColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            //Show details
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Constants.darkSkeletonColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
