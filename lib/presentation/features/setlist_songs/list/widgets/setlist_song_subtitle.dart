import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/presentation/features/setlist_songs/list/provider/providers.dart';
import '/presentation/features/songs/shared/widgets/genre_circle.dart';

class SetlistSongSubtitle extends ConsumerWidget {
  const SetlistSongSubtitle({
    super.key,
    required this.genreName
  });

  final String? genreName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final reactiveProv = ref.watch(setlistSongsListProvider);
    const duration = Duration(milliseconds: 100);

    if(reactiveProv.isSelectItemOpened){
      return FadeInLeft(
        duration: duration,
        child: _SongSubtitle(genreName: genreName),
      );
    }

    return FadeInRight(
      duration: duration,
      child: _SongSubtitle(genreName: genreName),
    );
  }
}



class _SongSubtitle extends StatelessWidget {
  const _SongSubtitle({
    required this.genreName
  });

  final String? genreName;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          if(genreName != null)
          GenreCricle(
            genreName: genreName!,
          ),
        ],
      ),
    );
  }
}