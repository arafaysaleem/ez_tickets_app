import 'package:flutter/material.dart';

import '../../../helper/utils/constants.dart';

List<String> showTimes = ["3:30", "4:30", "5:30", "6:30"];

class ShowTimesList extends StatefulWidget {
  const ShowTimesList() : super();

  @override
  _ShowTimesListState createState() => _ShowTimesListState();
}

class _ShowTimesListState extends State<ShowTimesList> {
  int selectedIndex = 0;

  Shader getShader(bounds) {
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
            isActive: i == selectedIndex,
            onTap: () {
              setState(() {
                selectedIndex = i;
              });
            },
            time: showTimes[i],
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
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
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
            style: textTheme.headline3!.copyWith(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
