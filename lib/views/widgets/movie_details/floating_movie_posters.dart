import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Providers
import '../../../providers/movies_provider.dart';
import 'movie_details_sheet.dart' show mainPosterScaleRatioProvider;

//Skeletons
import '../../skeletons/movie_poster_placeholder.dart';

//Widgets
import '../common/custom_network_image.dart';

class FloatingMoviePosters extends StatefulWidget {
  const FloatingMoviePosters();

  @override
  _FloatingMoviePostersState createState() => _FloatingMoviePostersState();
}

class _FloatingMoviePostersState extends State<FloatingMoviePosters> {
  double topGap = 300.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        topGap = 120.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        //left movie poster
        AnimatedPositioned(
          top: topGap,
          left: 0,
          height: 250,
          width: 150,
          duration: const Duration(milliseconds: 850),
          curve: Curves.easeInOutBack,
          child: const _LeftMoviePoster(),
        ),

        //right movie poster
        AnimatedPositioned(
          top: topGap,
          right: 0,
          height: 250,
          width: 150,
          duration: const Duration(milliseconds: 850),
          curve: Curves.easeInOutBack,
          child: const _RightMoviePoster(),
        ),

        //Top black overlay
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 300,
          child: ColoredBox(
            color: Colors.black45,
          ),
        ),

        //main movie poster
        AnimatedPositioned(
          top: topGap - 65,
          height: 250,
          width: 190,
          duration: const Duration(milliseconds: 650),
          curve: Curves.easeInOutBack,
          child: const _MainMoviePoster(),
        ),
      ],
    );
  }
}

class _LeftMoviePoster extends HookConsumerWidget {
  const _LeftMoviePoster({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leftMoviePosterUrl = ref.watch(leftMovieProvider.select((value) => value.posterUrl));
    return CustomNetworkImage(
      imageUrl: leftMoviePosterUrl,
      fit: BoxFit.fill,
      placeholder: const MoviePosterPlaceholder(),
      errorWidget: const MoviePosterPlaceholder(),
    );
  }
}

class _RightMoviePoster extends HookConsumerWidget {
  const _RightMoviePoster({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rightMoviePosterUrl = ref.watch(rightMovieProvider.select((value) => value.posterUrl));
    return CustomNetworkImage(
      imageUrl: rightMoviePosterUrl,
      fit: BoxFit.fill,
      placeholder: const MoviePosterPlaceholder(),
      errorWidget: const MoviePosterPlaceholder(),
    );
  }
}

class _MainMoviePoster extends HookConsumerWidget {
  const _MainMoviePoster({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posterUrl = ref.watch(selectedMovieProvider.select((value) {
      return value.posterUrl;
    }));
    return Consumer(
      builder: (ctx, ref, child) {
        final scaleRatio = ref.watch(mainPosterScaleRatioProvider);
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
