import 'package:flutter/material.dart';

//Helpers
import '../../../helper/extensions/context_extensions.dart';

//Models
import '../../../models/movie_model.dart';

//Widgets
import '../common/custom_chips_list.dart';
import '../common/ratings.dart';

class MovieOverviewColumn extends StatelessWidget {
  const MovieOverviewColumn({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Title
        Text(
          movie.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.headline2.copyWith(
            color: Colors.black,
            fontSize: 21,
          ),
        ),

        const SizedBox(height: 13),

        //Genres
        CustomChipsList(
          chipHeight: 26,
          chipGap: 7,
          chipContents: movie.genreNames.sublist(0, 3),
        ),

        const SizedBox(height: 13),

        //Ratings
        Ratings(rating: movie.rating),

        //Elipses
        const Text(
          '...',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 22,
            height: 1,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}
