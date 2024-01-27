import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/presentation/features/songs/list/providers/providers.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/presentation/features/songs/shared/widgets/genre_circle.dart';

class SongSubtitle extends ConsumerWidget {
  const SongSubtitle({
    super.key,
    required this.songModel
  });

  final SongModel songModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final reactiveProv = ref.watch(songsListProvider);
    const duration = Duration(milliseconds: 100);

    if(reactiveProv.isSelectItemOpened){
      return FadeInLeft(
        duration: duration,
        child: _SongSubtitle(songModel: songModel),
      );
    }

    return FadeInRight(
      duration: duration,
      child: _SongSubtitle(songModel: songModel),
    );
  }
}



class _SongSubtitle extends StatelessWidget {
  const _SongSubtitle({
    required this.songModel
  });

  final SongModel songModel;

  @override
  Widget build(BuildContext context) {

    //final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          if(songModel.genreModel != null)
          GenreCricle(
            genreName: songModel.genreModel!.name,
          ),
        ],
      ),
    );
  }
}