import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Helpers
import '../../helper/utils/constants.dart';

//Providers
import '../../providers/movies_provider.dart';
import '../widgets/trailer/overlay_back_button.dart';

//Widgets
import '../widgets/trailer/overlay_black_header.dart';
import '../widgets/trailer/overlay_movie_title.dart';
import '../widgets/trailer/overlay_play_pause_button.dart';

class TrailerScreen extends StatefulWidget {
  const TrailerScreen();

  @override
  _TrailerScreenState createState() => _TrailerScreenState();
}

class _TrailerScreenState extends State<TrailerScreen> {
  late final BetterPlayerController _betterPlayerController;

  static const _controlsConfiguration = BetterPlayerControlsConfiguration(
      overflowModalTextColor: Constants.textGreyColor,
      overflowMenuIconsColor: Constants.textGreyColor,
      overflowModalColor: Constants.scaffoldGreyColor,
      progressBarPlayedColor: Constants.primaryColor,
      progressBarHandleColor: Constants.primaryColor,
      progressBarBufferedColor: Color(0x72ed0000),
      backgroundColor: Colors.black38,
      controlBarColor: Colors.black54,
      loadingColor: Constants.redColor,
      enablePip: false,
      enableSubtitles: false,
      controlBarHeight: 60,
  );

  static const _exitFullScreenOrientations = <DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ];

  @override
  void initState() {
    super.initState();
    final betterPlayerConfiguration = BetterPlayerConfiguration(
      aspectRatio: 4 / 3,
      fullScreenAspectRatio: 16 / 9,
      looping: false,
      autoPlay: true,
      fullScreenByDefault: true,
      allowedScreenSleep: false,
      autoDetectFullscreenDeviceOrientation: true,
      fit: BoxFit.cover,
      controlsConfiguration: _controlsConfiguration,
      deviceOrientationsAfterFullScreen: _exitFullScreenOrientations,
      systemOverlaysAfterFullScreen: [SystemUiOverlay.top],
      routePageBuilder: _fullScreenRouteBuilder,
      errorBuilder: _buildErrorWidget,
    );
    final trailerUrl = context.read(selectedMovieProvider).state.trailerUrl;
    final betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      trailerUrl,
    );
    _betterPlayerController = BetterPlayerController(
      betterPlayerConfiguration,
      betterPlayerDataSource: betterPlayerDataSource,
    );
  }

  /// List of overlay widgets for the player that add useful functionalities,
  /// like Back Navigation, Play/Pause ability or Movie Title.
  List<Widget> buildOverlayWidgets() {
    return [
      //Black overlay header
      Align(
        alignment: Alignment.topCenter,
        child: OverlayBlackHeader(
          betterPlayerController: _betterPlayerController,
        ),
      ),

      //Movie title
      Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: OverlayMovieTitle(
            betterPlayerController: _betterPlayerController,
          ),
        ),
      ),

      //Back button
      Align(
        alignment: Alignment.topLeft,
        child: OverlayBackButton(
          betterPlayerController: _betterPlayerController,
        ),
      ),

      //Play/Pause Button
      Align(
        alignment: _betterPlayerController.isFullScreen
            ? Alignment.center
            : Alignment.topCenter,
        child: Padding(
          padding: _betterPlayerController.isFullScreen
              ? const EdgeInsets.all(0)
              : const EdgeInsets.only(top: 105),
          child: OverlayPlayPauseButton(
            betterPlayerController: _betterPlayerController,
          ),
        ),
      ),
    ];
  }

  /// Defines the builder for the new route that gets pushed on
  /// the fullscreen mode.
  Widget _fullScreenRouteBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    BetterPlayerControllerProvider provider,
  ) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedBuilder(
        animation: animation,
        builder: (ctx, _) => Stack(
          children: [
            //Video Player
            Container(
              alignment: Alignment.center,
              child: provider,
            ),

            //Overlay widgets
            ...buildOverlayWidgets()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            //Video Player
            Positioned(
              top: 5,
              right: 0,
              left: 0,
              child: BetterPlayer(controller: _betterPlayerController),
            ),

            //Overlay widgets
            ...buildOverlayWidgets(),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(context, errorMessage) {
    debugPrint(errorMessage);
    return const Center(
      child: Text(
        "Playback Error",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
