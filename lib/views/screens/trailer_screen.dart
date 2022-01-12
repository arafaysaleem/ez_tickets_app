import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Helpers
import '../../helper/utils/constants.dart';
import '../../helper/extensions/context_extensions.dart';

//Routing
import '../../routes/app_router.dart';

//Providers
import '../../providers/movies_provider.dart';

class TrailerScreen extends StatefulHookConsumerWidget {
  const TrailerScreen();

  @override
  _TrailerScreenState createState() => _TrailerScreenState();
}

class _TrailerScreenState extends ConsumerState<TrailerScreen> {
  late final BetterPlayerController _betterPlayerController;
  bool isInitialized = false;

  final _controlsConfiguration = const BetterPlayerControlsConfiguration(
    overflowModalTextColor: Constants.textGreyColor,
    overflowMenuIconsColor: Constants.textGreyColor,
    overflowModalColor: Constants.scaffoldGreyColor,
    progressBarPlayedColor: Constants.primaryColor,
    progressBarHandleColor: Constants.primaryColor,
    backgroundColor: Colors.black38,
    controlBarColor: Colors.black54,
    enablePip: false,
    enableSubtitles: false,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      final betterPlayerConfiguration = BetterPlayerConfiguration(
        aspectRatio: 4 / 3,
        fullScreenAspectRatio: 16 / 9,
        looping: false,
        autoPlay: true,
        fit: BoxFit.cover,
        allowedScreenSleep: false,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
        systemOverlaysAfterFullScreen: [SystemUiOverlay.top],
        fullScreenByDefault: true,
        autoDetectFullscreenDeviceOrientation: true,
        controlsConfiguration: _controlsConfiguration,
        errorBuilder: _buildErrorWidget,
      );
      final trailerUrl = ref.watch(selectedMovieProvider.select((value) => value.trailerUrl));
      final betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        trailerUrl,
      );
      _betterPlayerController = BetterPlayerController(
        betterPlayerConfiguration,
        betterPlayerDataSource: betterPlayerDataSource,
      );
      isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        style: context.headline3.copyWith(fontSize: 22),
                      );
                    },
                  ),
                ),
              ],
            ),

            Expanded(child: BetterPlayer(controller: _betterPlayerController)),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String? errorMessage) {
    debugPrint(errorMessage);
    return const Center(
      child: Text(
        'Playback Error',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
