import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShimmerLoader extends HookWidget {
  final Widget child;

  const ShimmerLoader({required this.child});

  @override
  Widget build(BuildContext context) {
    late final _controller = useAnimationController(
      duration: const Duration(milliseconds: 700),
      lowerBound: 0.5,
    );
    useEffect((){
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
      _controller.forward();
    }, const []);
    return FadeTransition(
      opacity: _controller,
      child: child,
    );
  }
}
