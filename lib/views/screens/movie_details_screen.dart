import 'package:flutter/material.dart';

//Helper
import '../../helper/utils/constants.dart';
import '../../helper/extensions/context_extensions.dart';

//Routing
import '../../routes/routes.dart';
import '../../routes/app_router.dart';

//Widgets
import '../widgets/movie_details/floating_movie_posters.dart';
import '../widgets/common/custom_text_button.dart';
import '../widgets/movie_details/movie_details_sheet.dart';

class MovieDetailsScreen extends StatelessWidget{
  const MovieDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const FloatingMoviePosters(),

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
                  'VIEW SHOWS',
                  style: context.headline1.copyWith(
                        color: Colors.white,
                        fontSize: 15,
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              onPressed: () {
                AppRouter.pushNamed(Routes.ShowsScreenRoute);
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
                splashRadius: 25,
                icon: const Icon(Icons.close_rounded, size: 25),
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  AppRouter.pop();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
