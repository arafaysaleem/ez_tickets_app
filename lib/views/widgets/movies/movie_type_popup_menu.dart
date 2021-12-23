import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Enums
import '../../../enums/movie_type_enum.dart';

//Helpers
import '../../../helper/extensions/context_extensions.dart';
import '../../../helper/extensions/string_extension.dart';
import '../../../helper/utils/constants.dart';

//Providers
import '../../../providers/movies_provider.dart';

class MovieTypePopupMenu extends ConsumerWidget {
  const MovieTypePopupMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<MovieType>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      color: Constants.scaffoldColor,
      icon: const Icon(
        Icons.filter_list_rounded,
        size: 25,
        color: Colors.white,
      ),
      itemBuilder: (_) => [
        //'ALL' types item
        PopupMenuItem(
          value: MovieType.ALL_MOVIES,
          child: Text(
            MovieType.ALL_MOVIES.name.removeUnderScore,
            style: context.bodyText1,
            maxLines: 1,
          ),
        ),

        PopupMenuItem(
          value: MovieType.NOW_SHOWING,
          child: Text(
            MovieType.NOW_SHOWING.name.removeUnderScore,
            style: context.bodyText1,
            maxLines: 1,
          ),
        ),

        PopupMenuItem(
          value: MovieType.COMING_SOON,
          child: Text(
            MovieType.COMING_SOON.name.removeUnderScore,
            style: context.bodyText1,
            maxLines: 1,
          ),
        )
      ],
      onSelected: (newValue) {
        final _selectedMovieTypeProv = ref.read(selectedMovieTypeProvider.state);
        if(_selectedMovieTypeProv.state != newValue){
          _selectedMovieTypeProv.state = newValue;
        }
      },
    );
  }
}
