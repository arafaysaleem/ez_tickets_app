import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

class OverlayPlayPauseButton extends StatefulWidget {
  final BetterPlayerController betterPlayerController;

  const OverlayPlayPauseButton({
    Key? key,
    required this.betterPlayerController,
  }) : super(key: key);

  @override
  _OverlayPlayPauseButtonState createState() => _OverlayPlayPauseButtonState();
}

class _OverlayPlayPauseButtonState extends State<OverlayPlayPauseButton>
    with SingleTickerProviderStateMixin {
  late bool _initialized;
  bool _isVisible = false;
  late final AnimationController _animController;

  BetterPlayerController get _betterPlayerController => widget.betterPlayerController;

  @override
  void initState() {
    super.initState();
    /// Hide visibility if buffering or uninitialized
    _initialized = _betterPlayerController.isPlaying() ?? false;
    _betterPlayerController.addEventsListener(_handlePlayerEventChanges);
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  /// Checks and sets the initialization flag to true when the
  /// buffering is complete.
  ///
  /// All [BetterPlayerEventType] events are ignored until [_initialized]
  /// is set to true.
  void checkInitialization() {
    final bufferingComplete = _betterPlayerController.isPlaying()!;
    if (bufferingComplete) {
      setState(() {
        _initialized = bufferingComplete;
      });
    }
  }

  /// Listens to all events sent by [_betterPlayerController]
  /// and handles them with the appropriate response.
  void _handlePlayerEventChanges(BetterPlayerEvent event) {
    final eventType = event.betterPlayerEventType;
    if (!_initialized) {
      //if not initialized
      checkInitialization();
    } else if (eventType == BetterPlayerEventType.finished) {
      setState(() {
        _isVisible = false;
        _initialized = false;
      });
    } else {
      //handle events if initialized
      final controlsVisible =
          eventType == BetterPlayerEventType.controlsVisible;
      final controlsHidden = eventType == BetterPlayerEventType.controlsHidden;
      if (controlsVisible || controlsHidden) {
        //if overlay controls toggled
        setState(() {
          _isVisible = controlsVisible;
        });
      } else if (_isVisible) {
        //if other events, check control visibility
        _handlePlayPauseEvent(eventType);
      }
    }
  }

  /// Animates the overlay play icon to pause and vice versa.
  ///
  /// Called when the play/pause event is dispatched, that is, after the
  /// [_handlePlayPauseTap] is called.
  void _handlePlayPauseEvent(BetterPlayerEventType eventType) {
    final isPlay = eventType == BetterPlayerEventType.play;
    final isPause = eventType == BetterPlayerEventType.pause;
    if (isPlay) {
      _animController.reverse();
    } else if (isPause) {
      _animController.forward();
    }
  }

  /// Pauses or resumes the video using [_betterPlayerController].
  ///
  /// Called when the play/pause overlay button is pressed.
  ///
  /// The controller's methods send a pause/play event to the
  /// listener [_handlePlayerEventChanges].
  void _handlePlayPauseTap() {
    if (_betterPlayerController.isPlaying()!) {
      _betterPlayerController.pause();
    } else {
      _betterPlayerController.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) {
      return const SizedBox.shrink();
    }
    return InkWell(
      onTap: _handlePlayPauseTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Colors.black54,
          shape: BoxShape.circle,
        ),
        child: AnimatedIcon(
          icon: AnimatedIcons.pause_play,
          color: Colors.white,
          size: 32,
          progress: _animController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _betterPlayerController.removeEventsListener(_handlePlayerEventChanges);
    _animController.dispose();
    super.dispose();
  }
}