import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helper
import '../../../helper/utils/constants.dart';

//Widgets
import 'movie_actors_list.dart';
import 'movie_details_column.dart';
import 'movie_summary_box.dart';

final mainPosterScaleRatioProvider = StateProvider.autoDispose((_) => 1.0);
final _btnScaleRatioProvider = StateProvider.autoDispose((_) => 1.0);

class MovieDetailsSheet extends StatelessWidget {
  const MovieDetailsSheet({
    Key? key,
  }) : super(key: key);

  Shader getShader(Rect bounds) {
    return const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.9, 1],
      colors: [Colors.transparent, Colors.red],
    ).createShader(bounds);
  }

  double getPlayButtonScaleRatio(double dragExtent) {
    // vanish the button at extent of 0.78
    // appear the button at extent of 0.70
    final range = 0.78 - 0.7;
    // goes from 1.0 -> 0.0
    return ((0.78 - dragExtent) / range).clamp(0.0, 1.0);
  }

  double getMainPosterScaleRatio(
    double dragExtent,
    double startScaleExtent,
    double endScaleExtent,
  ) {
    if (dragExtent > startScaleExtent) return 1; //if sheet above start point
    // change poster size between these two extents
    final extentRange = startScaleExtent - endScaleExtent;
    // scaleRatio goes from 1.0 -> 1.2
    final scaleRange = 1 - 1.2;
    final extentRatio = (dragExtent - endScaleExtent) / extentRange;
    return extentRatio * scaleRange + 1.2;
  }

  @override
  Widget build(BuildContext context) {
    var initialExtent = 0.7;
    var maxExtent = 0.96;
    var minExtent = 0.65;
    var child;
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowGlow();
        return true;
      },
      child: NotificationListener<DraggableScrollableNotification>(
        onNotification: (drag) {
          final posterScaleRatio = getMainPosterScaleRatio(
            drag.extent,
            initialExtent,
            minExtent,
          );
          context.read(mainPosterScaleRatioProvider).state = posterScaleRatio;

          final btnScaleRatio = getPlayButtonScaleRatio(drag.extent);
          context.read(_btnScaleRatioProvider).state = btnScaleRatio;
          return true;
        },
        child: DraggableScrollableSheet(
          initialChildSize: initialExtent,
          maxChildSize: maxExtent,
          minChildSize: minExtent,
          builder: (ctx, controller) {
            if (child == null) {
              child = DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    //Movie details
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: Constants.bottomInsetsLow + 54,
                      ),
                      // ignore: lines_longer_than_80_chars
                      child: ShaderMask(
                        shaderCallback: getShader,
                        blendMode: BlendMode.dstOut,
                        child: ListView(
                          controller: controller,
                          children: const [
                            SizedBox(height: 5),

                            //Movie details
                            MovieDetailsColumn(),

                            SizedBox(height: 20),

                            //Actors
                            MovieActorsList(),

                            SizedBox(height: 25),

                            //Summary
                            MovieSummaryBox(),
                          ],
                        ),
                      ),
                    ),

                    //play button
                    const Positioned(
                      top: -28.5,
                      child: _PlayButtonWidget(),
                    ),
                  ],
                ),
              );
            }
            return child;
          },
        ),
      ),
    );
  }
}

class _PlayButtonWidget extends HookWidget {
  const _PlayButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final btnScaleRatio = useProvider(_btnScaleRatioProvider).state;
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        elevation: 5,
        minimumSize: Size.fromRadius(btnScaleRatio * 28.5),
        primary: Colors.white,
        padding: const EdgeInsets.all(0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
      ),
      child: Icon(
        Icons.play_arrow_sharp,
        size: btnScaleRatio * 35,
        color: Colors.black,
      ),
    );
  }
}
