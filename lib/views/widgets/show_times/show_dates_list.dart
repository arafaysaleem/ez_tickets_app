import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

//Helpers
import '../../../helper/utils/constants.dart';
import '../../../helper/extensions/context_extensions.dart';

//Models
import '../../../models/show_model.dart';

//Providers
import '../../../providers/shows_provider.dart';

class ShowDatesList extends ConsumerStatefulWidget {
  final List<ShowModel> shows;

  const ShowDatesList(this.shows);

  @override
  _ShowDatesListState createState() => _ShowDatesListState();
}

class _ShowDatesListState extends ConsumerState<ShowDatesList> {
  int selectedIndex = 0;

  Shader getShader(Rect bounds) {
    return const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [0.95, 1],
      colors: [Colors.transparent, Colors.black87],
    ).createShader(bounds);
  }

  List<ShowModel> get shows => widget.shows;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: getShader,
      blendMode: BlendMode.dstOut,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: shows.length,
        separatorBuilder: (ctx, i) => const SizedBox(width: 20),
        itemBuilder: (ctx, i) => Padding(
          padding: i == shows.length - 1
              ? const EdgeInsets.only(right: 20)
              : const EdgeInsets.all(0),
          child: _ShowDateItem(
            isActive: i == selectedIndex,
            onTap: () {
              ref.read(selectedShowProvider.state).update((_) => shows[i]);
              setState(() {
                selectedIndex = i;
              });
            },
            date: DateFormat.d().format(shows[i].date),
            weekDay: DateFormat.E().format(shows[i].date),
          ),
        ),
      ),
    );
  }
}

class _ShowDateItem extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;
  final String weekDay, date;

  const _ShowDateItem({
    Key? key,
    required this.isActive,
    required this.onTap,
    required this.date,
    required this.weekDay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Constants.defaultAnimationDuration,
        curve: Curves.fastOutSlowIn,
        width: 60,
        decoration: BoxDecoration(
          gradient: isActive ? Constants.buttonGradientOrange : null,
          border: isActive ? null : Border.all(color: Constants.primaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Weekday
            Text(
              weekDay,
              textAlign: TextAlign.center,
              style: context.headline3.copyWith(
                color: Colors.white,
                fontSize: 17,
              ),
            ),

            const SizedBox(height: 5),

            //date
            Text(
              date,
              textAlign: TextAlign.center,
              style: context.headline3.copyWith(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
