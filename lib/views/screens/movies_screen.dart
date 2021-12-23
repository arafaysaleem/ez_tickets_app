import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helper
import '../../helper/extensions/context_extensions.dart';
import '../../helper/utils/constants.dart';

//Providers
import '../../providers/all_providers.dart';
import '../../providers/movies_provider.dart';

//Routing
import '../../routes/app_router.dart';

//Skeletons
import '../skeletons/movies_skeleton_loader.dart';

//Widgets
import '../widgets/movies/movie_backdrop_view.dart';
import '../widgets/movies/movie_carousel.dart';
import '../widgets/movies/movie_icons_row.dart';
import '../widgets/common/error_response_handler.dart';

class MoviesScreen extends HookConsumerWidget {
  const MoviesScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = context.screenHeight;
    final movies = ref.watch(moviesFuture);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 550),
        switchOutCurve: Curves.easeInBack,
        child: movies.when(
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
                      decoration: const BoxDecoration(
                        gradient: Constants.blackOverlayGradient,
                      ),
                    ),
                  ),

                  //White gradient
                  Positioned.fill(
                    top: screenHeight * 0.40,
                    child: Container(
                      decoration: const BoxDecoration(
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
                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: MoviesIconsRow(),
                  )
                ],
              ),
            );
          },
          loading: () => const MoviesSkeletonLoader(),
          error: (error, st) => ErrorResponseHandler(
            error: error,
            stackTrace: st,
            retryCallback: () => ref.refresh(moviesFuture),
            onError: () {
              ref.read(authProvider.notifier).logout();
              AppRouter.popUntilRoot();
            },
          ),
        ),
      ),
    );
  }
}
