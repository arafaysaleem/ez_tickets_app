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

//Placeholders
import '../../skeletons/movie_poster_placeholder.dart';

//Widgets
import '../common/custom_network_image.dart';
import '../common/custom_text_button.dart';
import 'movie_overview_column.dart';

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
      itemBuilder: (ctx, i, _) => _MovieContainer(
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
          duration: const Duration(milliseconds: 300),
        );
      },
    );
  }
}

class _MovieContainer extends HookWidget {
  const _MovieContainer({
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
      duration: const Duration(milliseconds: 300),
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
                    "VIEW DETAILS",
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
