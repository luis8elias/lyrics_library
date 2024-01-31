import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/utils/utils.dart';

//import '/config/lang/generated/l10n.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/presentation/widgets/buttons.dart';

class ReadSongScreen extends ConsumerWidget {
  const ReadSongScreen({
    super.key,
    required this.songModel
  });

  final SongModel songModel;

  static const String routeName = 'read-song';
  static const String routePath = ':sid';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final theme = Theme.of(context);
    //final lang = Lang.of(context);
    //final prov = ref.read(editGenreProvider);
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            splashRadius: 10,
            onPressed: (){},
            icon: Icon(
              Platform.isIOS ? CupertinoIcons.share : Icons.share_outlined ,
              color: theme.colorScheme.primary,
            ),
          ),
        ], 
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BackButtonWidget(
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
        ),
        title: Column(
          children: [
            Text(
              songModel.title,
              style: theme.textTheme.titleSmall,
              overflow: TextOverflow.ellipsis,
            ),
            if(songModel.genreModel != null)
            const SizedBox(
              height: 4,
            ),
            if(songModel.genreModel != null)
            Container(
              height: 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: theme.colorScheme.primary.withOpacity(0.3),
                border: Border.all(
                  color: theme.colorScheme.primary
                ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: Platform.isIOS ? 0: 2
                  ),
                  child: Text(
                    songModel.genreModel?.name ?? '',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onBackground,
                      fontWeight: FontWeight.bold,
                      fontSize: 8,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: Sizes.kPadding ,
                  right: Sizes.kPadding ,
                  bottom: Sizes.kPadding ,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: Sizes.kPadding,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        songModel.lyric,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: theme.colorScheme.onSurface
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: Sizes.kPadding,
                    ),
                  ],
                ),
              ),
            ), 
          ),
        ],
      ),
    );
  }
}