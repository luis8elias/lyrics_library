import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/presentation/features/songs/create/create_song_screen.dart';
import '/utils/constants/sizes.dart';

class CreateSongButton extends StatelessWidget {
  const CreateSongButton({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    
    return InkWell(
      borderRadius: BorderRadius.circular(Sizes.kRoundedBorderRadius),
      onTap: () => GoRouter.of(context).pushNamed(CreateSongScreen.routeName),
      child: Container(
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(Sizes.kRoundedBorderRadius)
        ),
        child: Icon(
          CupertinoIcons.add,
          color: theme.colorScheme.onPrimary,
          size: 15,
        ),
      ),
    );
  }
}