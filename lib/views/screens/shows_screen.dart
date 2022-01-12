import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helper
import '../../enums/show_status_enum.dart';
import '../../helper/extensions/context_extensions.dart';
import '../../helper/utils/constants.dart';

//Providers
import '../../providers/movies_provider.dart';
import '../../providers/shows_provider.dart';
import '../../routes/app_router.dart';

//Routing
import '../../routes/routes.dart';

//Skeletons
import '../skeletons/shows_skeleton_loader.dart';

//Widgets
import '../widgets/common/custom_text_button.dart';
import '../widgets/common/error_response_handler.dart';
import '../widgets/show_times/show_dates_list.dart';
import '../widgets/show_times/show_details_box.dart';
import '../widgets/show_times/show_times_list.dart';

class ShowsScreen extends HookConsumerWidget {
  const ShowsScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showList = ref.watch(showsFutureProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            //Back and title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 15),
                InkResponse(
                  radius: 25,
                  child: const Icon(Icons.arrow_back_sharp, size: 26),
                  onTap: () {
                    AppRouter.pop();
                  },
                ),

                const SizedBox(width: 20),

                //Movie Title
                Expanded(
                  child: Consumer(
                    builder: (_, watch, __) {
                      final title = ref.watch(selectedMovieProvider).title;
                      return Text(
                        title,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: context.headline3.copyWith(fontSize: 22),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 50),
              ],
            ),

            const SizedBox(height: 42),

            //Show details
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 550),
                switchOutCurve: Curves.easeInBack,
                child: showList.when(
                  data: (shows) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //Date Title
                      Text(
                        'Select a date',
                        style: context.headline5.copyWith(
                          height: 1,
                          color: Constants.textGreyColor,
                          fontSize: 20,
                        ),
                      ),

                      const SizedBox(height: 15),

                      //Dates list
                      Container(
                        height: 130,
                        decoration: const BoxDecoration(
                          color: Constants.scaffoldGreyColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        margin: const EdgeInsets.only(left: 20),
                        padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                        child: ShowDatesList(shows),
                      ),

                      const Spacer(),

                      //Time Title
                      Text(
                        'Select a time',
                        style: context.headline5.copyWith(
                          height: 1,
                          color: Constants.textGreyColor,
                          fontSize: 20,
                        ),
                      ),

                      const SizedBox(height: 15),

                      //Show times list
                      Container(
                        decoration: const BoxDecoration(
                          color: Constants.scaffoldGreyColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        height: 85,
                        margin: const EdgeInsets.only(right: 20),
                        padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                        child: const ShowTimesList(),
                      ),

                      const Spacer(),

                      //Seats details title
                      Text(
                        'Show details',
                        style: context.headline5.copyWith(
                          height: 1,
                          color: Constants.textGreyColor,
                          fontSize: 20,
                        ),
                      ),

                      const SizedBox(height: 15),

                      //Show details box
                      const ShowDetailsBox(),

                      const Spacer(),

                      //Continue button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Consumer(
                          builder: (ctx, ref, child) {
                            final showStatus =
                                ref.watch(selectedShowTimeProvider).showStatus;
                            return CustomTextButton.gradient(
                              width: double.infinity,
                              disabled: showStatus == ShowStatus.FULL,
                              onPressed: () {
                                AppRouter.pushNamed(Routes.TheaterScreenRoute);
                              },
                              gradient: Constants.buttonGradientOrange,
                              child: const Center(
                                child: Text(
                                  'CONTINUE',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    letterSpacing: 0.7,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 5),
                    ],
                  ),
                  loading: () => const ShowsSkeletonLoader(),
                  error: (error, st) => ErrorResponseHandler(
                    retryCallback: () => ref.refresh(showsFutureProvider),
                    error: error,
                    stackTrace: st,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
