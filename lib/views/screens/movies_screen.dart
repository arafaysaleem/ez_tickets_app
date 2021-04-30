import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

//Enums
import 'package:ez_ticketz_app/enums/movie_type_enum.dart';

//Models
import 'package:ez_ticketz_app/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helper
import '../../helper/utils/constants.dart';

//Providers
import '../../providers/all_providers.dart';

//Routes
import '../../routes/app_router.gr.dart';

//Placeholders
import '../skeletons/movie_poster_placeholder.dart';

//Widgets
import '../widgets/common/custom_network_image.dart';
import '../widgets/common/custom_text_button.dart';
import '../widgets/common/genre_chips.dart';
import '../widgets/common/ratings.dart';

final moviesFuture =
    FutureProvider.family<List<MovieModel>, MovieType?>((ref, movieType) async {
  return await ref.watch(moviesProvider).getAllMovies(movieType: movieType);
});

class MoviesScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final movies = useProvider(moviesFuture(null));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: movies.when(
        data: (movies) {
          final backgroundImageController = usePageController(
            initialPage: movies.length ~/ 2,
          );
          return SizedBox.expand(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                //page controller bg
                Positioned.fill(
                  child: _MovieBackdropView(
                    backgroundImageController: backgroundImageController,
                    movies: movies,
                  ),
                ),

                //Top black overlay
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 110,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: Constants.blackOverlayGradient,
                    ),
                  ),
                ),

                //White gradient
                Positioned.fill(
                  top: screenHeight * 0.40,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: Constants.movieCarouselGradient,
                    ),
                  ),
                ),

                //Movies Carousel
                Positioned(
                  bottom: -50,
                  top: screenHeight * 0.27,
                  child: _MoviesCarousel(
                    backgroundImageController: backgroundImageController,
                    movies: movies,
                  ),
                ),

                //Icons row
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: const _IconsRow(),
                )
              ],
            ),
          );
        },
        //TODO: Add skeleton loader
        loading: () => Center(child: CircularProgressIndicator()),
        //TODO: Add custom error
        error: (error, st) {
          context.read(authProvider.notifier).logout();
          context.router.popUntilRoot();
          print(error);
          print(st);
        },
      ),
    );
  }
}

class _MovieBackdropView extends HookWidget {
  const _MovieBackdropView({
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
        errorWidget: (_, __, ___) => const MoviePosterPlaceholder(
          childXAlign: Alignment.topCenter,
          borderRadius: 0,
          iconSize: 85,
          padding: EdgeInsets.only(top: 110),
        ),
      ),
    );
  }
}

class _MoviesCarousel extends StatefulHookWidget {
  final backgroundImageController;
  final List<MovieModel> movies;

  const _MoviesCarousel({
    required this.backgroundImageController,
    required this.movies,
  });

  @override
  __MoviesCarouselState createState() => __MoviesCarouselState();
}

class __MoviesCarouselState extends State<_MoviesCarousel> {
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
  }) : super(key: key);

  final MovieModel movie;
  final bool isCurrent;

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
      padding: EdgeInsets.fromLTRB(20, 20, 20, Constants.bottomInsetsLow),
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
              _MovieOverviewColumn(movie: movie),

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
                onPressed: () {
                  context.router.push(const MovieDetailsScreenRoute());
                },
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class _MovieOverviewColumn extends StatelessWidget {
  const _MovieOverviewColumn({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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

        const SizedBox(height: 10),

        //Genres
        //TODO: Implement movie genres
        GenreChips(genres: ["Action", "Horror", "Comedy"]),

        const SizedBox(height: 12),

        //Ratings
        if (movie.rating != null) Ratings(rating: movie.rating!),

        //Elipses
        const Text(
          "...",
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

class _IconsRow extends HookWidget {
  const _IconsRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Logout
          RotatedBox(
            quarterTurns: 2,
            child: IconButton(
              icon: const Icon(Icons.logout),
              padding: const EdgeInsets.all(0),
              onPressed: () {
                context.read(authProvider.notifier).logout();
                context.router.popUntilRoot();
              },
            ),
          ),

          //Filter
          IconButton(
            icon: const Icon(Icons.filter_list_rounded, size: 25),
            padding: const EdgeInsets.all(0),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
