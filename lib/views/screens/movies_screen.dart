import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:auto_route/auto_route.dart';

//Services
import '../../services/networking/network_exception.dart';

//Enums
import '../../enums/movie_type_enum.dart';

//Models
import '../../models/movie_model.dart';

//Helper
import '../../helper/utils/constants.dart';

//Providers
import '../../providers/all_providers.dart';

//Widgets
import '../widgets/common/custom_error_widget.dart';
import '../widgets/movies/movie_carousel.dart';
import '../widgets/movies/movie_backdrop_view.dart';
import '../widgets/movies/movie_icons_row.dart';

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
                  child: MovieBackdropView(
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
                  child: MoviesCarousel(
                    backgroundImageController: backgroundImageController,
                    movies: movies,
                  ),
                ),

                //Icons row
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: const MoviesIconsRow(),
                )
              ],
            ),
          );
        },
        //TODO: Add skeleton loader
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, st) {
          if (error is NetworkException) return CustomErrorWidget.dark(error);
          context.read(authProvider.notifier).logout();
          context.router.popUntilRoot();
          print(error);
          print(st);
        },
      ),
    );
  }
}