import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/presentation/features/songs/list/providers/providers.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/utils/utils.dart';

class SongLeading extends ConsumerWidget {
  const SongLeading({
    super.key,
    required this.songModel
  });

  final SongModel songModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = Theme.of(context);
    final prov = ref.read(songsListProvider);
    final reactiveProv = ref.watch(songsListProvider);

    return CupertinoCheckbox(
      checkColor: theme.colorScheme.onPrimary,
      activeColor: theme.colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.kRoundedBorderRadius)
      ),
      value: reactiveProv.selectedItems.contains(songModel.id), 
      onChanged: (value){
        prov.selectItem(
          id: songModel.id
        );
      },
    );
  }
}