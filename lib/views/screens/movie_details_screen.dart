import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

//Helper
import '../../helper/utils/constants.dart';

//Routes
import '../../routes/app_router.gr.dart';

//Placeholders
import '../skeletons/movie_poster_placeholder.dart';

//Widgets
import '../widgets/common/custom_network_image.dart';
import '../widgets/common/custom_text_button.dart';
import '../widgets/movie_details/movie_details_sheet.dart';

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

final leftMoviePoster =
    "https://m.media-amazon.com/images/M/MV5BMTc1NjIzODAxMF5BMl5BanBnXkFtZTgwMTgzNzk1NzM@._V1_.jpg";
final rightMoviePoster =
    "https://talenthouse-res.cloudinary.com/image/upload/c_limit,f_auto,fl_progressive,h_1280,w_1280/v1568795702/user-1024773/profile/jox3adylqftz1rzurgzz.jpg";

class MovieDetailsScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final topGap = 230.0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          //left movie poster
          Positioned(
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
          ),

          //right movie poster
          Positioned(
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
          ),

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
          Positioned(
            top: 80,
            height: 250,
            width: 190,
            child: CustomNetworkImage(
              imageUrl: movie["poster_url"],
              borderRadius: 10,
              placeholder: const MoviePosterPlaceholder(),
              errorWidget: const MoviePosterPlaceholder(),
              fit: BoxFit.fill,
              margin: const EdgeInsets.symmetric(horizontal: 10),
            ),
          ),

          //White details sheet
          Positioned(
            top: topGap,
            bottom: 0,
            right: 0,
            left: 0,
            child: const MovieDetailsSheet(),
          ),

          //play button
          Positioned(
            top: topGap - 30,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 5,
                minimumSize: const Size(57, 57),
                primary: Colors.white,
                padding: const EdgeInsets.all(0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
              ),
              child: const Icon(
                Icons.play_arrow_sharp,
                size: 35,
                color: Colors.black,
              ),
            ),
          ),

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
