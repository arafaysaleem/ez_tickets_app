import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Providers
import '../../../providers/movies_provider.dart';

//Widgets
import '../common/custom_chips_list.dart';
import '../common/ratings.dart';

class MovieDetailsColumn extends HookWidget {
  const MovieDetailsColumn();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final movie = useProvider(selectedMovieProvider).state;
    return Column(
      children: [
        //Title
        Text(
          movie.title,
          style: textTheme.headline2!.copyWith(
            color: Colors.black,
            fontSize: 26,
          ),
        ),

        const SizedBox(height: 15),

        //Genres
        SizedBox(
          width: 200,
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
          style: textTheme.headline4!.copyWith(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
