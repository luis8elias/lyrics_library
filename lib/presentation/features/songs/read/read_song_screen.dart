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
        actions: const[], 
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BackButtonWidget(
            onPressed: () {
              //prov.resetFormModel();
              GoRouter.of(context).pop();
            },
          ),
        ),
        title: Text(
          songModel.title,
          style: theme.textTheme.titleSmall,
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: Sizes.kPadding * 1.5,
                  right: Sizes.kPadding * 1.5,
                  bottom: Sizes.kPadding * 1.5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: Sizes.kPadding,
                    ),
                    Text(
                      songModel.lyric,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface
                      ),
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