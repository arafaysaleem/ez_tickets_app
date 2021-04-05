import 'package:flutter/material.dart';

import '../../../helper/utils/constants.dart';
import '../common/scrollable_column.dart';
import 'movie_actors_list.dart';
import 'movie_details_column.dart';
import 'movie_summary_box.dart';

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

class MovieDetailsSheet extends StatelessWidget {
  const MovieDetailsSheet({
    Key? key,
  }) : super(key: key);

  Shader getShader(bounds) {
    return const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [
        0.9,
        1,
      ],
      colors: [Colors.transparent, Colors.red],
    ).createShader(bounds);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30),
          topRight: const Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.only(top: 35),
      child: Column(
        children: [
          //Movie details
          const MovieDetailsColumn(),

          const SizedBox(height: 20),

          Flexible(
            child: ShaderMask(
              shaderCallback: getShader,
              blendMode: BlendMode.dstOut,
              child: const ScrollableColumn(
                physics: BouncingScrollPhysics(),
                children: [
                  //Actors
                  MovieActorsList(),

                  SizedBox(height: 30),

                  //Summary
                  MovieSummaryBox()
                ],
              ),
            ),
          ),

          SizedBox(height: Constants.bottomInsetsLow + 54),
        ],
      ),
    );
  }
}
