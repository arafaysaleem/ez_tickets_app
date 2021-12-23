import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/utils/constants.dart';
import '../../../helper/extensions/context_extensions.dart';

//Providers
import '../../../providers/movies_provider.dart';

class MovieSummaryBox extends HookConsumerWidget {
  const MovieSummaryBox();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movie = ref.watch(selectedMovieProvider);
    return Column(
      children: [
        //Introduction title
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 7),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Introduction',
              style: context.headline2.copyWith(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
        ),

        //Summary text
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Text(
            movie.summary,
            style: context.bodyText2.copyWith(
              fontSize: 13,
              height: 1.4,
              color: Constants.textGreyColor,
            ),
          ),
        ),
      ],
    );
  }
}
