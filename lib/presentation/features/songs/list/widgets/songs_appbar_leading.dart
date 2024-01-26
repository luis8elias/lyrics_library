import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/songs/list/providers/providers.dart';

class SongsAppBarLeading extends ConsumerWidget {
  const SongsAppBarLeading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final reactiveProv = ref.watch(songsListProvider);
    final lang = Lang.of(context);
    final prov = ref.read(songsListProvider);
    final theme = Theme.of(context);

    try {
      
      if(reactiveProv.totalSongs == 0){
        return const SizedBox.shrink();
      }

      if(reactiveProv.isSelectItemOpened){
        return TextButton(
          onPressed: () => prov.openCloseSelectItem(), 
          child: Text(lang.actions_ok)
        );
      }

      return IconButton(
        iconSize: 25,
        onPressed: () => prov.openCloseSelectItem(),
        icon: Icon(
          CupertinoIcons.check_mark_circled,
          color: theme.colorScheme.primary,
        ),
      );

    } catch (e) {
      return  const SizedBox.shrink();
    }
  }
}