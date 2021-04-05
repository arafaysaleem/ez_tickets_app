import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../helper/utils/constants.dart';
import '../widgets/common/custom_text_button.dart';
import '../widgets/show_times/show_dates_list.dart';
import '../widgets/show_times/show_times_list.dart';

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

final String showStatus = "Almost full";

class ShowsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 20),

            //Back and title
            Row(
              children: [
                const SizedBox(width: 15),
                GestureDetector(
                  child: const Icon(
                    Icons.arrow_back_sharp,
                    size: 32,
                  ),
                  onTap: () {
                    context.router.pop();
                  },
                ),
                const SizedBox(width: 70),
                Text(
                  movie["title"],
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 30),
                ),
              ],
            ),

            const SizedBox(height: 42),

            //Date Title
            Text(
              "Select a date",
              style: textTheme.headline5!.copyWith(
                height: 1,
                color: Constants.textGreyColor,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 10),

            //Dates list
            Container(
              decoration: BoxDecoration(
                color: Constants.scaffoldGreyColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              height: 130,
              margin: const EdgeInsets.only(left: 20),
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
              child: const ShowDatesList(),
            ),

            const SizedBox(height: 42),

            //Time Title
            Text(
              "Select a time",
              style: textTheme.headline5!.copyWith(
                height: 1,
                color: Constants.textGreyColor,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 10),

            //Show times list
            Container(
              decoration: BoxDecoration(
                color: Constants.scaffoldGreyColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              height: 85,
              margin: const EdgeInsets.only(right: 20),
              padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
              child: const ShowTimesList(),
            ),

            const SizedBox(height: 42),

            //Seats status title
            Text(
              "Show status",
              style: textTheme.headline5!.copyWith(
                height: 1,
                color: Constants.textGreyColor,
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 10),

            //Show status
            Container(
              decoration: BoxDecoration(
                color: Constants.scaffoldGreyColor,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Constants.primaryColor)
              ),
              height: 65,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  showStatus,
                  style: textTheme.headline3!.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
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
    );
  }
}
