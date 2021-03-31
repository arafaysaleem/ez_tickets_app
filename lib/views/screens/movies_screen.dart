import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../helper/utils/constants.dart';
import '../widgets/custom_text_button.dart';

class MoviesScreen extends StatefulHookWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final List<Map<String, dynamic>> nowShowing = const [
    {
      "title": "Joker",
      "genres": "Action, Drama, History",
      "rating": 9.0,
      "poster_url":
          "https://talenthouse-res.cloudinary.com/image/upload/c_limit,f_auto,fl_progressive,h_1280,w_1280/v1568795702/user-1024773/profile/jox3adylqftz1rzurgzz.jpg"
    },
    {
      "title": "Good Boys",
      "genres": "Action, Drama, Comedy",
      "rating": 6.7,
      "poster_url":
          "https://m.media-amazon.com/images/M/MV5BMTc1NjIzODAxMF5BMl5BanBnXkFtZTgwMTgzNzk1NzM@._V1_.jpg"
    },
    {
      "title": "The Hustle",
      "genres": "Action, Drama, Comedy",
      "rating": 5.4,
      "poster_url":
          "https://m.media-amazon.com/images/M/MV5BMTc3MDcyNzE5N15BMl5BanBnXkFtZTgwNzE2MDE0NzM@._V1_.jpg"
    },
  ];

  late int _currentIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    useEffect(() {
      _currentIndex = nowShowing.length ~/ 2;
    }, const []);
    final backgroundImageController = usePageController(
      initialPage: _currentIndex,
    );
    final duration = const Duration(milliseconds: 300);
    final moviesCarouselController = CarouselController();
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          //page controller bg
          Positioned.fill(
            child: PageView.builder(
              reverse: true,
              physics: const NeverScrollableScrollPhysics(),
              controller: backgroundImageController,
              itemCount: nowShowing.length,
              itemBuilder: (ctx, i) => Image.network(
                nowShowing[i]["poster_url"],
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned.fill(
            top: screenHeight * 0.40,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.3, 0.6, 1],
                  colors: [
                    Colors.white,
                    Colors.white70,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          //page controller movie
          Positioned(
            bottom: -50,
            top: screenHeight * 0.29,
            child: CarouselSlider.builder(
              carouselController: moviesCarouselController,
              options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  enableInfiniteScroll: false,
                  viewportFraction: 0.62,
                  aspectRatio: 0.7,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  initialPage: _currentIndex,
                  onScrolled: (offset) {},
                  onPageChanged: (i, reason) {
                    setState(() {
                      _currentIndex = i;
                    });
                    backgroundImageController.animateToPage(
                      i,
                      curve: Curves.easeOutCubic,
                      duration: duration,
                    );
                  }),
              itemCount: nowShowing.length,
              itemBuilder: (ctx, i, _) => AnimatedContainer(
                duration: duration,
                curve: Curves.fastOutSlowIn,
                decoration: BoxDecoration(
                  color: i == _currentIndex ? Colors.white : Colors.white54,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(30),
                    topRight: const Radius.circular(30),
                  ),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: EdgeInsets.fromLTRB(
                  10,
                  20,
                  10,
                  40,
                ),
                child: LayoutBuilder(
                  builder: (ctx, constraints) => Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(nowShowing[i]["poster_url"]),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: constraints.minHeight * 0.56,
                      ),
                      if (i == _currentIndex) ...[
                        const SizedBox(height: 12),
                        Text(
                          nowShowing[i]["title"],
                          style: textTheme.headline2!.copyWith(
                            color: Colors.black,
                            fontSize: 26,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          nowShowing[i]["genres"],
                          style: TextStyle(color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          nowShowing[i]["rating"].toString(),
                          style: textTheme.bodyText2!.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "...",
                          style: textTheme.headline2!.copyWith(
                            color: Colors.black,
                            fontSize: 20,
                            letterSpacing: 2
                          ),
                        ),
                        const Spacer(),
                        CustomTextButton(
                          color: Constants.scaffoldColor,
                          height: 54,
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
                          onPressed: () {},
                        )
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),

          //Icons row
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
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
            ),
          )
        ],
      ),
    );
  }
}
