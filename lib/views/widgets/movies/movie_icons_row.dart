import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:auto_route/auto_route.dart';

//Providers
import '../../../providers/all_providers.dart';

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
          //Logout
          RotatedBox(
            quarterTurns: 2,
            child: IconButton(
              icon: const Icon(Icons.logout),
              padding: const EdgeInsets.all(0),
              onPressed: () {
                context.read(authProvider.notifier).logout();
                context.router.popUntilRoot();
              },
            ),
          ),

          //Filter
          IconButton(
            icon: const Icon(Icons.filter_list_rounded, size: 25),
            padding: const EdgeInsets.all(0),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

