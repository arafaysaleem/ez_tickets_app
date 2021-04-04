import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../helper/utils/constants.dart';
import '../../routes/app_router.gr.dart';
import '../widgets/common/custom_text_button.dart';
import '../widgets/common/genre_chips.dart';
import '../widgets/common/ratings.dart';
import '../widgets/common/custom_network_image.dart';

final List<Map<String, dynamic>> nowShowing = const [
  {
    "title": "Joker",
    "genres": ["Action", "Drama", "History"],
    "rating": 9.0,
    "poster_url":
        "https://talenthouse-res.cloudinary.com/image/upload/c_limit,f_auto,fl_progressive,h_1280,w_1280/v1568795702/user-1024773/profile/jox3adylqftz1rzurgzz.jpg"
  },
  {
    "title": "Good Boys",
    "genres": ["Action", "Drama", "Comedy"],
    "rating": 6.7,
    "poster_url":
        "https://m.media-amazon.com/images/M/MV5BMTc1NjIzODAxMF5BMl5BanBnXkFtZTgwMTgzNzk1NzM@._V1_.jpg"
  },
  {
    "title": "The Hustle",
    "genres": ["Action", "Drama", "Comedy"],
    "rating": 5.4,
    "poster_url":
        "https://m.media-amazon.com/images/M/MV5BMTc3MDcyNzE5N15BMl5BanBnXkFtZTgwNzE2MDE0NzM@._V1_.jpg"
  },
];

class MoviesScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final backgroundImageController = usePageController(
      initialPage: nowShowing.length ~/ 2,
    );
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox.expand(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            //page controller bg
            Positioned.fill(
              child: _MovieBackdropView(
                backgroundImageController: backgroundImageController,
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
              child: _MoviesCarousel(backgroundImageController),
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
      ),
    );
  }
}

class _MovieBackdropView extends HookWidget {
  const _MovieBackdropView({
    Key? key,
    required this.backgroundImageController,
  }) : super(key: key);

  final PageController backgroundImageController;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      reverse: true,
      physics: const NeverScrollableScrollPhysics(),
      controller: backgroundImageController,
      itemCount: nowShowing.length,
      itemBuilder: (ctx, i) => CachedNetworkImage(
        imageUrl: nowShowing[i]["poster_url"],
        fit: BoxFit.cover,
      ),
    );
  }
}

class _MoviesCarousel extends StatefulHookWidget {
  final backgroundImageController;

  const _MoviesCarousel(this.backgroundImageController);

  @override
  __MoviesCarouselState createState() => __MoviesCarouselState();
}

class __MoviesCarouselState extends State<_MoviesCarousel> {
  late int _currentIndex;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      _currentIndex = nowShowing.length ~/ 2;
    }, const []);
    return CarouselSlider.builder(
      carouselController: CarouselController(),
      options: getCarouselOptions(),
      itemCount: nowShowing.length,
      itemBuilder: (ctx, i, _) => _MovieContainer(
        isCurrent: _currentIndex == i,
        title: nowShowing[i]["title"],
        genres: nowShowing[i]["genres"],
        rating: nowShowing[i]["rating"],
        posterUrl: nowShowing[i]["poster_url"],
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
    required this.posterUrl,
    required this.genres,
    required this.title,
    required this.rating,
  }) : super(key: key);

  final bool isCurrent;
  final String posterUrl;
  final String title;
  final List<String> genres;
  final double rating;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
        color: isCurrent ? Colors.white : Colors.white54,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30),
          topRight: const Radius.circular(30),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.fromLTRB(10, 20, 10, Constants.bottomInsetsLow),
      child: LayoutBuilder(
        builder: (ctx, constraints) => Column(
          children: [
            //Poster image
            CustomNetworkImage(
              imageUrl: posterUrl,
              height: constraints.minHeight * 0.58,
              fit: BoxFit.fill,
              margin: const EdgeInsets.symmetric(horizontal: 10),
            ),

            const SizedBox(height: 10),

            //Movie details and button
            if (isCurrent) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: buildMovieDetailsColumn(textTheme),
              ),

              const Spacer(),

              //View Details Button
              CustomTextButton(
                color: Constants.scaffoldColor,
                child: const Center(
                  child: const Text(
                    "VIEW DETAILS",
                    style: const TextStyle(
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
              )
            ]
          ],
        ),
      ),
    );
  }

  Column buildMovieDetailsColumn(TextTheme textTheme) {
    return Column(
      children: [
        //Title
        Text(
          title,
          style: textTheme.headline2!.copyWith(
            color: Colors.black,
            fontSize: 26,
          ),
        ),

        const SizedBox(height: 10),

        //Genres
        GenreChips(genres: genres),

        const SizedBox(height: 12),

        //Ratings
        Ratings(rating: rating),

        //Elipses
        const Text(
          "...",
          style: const TextStyle(
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
                context.router.pop();
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
