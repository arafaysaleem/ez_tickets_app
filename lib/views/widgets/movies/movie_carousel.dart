import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helper
import '../../../helper/utils/constants.dart';

//Models
import '../../../models/movie_model.dart';

//Providers
import '../../../providers/movies_provider.dart';

//Router
import '../../../routes/app_router.gr.dart';

//Widgets
import 'white_movie_container.dart';

class MoviesCarousel extends StatefulHookWidget {
  final PageController backgroundImageController;
  final List<MovieModel> movies;

  const MoviesCarousel({
    required this.backgroundImageController,
    required this.movies,
  });

  @override
  __MoviesCarouselState createState() => __MoviesCarouselState();
}

class __MoviesCarouselState extends State<MoviesCarousel> {
  late int _currentIndex;

  List<MovieModel> get movies => widget.movies;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      _currentIndex = movies.length ~/ 2;
    }, const []);
    return CarouselSlider.builder(
      carouselController: CarouselController(),
      options: getCarouselOptions(),
      itemCount: movies.length,
      itemBuilder: (ctx, i, _) => WhiteMovieContainer(
        isCurrent: _currentIndex == i,
        movie: movies[i],
        onViewDetails: () {
          final leftIndex = (i-1) % movies.length;
          final rightIndex = (i+1) % movies.length;
          context.read(selectedMovieProvider).state = movies[i];
          context.read(leftMovieProvider).state = movies[leftIndex];
          context.read(rightMovieProvider).state = movies[rightIndex];
          context.router.push(const MovieDetailsScreenRoute());
        },
      ),
    );
  }

  CarouselOptions getCarouselOptions() {
    return CarouselOptions(
      scrollPhysics: const BouncingScrollPhysics(),
      enableInfiniteScroll: false,
      viewportFraction: 0.62,
      aspectRatio: 0.68,
      enlargeCenterPage: true,
      enlargeStrategy: CenterPageEnlargeStrategy.height,
      initialPage: _currentIndex,
      onScrolled: (offset) {},
      onPageChanged: (i, reason) {
        setState(() {
          _currentIndex = i;
        });
        widget.backgroundImageController.animateToPage(
          i,
          curve: Curves.easeOutCubic,
          duration: Constants.defaultAnimationDuration,
        );
      },
    );
  }
}
