import 'package:flutter/material.dart';

import '../../skeletons/actor_picture_placeholder.dart';

import '../common/custom_network_image.dart';

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

class MovieActorsList extends StatelessWidget {
  const MovieActorsList();

  EdgeInsets getImagePadding(i) {
    if (i == 0) {
      return const EdgeInsets.only(left: 20);
    } else if (i == (movie["roles"].length - 1)) {
      return const EdgeInsets.only(right: 20);
    }
    return const EdgeInsets.all(0);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        //Actors title
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Actors",
              style: textTheme.headline2!.copyWith(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        //Actors list
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (ctx, i) => const SizedBox(width: 15),
            itemCount: movie["roles"].length,
            itemBuilder: (ctx, i) => Padding(
              padding: getImagePadding(i),
              child: _ActorListItem(
                pictureUrl: movie["roles"][i]["picture_url"],
                fullName: movie["roles"][i]["full_name"],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ActorListItem extends StatelessWidget {
  const _ActorListItem({
    Key? key,
    required this.pictureUrl,
    required this.fullName,
  }) : super(key: key);

  final String pictureUrl, fullName;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        //Image
        CustomNetworkImage(
          imageUrl: pictureUrl,
          height: 100,
          width: 100,
          fit: BoxFit.cover,
          borderRadius: 5,
          placeholder: (_,__) => const ActorPicturePlaceholder(),
          errorWidget: (_,__,___) => const ActorPicturePlaceholder(),
        ),

        const SizedBox(height: 5),

        //Name
        Expanded(
          child: Text(
            fullName,
            style: textTheme.headline4!.copyWith(
              color: Colors.black,
              fontSize: 13,
            ),
          ),
        )
      ],
    );
  }
}
