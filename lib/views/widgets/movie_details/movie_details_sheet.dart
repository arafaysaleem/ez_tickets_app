import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

//Helper
import '../../../helper/utils/constants.dart';
import '../../../helper/extensions/context_extensions.dart';

//Widgets
import 'movie_actors_list.dart';
import 'movie_details_column.dart';
import 'movie_summary_box.dart';
import 'play_button_widget.dart';

final mainPosterScaleRatioProvider = StateProvider.autoDispose((_) => 1.0);
final btnScaleRatioProvider = StateProvider.autoDispose((_) => 1.0);

class MovieDetailsSheet extends StatefulHookConsumerWidget {
  const MovieDetailsSheet();

  @override
  _MovieDetailsSheetState createState() => _MovieDetailsSheetState();
}

class _MovieDetailsSheetState extends ConsumerState<MovieDetailsSheet> {
  late final PanelController panelController = PanelController();
  final snapPoint = 0.2;

  double _playBtnPos(double minHeight,double maxHeight,double panelPosition) {
    return minHeight - 28.5 + panelPosition * (maxHeight - minHeight);
  }

  double getPlayBtnScaleRatio(double slide) {
    // vanish the button at extent of 0.65
    // appear the button at extent of 0.50
    const range = 0.65 - 0.50;
    // goes from 1.0 -> 0.0
    return ((0.65 - slide) / range).clamp(0.0, 1.0);
  }

  double getPosterScaleRatio(double slide, double startExtent) {
    if (slide > startExtent) return 1; //if sheet above start point
    // change poster size between these two extents
    var endExtent = 0.0;
    final extentRange = startExtent - endExtent;
    // scaleRatio goes from 1.0 -> 2.2
    const scaleRange = 1 - 2.2;
    final extentRatio = (slide - endExtent) / extentRange;
    return extentRatio * scaleRange + 2.2;
  }

  void _onPanelSlide(double slide, AnimationController animationController) {
    //Update animation controller for play button position
    animationController.value = slide;

    //Calculate and store main poster scale ratio
    final posterScaleRatio = getPosterScaleRatio(slide, snapPoint);
    ref.read(mainPosterScaleRatioProvider.state).update((_) => posterScaleRatio);

    //Animate playButton
    final btnScaleRatio = getPlayBtnScaleRatio(slide);
    ref.read(btnScaleRatioProvider.state).update((_) => btnScaleRatio);

    //Bounce sheet if necessary
    if (slide < snapPoint && !panelController.isPanelAnimating) {
      panelController.animatePanelToPosition(
        snapPoint,
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = context.screenHeight;
    var maxHeight = 0.96 * screenHeight;
    var minHeight = 0.65 * screenHeight;
    late final _animationController = useAnimationController(
      duration: const Duration(milliseconds: 0),
    );
    useEffect(() {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        panelController.animatePanelToPosition(
          snapPoint,
          duration: const Duration(milliseconds: 1150),
          curve: Curves.elasticOut,
        );
      });
    }, const []);
    Widget? child;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        //Movie details sheet
        SlidingUpPanel(
          controller: panelController,
          maxHeight: maxHeight,
          minHeight: minHeight,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          onPanelSlide: (slide) => _onPanelSlide(slide, _animationController),
          panelBuilder: (controller) {
            child ??= Padding(
                padding: const EdgeInsets.only(
                  bottom: Constants.bottomInsetsLow + 54,
                ),
                child: ListView(
                  controller: controller,
                  children: const [
                    SizedBox(height: 5),

                    //Movie details
                    MovieDetailsColumn(),

                    SizedBox(height: 20),

                    //Actors
                    MovieActorsList(),

                    SizedBox(height: 25),

                    //Summary
                    MovieSummaryBox(),
                  ],
                ),
              );
            return child!;
          },
        ),

        //White text fade
        const Positioned(
          bottom: 0,
          right: 20,
          left: 20,
          height: Constants.bottomInsetsLow + 90,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0.3, 1],
                colors: [Colors.white24, Colors.white, Colors.white],
              ),
            ),
          ),
        ),

        //Play button
        AnimatedBuilder(
          animation: _animationController,
          builder: (ctx, child) => AnimatedPositioned(
            duration: const Duration(milliseconds: 0),
            bottom: _playBtnPos(
              minHeight,
              maxHeight,
              panelController.panelPosition,
            ),
            child: child!,
          ),
          child: const PlayButtonWidget(),
        )
      ],
    );
  }
}
