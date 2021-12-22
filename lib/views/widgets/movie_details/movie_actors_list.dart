import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Enums
import '../../../enums/role_type_enum.dart';
import '../../../helper/extensions/context_extensions.dart';

//Helpers
import '../../../helper/utils/constants.dart';

//Models
import '../../../models/movie_role_model.dart';
import '../../../providers/all_providers.dart';

//Providers
import '../../../providers/movies_provider.dart';

//Placeholders
import '../../skeletons/actor_picture_placeholder.dart';

//Skeletons
import '../../skeletons/movie_actors_skeleton_loader.dart';

//Widgets
import '../common/custom_network_image.dart';
import '../common/error_response_handler.dart';

final movieRolesFuture = FutureProvider.family.autoDispose<List<MovieRoleModel>, int>(
  (ref, movieId) async {
    final _moviesProvider = ref.watch(moviesProvider);

    final movieRolesList = await _moviesProvider.getMovieRoles(
      movieId: movieId,
    );

    ref.maintainState = true; //Caches the response only if the future completed.
    return movieRolesList;
  },
);

class MovieActorsList extends HookConsumerWidget {
  const MovieActorsList();

  EdgeInsets getImagePadding({required bool isFirst, required bool isLast}) {
    if (isFirst) {
      return const EdgeInsets.only(left: 20);
    } else if (isLast) {
      return const EdgeInsets.only(right: 20);
    }
    return const EdgeInsets.all(0);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieId = ref.watch(selectedMovieProvider.select((value) {
      return value.movieId;
    }));
    final movieRoles = ref.watch(movieRolesFuture(movieId!));
    return Column(
      children: [
        //Actors title
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Cast And Crew',
              style: context.headline2.copyWith(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),

        //Actors list
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 550),
          switchOutCurve: Curves.easeInBack,
          child: movieRoles.when(
            data: (movieRoles) => SizedBox(
              height: context.screenHeight / 5.38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (ctx, i) => const SizedBox(width: 15),
                itemCount: movieRoles.length,
                itemBuilder: (ctx, i) {
                  final mRole = movieRoles[i].role;
                  final isLast = i == (movieRoles.length - 1);
                  final isFirst = i == 0;
                  return Padding(
                    padding: getImagePadding(isFirst: isFirst, isLast: isLast),
                    child: _ActorListItem(
                      pictureUrl: mRole.pictureUrl,
                      fullName: mRole.fullName,
                      roleType: movieRoles[i].roleType.inString,
                    ),
                  );
                },
              ),
            ),
            loading: () => const MovieActorsSkeletonLoader(),
            error: (error, st) => ErrorResponseHandler.builder(
              error: error,
              stackTrace: st,
              builder: (error) => Text(error.message),
            ),
          ),
        ),
      ],
    );
  }
}

class _ActorListItem extends StatelessWidget {
  const _ActorListItem({
    Key? key,
    required this.pictureUrl,
    required this.roleType,
    required this.fullName,
  }) : super(key: key);

  final String pictureUrl, fullName, roleType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Image
        CustomNetworkImage(
          imageUrl: pictureUrl,
          height: 100,
          width: 100,
          fit: BoxFit.cover,
          radius: 5,
          placeholder: const ActorPicturePlaceholder(),
          errorWidget: const ActorPicturePlaceholder(),
        ),

        const SizedBox(height: 5),

        //Name
        Expanded(
          child: Text(
            fullName,
            style: context.headline4.copyWith(
              color: Colors.black,
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.fade,
          ),
        ),

        const SizedBox(height: 3),

        //Role type
        Expanded(
          child: Text(
            roleType,
            style: context.headline4.copyWith(
              color: Constants.textGreyColor,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.fade,
          ),
        )
      ],
    );
  }
}
