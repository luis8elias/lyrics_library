import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/presentation/features/songs/list/providers/providers.dart';

class SongTitle extends ConsumerWidget {
  const SongTitle({
    super.key,
    required this.title
  });

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = Theme.of(context);
    final reactiveProv = ref.watch(songsListProvider);
    const duration = Duration(milliseconds: 100);

    if(reactiveProv.isSelectItemOpened){
      return FadeInLeft(
        duration: duration,
        child: Text(
          title,
          style: theme.textTheme.displaySmall,
        )
      );
    }

    return FadeInRight(
      duration: duration,
      child: Text(
        title,
        style: theme.textTheme.displaySmall,
      )
    );
  }
}


