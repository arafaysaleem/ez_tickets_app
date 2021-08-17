import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

//Routing
import '../../../routes/app_router.dart';

//Widgets
import 'movie_type_popup_menu.dart';

class MoviesIconsRow extends HookWidget {
  const MoviesIconsRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Back Arrow
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            padding: const EdgeInsets.all(0),
            onPressed: () => AppRouter.pop(),
          ),

          //Filter
          const MovieTypePopupMenu(),
        ],
      ),
    );
  }
}
