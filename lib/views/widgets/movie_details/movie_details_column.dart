import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/extensions/context_extensions.dart';

//Providers
import '../../../providers/movies_provider.dart';

//Widgets
import '../common/custom_chips_list.dart';
import '../common/ratings.dart';

class MovieDetailsColumn extends HookWidget {
  const MovieDetailsColumn();

  @override
  Widget build(BuildContext context) {
    final movie = useProvider(selectedMovieProvider).state;
    return Column(
      children: [
        const SizedBox(height: 5),

        //Title
        Text(
          movie.title,
          style: context.headline2.copyWith(
            color: Colors.black,
            fontSize: 26,
          ),
        ),

        const SizedBox(height: 15),

        //Genres
        SizedBox(
          width: 210,
          child: CustomChipsList(
            chipHeight: 26,
            chipGap: 9,
            chipContents: movie.genreNames.sublist(0, 3),
          ),
        ),

        const SizedBox(height: 15),

        //Ratings
        if (movie.rating != null) Ratings(rating: movie.rating!),

        const SizedBox(height: 15),

        //Year
        Text(
          "${movie.year}",
          style: context.headline4.copyWith(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
