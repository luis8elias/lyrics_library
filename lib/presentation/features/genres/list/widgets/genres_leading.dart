import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lyrics_library/config/lang/generated/l10n.dart';

import '/presentation/features/genres/list/providers/providers.dart';

class GenresLeading extends ConsumerWidget {
  const GenresLeading({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final reactiveProv = ref.watch(genresListProvider);
    final lang = Lang.of(context);
    final prov = ref.read(genresListProvider);
    final theme = Theme.of(context);

    try {
      
      if(reactiveProv.model == null){
        return const SizedBox.shrink();
      }

      if(reactiveProv.model!.isEmpty){
        return const SizedBox.shrink();
      }

      if(reactiveProv.isSelectGenreOpened){
        return TextButton(
          onPressed: () => prov.openCloseSelectGenre(), 
          child: Text(lang.actions_ok)
        );
      }

      return IconButton(
        onPressed: () => prov.openCloseSelectGenre(),
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