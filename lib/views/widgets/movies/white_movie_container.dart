import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

//Helper
import '../../../helper/utils/constants.dart';

//Models
import '../../../models/movie_model.dart';

//Placeholders
import '../../skeletons/movie_poster_placeholder.dart';

//Widgets
import '../common/custom_network_image.dart';
import '../common/custom_text_button.dart';
import 'movie_overview_column.dart';

class WhiteMovieContainer extends HookWidget {
  const WhiteMovieContainer({
    Key? key,
    required this.isCurrent,
    required this.movie,
    required this.onViewDetails,
  }) : super(key: key);

  final MovieModel movie;
  final bool isCurrent;
  final VoidCallback onViewDetails;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Constants.defaultAnimationDuration,
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
        color: isCurrent ? Colors.white : Colors.white54,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, Constants.bottomInsetsLow),
      child: LayoutBuilder(
        builder: (ctx, constraints) => Column(
          children: [
            //Poster image
            CustomNetworkImage(
              imageUrl: movie.posterUrl,
              height: constraints.minHeight * 0.58,
              fit: BoxFit.fill,
              onTap: onViewDetails,
              placeholder: MoviePosterPlaceholder(
                height: constraints.minHeight * 0.58,
              ),
              errorWidget: MoviePosterPlaceholder(
                height: constraints.minHeight * 0.58,
              ),
            ),

            const SizedBox(height: 10),

            //Movie details and button
            if (isCurrent) ...[
              MovieOverviewColumn(movie: movie),

              const Spacer(),

              //View Details Button
              CustomTextButton(
                color: Constants.scaffoldColor,
                child: const Center(
                  child: Text(
                    'VIEW DETAILS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      letterSpacing: 0.7,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                onPressed: onViewDetails,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
