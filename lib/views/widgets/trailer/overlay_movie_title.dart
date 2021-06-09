import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/extensions/context_extensions.dart';

//Providers
import '../../../providers/movies_provider.dart';

class OverlayMovieTitle extends StatefulHookWidget {
  final BetterPlayerController betterPlayerController;

  const OverlayMovieTitle({
    Key? key,
    required this.betterPlayerController,
  }) : super(key: key);

  @override
  _OverlayMovieTitleState createState() => _OverlayMovieTitleState();
}

class _OverlayMovieTitleState extends State<OverlayMovieTitle> {
  bool _isVisible = false;

  BetterPlayerController get _betterPlayerController => widget.betterPlayerController;

  @override
  void initState() {
    super.initState();
    _betterPlayerController.addEventsListener(_handlePlayerEventChanges);
  }

  /// Listens to all events sent by [_betterPlayerController]
  /// and handles them with the appropriate response.
  void _handlePlayerEventChanges(BetterPlayerEvent event) {
    final eventType = event.betterPlayerEventType;
    //handle events if initialized
    final controlsVisible = eventType == BetterPlayerEventType.controlsVisible;
    final controlsHidden = eventType == BetterPlayerEventType.controlsHidden;
    if (controlsVisible || controlsHidden) { //if overlay controls toggled
      setState(() {
        _isVisible = controlsVisible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) {
      return const SizedBox.shrink();
    }
    final title = useProvider(selectedMovieProvider.select(
          (value) => value.state.title,
    ));
    return Text(
      title,
      maxLines: 1,
      style: context.headline3.copyWith(fontSize: 22),
    );
  }

  @override
  void dispose() {
    _betterPlayerController.removeEventsListener(_handlePlayerEventChanges);
    super.dispose();
  }
}
