import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

//models
import '../../../models/movie_model.dart';

//placeholders
import '../../skeletons/movie_poster_placeholder.dart';

class MovieBackdropView extends HookWidget {
  const MovieBackdropView({
    Key? key,
    required this.backgroundImageController,
    required this.movies,
  }) : super(key: key);

  final PageController backgroundImageController;
  final List<MovieModel> movies;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      reverse: true,
      physics: const NeverScrollableScrollPhysics(),
      controller: backgroundImageController,
      itemCount: movies.length,
      itemBuilder: (ctx, i) => CachedNetworkImage(
        imageUrl: movies[i].posterUrl,
        fit: BoxFit.cover,
        placeholder: (_, __) => const MoviePosterPlaceholder(
          childXAlign: Alignment.topCenter,
          padding: EdgeInsets.only(top: 110),
          iconSize: 85,
          borderRadius: 0,
        ),
        errorWidget: (_, __, Object? ___) => const MoviePosterPlaceholder(
          childXAlign: Alignment.topCenter,
          borderRadius: 0,
          iconSize: 85,
          padding: EdgeInsets.only(top: 110),
        ),
      ),
    );
  }
}

