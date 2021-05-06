import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helper
import '../../helper/utils/constants.dart';

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

final leftMoviePoster =
    "https://m.media-amazon.com/images/M/MV5BMTc1NjIzODAxMF5BMl5BanBnXkFtZTgwMTgzNzk1NzM@._V1_.jpg";
final rightMoviePoster =
    "https://talenthouse-res.cloudinary.com/image/upload/c_limit,f_auto,fl_progressive,h_1280,w_1280/v1568795702/user-1024773/profile/jox3adylqftz1rzurgzz.jpg";

class MovieDetailsScreen extends HookWidget {
  const MovieDetailsScreen();

  @override
  Widget build(BuildContext context) {
    final topGap = 230.0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          //left movie poster
          const _LeftMoviePoster(),

          //right movie poster
          const _RightMoviePoster(),

          //Top black overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: topGap + 30,
            child: Container(
              color: Colors.black54,
            ),
          ),

          //main movie poster
          const _MainMoviePoster(),

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
                  style: Theme.of(context).textTheme.headline1!.copyWith(
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
    //TODO: Get through provider
    // final leftMoviePic = useProvider(selectedMovieProvider).state;
    return Positioned(
      top: 130,
      left: 0,
      height: 250,
      width: 150,
      child: CustomNetworkImage(
        imageUrl: leftMoviePoster,
        fit: BoxFit.fill,
        placeholder: const MoviePosterPlaceholder(),
        errorWidget: const MoviePosterPlaceholder(),
      ),
    );
  }
}

class _RightMoviePoster extends HookWidget {
  const _RightMoviePoster({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: Get through provider
    // final rightMoviePic = useProvider(selectedMovieProvider).state;
    return Positioned(
      top: 130,
      right: 0,
      height: 250,
      width: 150,
      child: CustomNetworkImage(
        imageUrl: rightMoviePoster,
        fit: BoxFit.fill,
        placeholder: const MoviePosterPlaceholder(),
        errorWidget: const MoviePosterPlaceholder(),
      ),
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
    return Positioned(
      top: 80,
      height: 250,
      width: 190,
      child: CustomNetworkImage(
        imageUrl: posterUrl,
        borderRadius: 10,
        placeholder: const MoviePosterPlaceholder(),
        errorWidget: const MoviePosterPlaceholder(),
        fit: BoxFit.fill,
        margin: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}
