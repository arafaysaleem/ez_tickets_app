import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../helper/utils/constants.dart';
import '../widgets/common/custom_text_button.dart';

final Map<String, dynamic> movie = {
  "title": "The Hustle",
  "genres": ["Action", "Drama", "Comedy"],
  "rating": 5.4,
  "summary":
      "Forever alone in a crowd, failed comedian Arthur Fleck seeks connection as he walks the streets of Gotham City. Arthur wears two masks -- the one he paints for his day job as a clown, and the guise he projects in a futile attempt to feel like he's part of the world around him. Isolated, bullied and disregarded by society, Fleck begins a slow descent into madness as he transforms into the criminal mastermind known as the Joker.",
  "poster_url":
      "https://m.media-amazon.com/images/M/MV5BMTc3MDcyNzE5N15BMl5BanBnXkFtZTgwNzE2MDE0NzM@._V1_.jpg",
  "roles": [
    {
      "role_id": 1,
      "full_name": "Todd Phillips",
      "age": 29,
      "picture_url":
          "https://i.pinimg.com/236x/35/b6/22/35b6221b30d6b7d9cc2d1be2112783d2.jpg",
      "role_type": "director"
    },
    {
      "role_id": 2,
      "full_name": "Joaquin Pheonix",
      "age": 29,
      "picture_url":
          "https://resizing.flixster.com/_2uaAm0Gi1CSRRYDH0WNs5puAd0=/506x652/v2/https://flxt.tmsimg.com/v9/AllPhotos/69768/69768_v9_bc.jpg",
      "role_type": "cast"
    },
    {
      "role_id": 3,
      "full_name": "Robert De Niro",
      "age": 29,
      "picture_url":
          "https://cps-static.rovicorp.com/2/Open/Getty/Robert%20De%20Niro/_derived_jpg_q90_310x470_m0/186243299.jpg",
      "role_type": "cast"
    },
    {
      "role_id": 4,
      "full_name": "Zazie Beets",
      "age": 29,
      "picture_url":
          "https://resizing.flixster.com/t3iiAgmwNQpbDsiVNvNc8s3Zuug=/506x652/v2/https://flxt.tmsimg.com/v9/AllPhotos/981946/981946_v9_bb.jpg",
      "role_type": "cast"
    },
  ],
};
List<String> showDates = [
  "14\nSun",
  "15\nMon",
  "16\nTue",
  "17\nWed",
  "18\nThu"
];
List<String> showTimes = ["3:30", "4:30", "5:30", "6:30"];

class ShowsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          //Movie Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.55,
            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.3,
                    1,
                  ],
                  colors: [Colors.transparent, Colors.red],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstOut,
              child: CachedNetworkImage(
                imageUrl: movie["poster_url"],
                fit: BoxFit.cover,
              ),
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

          //Back Icon
          Positioned(
            top: 40,
            left: 15,
            child: InkWell(
              child: const Icon(
                Icons.arrow_back_sharp,
                size: 32,
                color: Colors.white,
              ),
              onTap: () => context.router.pop(),
            ),
          ),

          //Show date and times
          Positioned(
            top: screenHeight * 0.60,
            right: 0,
            left: 0,
            height: screenHeight * 0.40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Dates list
                const SizedBox(
                  height: 90,
                  child: _ShowDatesList(),
                ),

                const Spacer(),

                //Show times list
                SizedBox(
                  height: 45,
                  child: _ShowTimesList(),
                ),

                const Spacer(),

                //Continue button
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(20, 0, 20, Constants.bottomInsetsLow),
                  child: CustomTextButton.gradient(
                    width: double.infinity,
                    onPressed: () {},
                    gradient: Constants.buttonGradientOrange,
                    child: const Center(
                      child: Text(
                        "CONTINUE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          letterSpacing: 0.7,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShowDatesList extends StatefulWidget {
  const _ShowDatesList() : super();

  @override
  __ShowDatesListState createState() => __ShowDatesListState();
}

class __ShowDatesListState extends State<_ShowDatesList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: showDates.length,
      separatorBuilder: (ctx, i) => const SizedBox(width: 20),
      itemBuilder: (ctx, i) => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        margin: getItemPadding(i),
        width: 65,
        decoration: BoxDecoration(
          gradient: i == selectedIndex ? Constants.buttonGradientOrange : null,
          border: i == selectedIndex
              ? null
              : Border.all(color: Constants.primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () {
            setState(() {
              selectedIndex = i;
            });
          },
          borderRadius: BorderRadius.circular(8),
          child: Center(
            child: Text(
              showDates[i],
              textAlign: TextAlign.center,
              style: textTheme.headline3!.copyWith(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    );
  }

  EdgeInsets getItemPadding(i) {
    if (i == 0) {
      return const EdgeInsets.only(left: 20);
    } else if (i == (showDates.length - 1)) {
      return const EdgeInsets.only(right: 20);
    }
    return const EdgeInsets.all(0);
  }
}

class _ShowTimesList extends StatefulWidget {
  const _ShowTimesList() : super();

  @override
  __ShowTimesListState createState() => __ShowTimesListState();
}

class __ShowTimesListState extends State<_ShowTimesList> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: showTimes.length,
      separatorBuilder: (ctx, i) => const SizedBox(width: 20),
      itemBuilder: (ctx, i) => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        width: 110,
        margin: getItemPadding(i),
        decoration: BoxDecoration(
          gradient: i == selectedIndex ? Constants.buttonGradientOrange : null,
          border: i == selectedIndex
              ? null
              : Border.all(color: Constants.primaryColor),
          borderRadius: BorderRadius.circular(30),
        ),
        child: InkWell(
          onTap: () {
            setState(() {
              selectedIndex = i;
            });
          },
          borderRadius: BorderRadius.circular(30),
          child: Center(
            child: Text(
              showTimes[i],
              style: textTheme.headline3!.copyWith(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  EdgeInsets getItemPadding(i) {
    if (i == 0) {
      return const EdgeInsets.only(left: 20);
    } else if (i == (showTimes.length - 1)) {
      return const EdgeInsets.only(right: 20);
    }
    return const EdgeInsets.all(0);
  }
}
