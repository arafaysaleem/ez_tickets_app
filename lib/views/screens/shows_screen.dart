import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helper
import '../../helper/utils/constants.dart';

//Providers
import '../../providers/all_providers.dart';
import '../../providers/shows_provider.dart';

//Services
import '../../services/networking/network_exception.dart';

//Widgets
import '../widgets/common/custom_error_widget.dart';
import '../widgets/common/custom_text_button.dart';
import '../widgets/show_times/show_dates_list.dart';
import '../widgets/show_times/show_details_box.dart';
import '../widgets/show_times/show_times_list.dart';

class ShowsScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final showList = useProvider(showsFuture);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
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

                //Movie Title
                Consumer(
                  builder: (_, watch, __) {
                    final title = watch(selectedMovie).state.title;
                    return Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(fontSize: 30),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 42),

            showList.when(
              data: (shows) => Expanded(
                child: Column(
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
                      height: 130,
                      decoration: BoxDecoration(
                        color: Constants.scaffoldGreyColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      margin: const EdgeInsets.only(left: 20),
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                      child: ShowDatesList(shows),
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
                    const ShowDetailsBox(),

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
                      context.refresh(showsFuture);
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
