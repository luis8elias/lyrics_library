import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/app/providers/providers.dart';
import '/config/lang/generated/l10n.dart';
import '/utils/constants/sizes.dart';

class ProfileMenuTile extends ConsumerWidget {
  const ProfileMenuTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = Theme.of(context);
    final sessionProv = ref.read(appProvider);
    final lang = Lang.of(context);

    return Material(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(Sizes.kBorderRadius) ,
        topRight: Radius.circular(Sizes.kBorderRadius),
        bottomLeft: Radius.circular(Sizes.kBorderRadius),
        bottomRight: Radius.circular(Sizes.kBorderRadius),
      ),
      color: theme.colorScheme.inverseSurface.withOpacity(0.6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5
        ),
        visualDensity: const VisualDensity(vertical: 3),
        shape: const  RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Sizes.kBorderRadius),
            topRight: Radius.circular(Sizes.kBorderRadius) ,
            bottomLeft: Radius.circular(Sizes.kBorderRadius),
            bottomRight: Radius.circular(Sizes.kBorderRadius),
          ),
        ),
        minLeadingWidth: 25,
        onTap: (){},
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary,
          radius: 20,
          child: Text(
            sessionProv.userSession!.getDisplayNameInitials,
            style: const TextStyle(
              fontSize: 15
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sessionProv.userSession!.displayName.isEmpty ? lang.moreOptionsScreen_noName : sessionProv.userSession!.displayName,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: theme.colorScheme.onBackground,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              sessionProv.userSession!.email.isEmpty ? lang.moreOptionsScreen_noEmail : sessionProv.userSession!.email,
              style: theme.textTheme.bodyMedium!.copyWith(
                fontSize: 10,
                color: theme.hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}