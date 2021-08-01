import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//Helpers
import '../../../helper/utils/constants.dart';
import '../../../helper/extensions/context_extensions.dart';

//Providers
import '../../../providers/all_providers.dart';

class UserProfileDetails extends HookWidget {
  const UserProfileDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProv = useProvider(authProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Full Name Label
        Text(
          'Full Name',
          style: context.bodyText1.copyWith(
              color: Constants.primaryColor,
              fontSize: 26,
              fontWeight: FontWeight.bold
          ),
        ),

        //Full Name
        Text(
          authProv.currentUserFullName,
          style: context.bodyText1.copyWith(
            color: Constants.textWhite80Color,
            fontSize: 18,
          ),
        ),

        const Spacer(),

        //Email Label
        Text(
          'Email',
          style: context.bodyText1.copyWith(
              color: Constants.primaryColor,
              fontSize: 26,
              fontWeight: FontWeight.bold
          ),
        ),

        //Email Data
        Text(
          authProv.currentUserEmail,
          style: context.bodyText1.copyWith(
            color: Constants.textWhite80Color,
            fontSize: 18,
          ),
        ),

        const Spacer(),

        //Address Label
        Text(
          'Address',
          style: context.bodyText1.copyWith(
              color: Constants.primaryColor,
              fontSize: 26,
              fontWeight: FontWeight.bold
          ),
        ),

        //Address Data
        Text(
          authProv.currentUserAddress,
          style: context.bodyText1.copyWith(
            color: Constants.textWhite80Color,
            fontSize: 18,
          ),
        ),

        const Spacer(),

        //Contact Label
        Text(
          'Contact',
          style: context.bodyText1.copyWith(
              color: Constants.primaryColor,
              fontSize: 26,
              fontWeight: FontWeight.bold
          ),
        ),

        //Contact Data
        Text(
          authProv.currentUserContact,
          style: context.bodyText1.copyWith(
            color: Constants.textWhite80Color,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
