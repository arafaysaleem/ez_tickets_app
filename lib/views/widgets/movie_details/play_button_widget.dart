import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Providers
import 'movie_details_sheet.dart' show btnScaleRatioProvider;

//Routing
import '../../../routes/routes.dart';
import '../../../routes/app_router.dart';

class PlayButtonWidget extends HookConsumerWidget {
  const PlayButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final btnScaleRatio = ref.watch(btnScaleRatioProvider);
    return ElevatedButton(
      onPressed: () {
        AppRouter.pushNamed(Routes.TrailerScreenRoute);
      },
      style: ElevatedButton.styleFrom(
        elevation: 5,
        minimumSize: Size.fromRadius(btnScaleRatio * 28.5),
        primary: Colors.white,
        padding: const EdgeInsets.all(0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
      ),
      child: Icon(
        Icons.play_arrow_sharp,
        size: btnScaleRatio * 35,
        color: Colors.black,
      ),
    );
  }
}
