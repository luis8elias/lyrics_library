import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/presentation/features/setlists/read/provider/providers.dart';


class SetlistSongTitle extends ConsumerWidget {
  const SetlistSongTitle({
    super.key,
    required this.title
  });

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = Theme.of(context);
    final reactiveProv = ref.watch(readSetlistSongsProvider);
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


