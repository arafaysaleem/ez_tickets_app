import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helper
import '../../helper/utils/constants.dart';

//Models
import '../../models/show_model.dart';

//Providers
import '../../providers/all_providers.dart';

//Services
import '../../services/networking/network_exception.dart';
import '../widgets/common/custom_error_widget.dart';

//Widgets
import '../widgets/common/custom_text_button.dart';
import '../widgets/show_times/show_dates_list.dart';
import '../widgets/show_times/show_times_list.dart';

final showsFuture = FutureProvider.family<List<ShowModel>, int>(
  (ref, movieId) async {
    final _showsProvider = ref.watch(showsProvider);

    return await _showsProvider.getAllShows(movieId: movieId);
  },
);

final showStatus = "free";

class ShowsScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final movie = useProvider(selectedMovie).state;
    final showList = useProvider(showsFuture(movie.movieId!));
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
                  movie.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 30),
                ),
              ],
            ),

            const SizedBox(height: 42),

            showList.when(
              data: (shows) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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

                  //Seats details title
                  Text(
                    "Show details",
                    style: textTheme.headline5!.copyWith(
                      height: 1,
                      color: Constants.textGreyColor,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 10),

                  //Show details box
                  Container(
                    decoration: BoxDecoration(
                      color: Constants.scaffoldGreyColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      border: Border.all(color: Constants.primaryColor),
                    ),
                    height: 65,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(
                        vertical: 17, horizontal: 35),
                    child: Row(
                      children: [
                        Text(
                          "3D",
                          style: textTheme.headline3!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                            fontSize: 19,
                          ),
                        ),

                        //Divider line
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          child: VerticalDivider(
                            thickness: 1.1,
                            width: 0,
                            color: Colors.white,
                          ),
                        ),

                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //Status
                              Text(
                                showStatus.toUpperCase(),
                                style: textTheme.headline3!.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),

                              //Seating level icon
                              if (showStatus != "Almost full")
                                const Icon(
                                  Icons.error_rounded,
                                  size: 25,
                                  color: Colors.amber,
                                )
                              else if (showStatus != "Full")
                                const Icon(
                                  Icons.warning_rounded,
                                  size: 25,
                                  color: Colors.red,
                                )
                              else if (showStatus == "Free")
                                Icon(
                                  Icons.check_circle_sharp,
                                  size: 25,
                                  color: Colors.lightGreenAccent[700],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  //Continue button
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      20,
                      0,
                      20,
                      Constants.bottomInsetsLow,
                    ),
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
              loading: () => Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Constants.primaryColor),
                ),
              ),
              error: (error, st) {
                if (error is NetworkException) {
                  return CustomErrorWidget.dark(
                    error: error,
                    retryCallback: () {
                      context.refresh(showsFuture(movie.movieId!));
                    },
                    height: screenHeight * 0.5,
                  );
                }
                debugPrint(error.toString());
                debugPrint(st.toString());
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
