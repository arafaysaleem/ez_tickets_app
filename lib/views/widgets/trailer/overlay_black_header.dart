import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

class OverlayBlackHeader extends StatefulWidget {
  final BetterPlayerController betterPlayerController;

  const OverlayBlackHeader({
    Key? key,
    required this.betterPlayerController,
  }) : super(key: key);

  @override
  _OverlayBlackHeaderState createState() => _OverlayBlackHeaderState();
}

class _OverlayBlackHeaderState extends State<OverlayBlackHeader> {
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
    return const IgnorePointer(
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ColoredBox(
            color: Colors.black54,
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