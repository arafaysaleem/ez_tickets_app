import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Providers
import '../../../providers/all_providers.dart';

//Widgets
import '../common/genre_chips.dart';
import '../common/ratings.dart';

class MovieDetailsColumn extends HookWidget {
  const MovieDetailsColumn();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final movie = useProvider(selectedMovie).state;
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
          child: GenreChips(genres: movie.genreNames),
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