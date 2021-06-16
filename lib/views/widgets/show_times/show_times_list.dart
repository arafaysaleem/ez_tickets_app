import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

//Providers
import '../../../providers/shows_provider.dart';

//Helpers
import '../../../helper/utils/constants.dart';
import '../../../helper/extensions/context_extensions.dart';

class ShowTimesList extends HookWidget {
  const ShowTimesList();

  Shader getShader(Rect bounds) {
    return const LinearGradient(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
      stops: [
        0.95,
        1,
      ],
      colors: [Colors.transparent, Colors.black87],
    ).createShader(bounds);
  }

  @override
  Widget build(BuildContext context) {
    final showTimes = useProvider(selectedShowProvider).state.showTimes;
    final selectedShowTime = useProvider(selectedShowTimeProvider).state;
    return ShaderMask(
      shaderCallback: getShader,
      blendMode: BlendMode.dstOut,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        reverse: true,
        scrollDirection: Axis.horizontal,
        itemCount: showTimes.length,
        separatorBuilder: (ctx, i) => const SizedBox(width: 20),
        itemBuilder: (ctx, i) => Padding(
          padding: i == showTimes.length - 1
              ? const EdgeInsets.only(left: 20)
              : const EdgeInsets.all(0),
          child: _ShowTimeItem(
            isActive: showTimes[i] == selectedShowTime,
            onTap: () {
              context.read(selectedShowTimeProvider).state = showTimes[i];
            },
            time: DateFormat.jm().format(showTimes[i].startTime),
          ),
        ),
      ),
    );
  }
}

class _ShowTimeItem extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;
  final String time;

  const _ShowTimeItem({
    Key? key,
    required this.isActive,
    required this.onTap,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Constants.defaultAnimationDuration,
        curve: Curves.fastOutSlowIn,
        width: 110,
        decoration: BoxDecoration(
          gradient: isActive ? Constants.buttonGradientOrange : null,
          border: isActive ? null : Border.all(color: Constants.primaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Center(
          child: Text(
            time,
            textAlign: TextAlign.center,
            style: context.headline3.copyWith(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
