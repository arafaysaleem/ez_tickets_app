import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
