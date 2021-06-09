import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:auto_route/auto_route.dart';

class OverlayBackButton extends StatefulWidget {
  final BetterPlayerController betterPlayerController;

  const OverlayBackButton({
    Key? key,
    required this.betterPlayerController,
  }) : super(key: key);

  @override
  _OverlayBackButtonState createState() => _OverlayBackButtonState();
}

class _OverlayBackButtonState extends State<OverlayBackButton> {
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
    return InkWell(
      onTap: () => context.router.pop(),
      child: const Padding(
        padding: EdgeInsets.all(15),
        child: Icon(
          Icons.arrow_back_sharp,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _betterPlayerController.removeEventsListener(_handlePlayerEventChanges);
    super.dispose();
  }
}