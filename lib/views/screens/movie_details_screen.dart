import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../helper/utils/constants.dart';

final movie = {
  "title": "Joker",
  "genres": ["Action", "Drama", "History"],
  "rating": 9.0,
  "poster_url":
      "https://talenthouse-res.cloudinary.com/image/upload/c_limit,f_auto,fl_progressive,h_1280,w_1280/v1568795702/user-1024773/profile/jox3adylqftz1rzurgzz.jpg"
};

final leftMoviePoster =
    "https://m.media-amazon.com/images/M/MV5BMTc1NjIzODAxMF5BMl5BanBnXkFtZTgwMTgzNzk1NzM@._V1_.jpg";
final rightMoviePoster =
    "https://m.media-amazon.com/images/M/MV5BMTc3MDcyNzE5N15BMl5BanBnXkFtZTgwNzE2MDE0NzM@._V1_.jpg";

class MovieDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          //left movie poster
          Positioned(
            top: 90,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(leftMoviePoster),
                    fit: BoxFit.fill
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 250,
              width: 150,
            ),
          ),

          //right movie poster
          Positioned(
            top: 90,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(rightMoviePoster),
                    fit: BoxFit.fill
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 250,
              width: 150,
            ),
          ),

          //Top black overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 250,
            child: Container(
              decoration: BoxDecoration(
                gradient: Constants.blackOverlayGradient,
              ),
            ),
          ),

          //right movie poster
          Positioned(
            top: 60,
            right: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(rightMoviePoster),
                    fit: BoxFit.fill
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 250,
              width: 150,
            ),
          ),

          //Icons row
          Positioned(
            top: 0,
            left: 0,
            right: 0,
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
