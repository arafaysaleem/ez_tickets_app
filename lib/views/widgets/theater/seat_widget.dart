import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/utils/constants.dart';

//Models
import '../../../models/seat_model.dart';

//Providers
import '../../../providers/all_providers.dart';

class SeatWidget extends StatefulHookConsumerWidget {
  final SeatModel seat;

  const SeatWidget({
    required this.seat,
    Key? key,
  }) : super(key: key);

  @override
  _SeatWidgetState createState() => _SeatWidgetState();
}

class _SeatWidgetState extends ConsumerState<SeatWidget> {
  bool isSelected = false;

  void _onTap(){
    setState(() {
      isSelected = !isSelected;
    });
    final _theatersProvider = ref.read(theatersProvider);
    _theatersProvider.toggleSeat(seat: widget.seat, select: isSelected);
  }

  @override
  Widget build(BuildContext context) {
    final animController = useAnimationController(
      duration: const Duration(milliseconds: 90),
    );
    final bounceAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(
        parent: animController,
        curve: Curves.easeInQuad,
      ),
    );
    useEffect((){
      bounceAnimation.addStatusListener((status) {
        if(status == AnimationStatus.completed) animController.reverse();
      });
    }, const []);
    return GestureDetector(
      onTap: _onTap,
      onTapDown: (_) => animController.forward(),
      child: AnimatedBuilder(
        animation: bounceAnimation,
        builder: (ctx, child) => Transform.scale(
          scale: bounceAnimation.value,
          child: child,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isSelected ? Constants.redColor : Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
