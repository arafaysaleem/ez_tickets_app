import 'package:flutter/material.dart';

//Helper
import '../../../helper/utils/constants.dart';

//Widgets
import '../common/scrollable_column.dart';
import 'movie_actors_list.dart';
import 'movie_details_column.dart';
import 'movie_summary_box.dart';

class MovieDetailsSheet extends StatelessWidget {
  const MovieDetailsSheet({
    Key? key,
  }) : super(key: key);

  Shader getShader(bounds) {
    return const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [
        0.9,
        1,
      ],
      colors: [Colors.transparent, Colors.red],
    ).createShader(bounds);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.only(top: 35),
      child: Column(
        children: [
          //Movie details
          const MovieDetailsColumn(),

          const SizedBox(height: 20),

          Flexible(
            child: ShaderMask(
              shaderCallback: getShader,
              blendMode: BlendMode.dstOut,
              child: const ScrollableColumn(
                physics: BouncingScrollPhysics(),
                children: [
                  //Actors
                  MovieActorsList(),

                  SizedBox(height: 25),

                  //Summary
                  MovieSummaryBox()
                ],
              ),
            ),
          ),

          SizedBox(height: Constants.bottomInsetsLow + 54),
        ],
      ),
    );
  }
}
