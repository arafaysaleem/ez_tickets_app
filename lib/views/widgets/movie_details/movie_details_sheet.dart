import 'package:flutter/material.dart';

//Helper
import '../../../helper/utils/constants.dart';

//Widgets
import 'movie_actors_list.dart';
import 'movie_details_column.dart';
import 'movie_summary_box.dart';

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

  @override
  Widget build(BuildContext context) {
    var initialExtent = 0.7;
    var maxExtent = 0.96;
    var offsetRatio = 1.0;
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        // goes from 1.0 -> 0.0
        // vanish the button at extent of 0.78
        // appear the button at extent of 0.74
        final range = 0.78 - 0.74;
        offsetRatio = ((0.78 - notification.extent) / range).clamp(0.0, 1.0);
        return true;
      },
      child: DraggableScrollableSheet(
        initialChildSize: initialExtent,
        maxChildSize: maxExtent,
        minChildSize: 0.7,
        builder: (ctx, controller) => DecoratedBox(
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
              if(offsetRatio >= 0.1) Positioned(
                top: -28.5,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    minimumSize: Size.fromRadius(offsetRatio * 28.5),
                    primary: Colors.white,
                    padding: const EdgeInsets.all(0),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                  ),
                  child: offsetRatio <= 0.7
                      ? const SizedBox.shrink()
                      : const Icon(
                          Icons.play_arrow_sharp,
                          size: 35,
                          color: Colors.black,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
