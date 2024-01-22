import 'package:flutter/material.dart';
import 'package:lyrics_library/utils/constants/sizes.dart';

class ProfileMenuTile extends StatelessWidget {
  const ProfileMenuTile({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Material(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(Sizes.kBorderRadius) ,
        topRight: Radius.circular(Sizes.kBorderRadius),
        bottomLeft: Radius.circular(Sizes.kBorderRadius),
        bottomRight: Radius.circular(Sizes.kBorderRadius),
      ),
      color: theme.colorScheme.inverseSurface.withOpacity(0.5),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15
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
        leading: const CircleAvatar(
          backgroundImage: NetworkImage('https://s1.eestatic.com/2022/04/05/actualidad/662693884_223269247_1706x960.jpg'),
          radius: 30,
        ),
        title: Text(
          'Jorge Urquijo',
          style: theme.textTheme.bodyMedium!.copyWith(
            color: theme.colorScheme.onBackground,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}