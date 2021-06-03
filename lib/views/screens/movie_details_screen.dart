import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helper
import '../../helper/utils/constants.dart';
import '../../helper/extensions/context_extensions.dart';

//Providers
import '../../providers/movies_provider.dart';

//Routes
import '../../routes/app_router.gr.dart';

//Placeholders
import '../skeletons/movie_poster_placeholder.dart';

//Widgets
import '../widgets/common/custom_network_image.dart';
import '../widgets/common/custom_text_button.dart';
import '../widgets/movie_details/movie_details_sheet.dart';

class MovieDetailsScreen extends HookWidget {
  const MovieDetailsScreen();

  @override
  Widget build(BuildContext context) {
    const topGap = 120.0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          //left movie poster
          const Positioned(
            top: topGap,
            left: 0,
            height: 250,
            width: 150,
            child: _LeftMoviePoster(),
          ),

          //right movie poster
          const Positioned(
            top: topGap,
            right: 0,
            height: 250,
            width: 150,
            child: _RightMoviePoster(),
          ),

          //Top black overlay
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 300,
            child: ColoredBox(
              color: Colors.black54,
            ),
          ),

          //main movie poster
          const Positioned(
            top: 55,
            height: 250,
            width: 190,
            child: _MainMoviePoster(),
          ),

          //White details sheet
          const MovieDetailsSheet(),

          //View shows button
          Positioned(
            bottom: Constants.bottomInsetsLow,
            left: 20,
            right: 20,
            child: CustomTextButton(
              color: Constants.scaffoldColor,
              child: Center(
                child: Text(
                  "VIEW SHOWS",
                  style: context.headline1.copyWith(
                        color: Colors.white,
                        fontSize: 15,
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              onPressed: () {
                context.router.push(const ShowsScreenRoute());
              },
            ),
          ),

          //Icons row
          Positioned(
            top: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 4),
              child: IconButton(
                splashRadius: 25,
                icon: const Icon(Icons.close_rounded, size: 25),
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  context.router.pop();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _LeftMoviePoster extends HookWidget {
  const _LeftMoviePoster({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leftMovie = useProvider(leftMovieProvider).state;
    return CustomNetworkImage(
      imageUrl: leftMovie.posterUrl,
      fit: BoxFit.fill,
      placeholder: const MoviePosterPlaceholder(),
      errorWidget: const MoviePosterPlaceholder(),
    );
  }
}

class _RightMoviePoster extends HookWidget {
  const _RightMoviePoster({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rightMovie = useProvider(rightMovieProvider).state;
    return CustomNetworkImage(
      imageUrl: rightMovie.posterUrl,
      fit: BoxFit.fill,
      placeholder: const MoviePosterPlaceholder(),
      errorWidget: const MoviePosterPlaceholder(),
    );
  }
}

class _MainMoviePoster extends HookWidget {
  const _MainMoviePoster({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final posterUrl = useProvider(selectedMovieProvider.select((value) {
      return value.state.posterUrl;
    }));
    return Consumer(
      builder: (ctx, watch, child) {
        final scaleRatio = watch(mainPosterScaleRatioProvider).state;
        if (scaleRatio == 1.0) return child!;
        return Transform.scale(
          scale: scaleRatio,
          child: child,
        );
      },
      child: CustomNetworkImage(
        imageUrl: posterUrl,
        radius: 10,
        placeholder: const MoviePosterPlaceholder(),
        errorWidget: const MoviePosterPlaceholder(),
        fit: BoxFit.fill,
        margin: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}
