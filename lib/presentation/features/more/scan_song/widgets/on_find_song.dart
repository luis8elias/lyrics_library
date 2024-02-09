import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/more/scan_song/models/scanned_song_model.dart';
import '/presentation/features/more/scan_song/providers/providers.dart';
import '/presentation/features/songs/shared/widgets/genre_circle.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/providers.dart';
import '/utils/utils.dart';

class OnFindSong extends ConsumerWidget {
  const OnFindSong({
    super.key,
    required this.scannedSongModel
  });

  final ScannedSongModel scannedSongModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = Theme.of(context);
    final lang = Lang.of(context);
    final prov = ref.read(scanSongProvider);
    final saveSongProv = ref.read(saveScannedSongProvider);

    return SendProviderListener(
      provider: saveScannedSongProvider,
      onError: (error) => SnackbarHelper.show(context: context, message: error),
      onSuccess: (model, message) {
        SnackbarHelper.show(context: context, message: message);
        prov.cancelDetectedSong();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.kPadding
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: Sizes.kPadding * 4,
            ),
            Expanded(
              child: FadeIn(
                child: Text(
                  lang.scanSong_foundSong,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
              ),
            ),
      
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  FadeIn(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          scannedSongModel.title,
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontSize: 36
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if(scannedSongModel.genreName != null)
                                GenreCricle(
                                  genreName: scannedSongModel.genreName!,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: Sizes.kPadding * 4,
                  ),

                  SendProviderBuilder(
                    provider: saveScannedSongProvider,
                    loaderWidget: BasicButton(
                      onPressed: null,
                      buildChild: (loadingChild) => loadingChild,
                      text: lang.actions_save
                    ),
                    child: BasicButton(
                      onPressed: (){
                        saveSongProv.saveSong(
                          scannedSongModel: scannedSongModel
                        );
                      },
                      text: lang.actions_save
                    ),
                  ),
                  
                  const SizedBox(
                    height: Sizes.kPadding,
                  ),
                  BasicButton(
                    color: theme.colorScheme.onBackground,
                    textColor: theme.colorScheme.background,
                    splashColor: theme.colorScheme.background,
                    onPressed: (){
                      prov.cancelDetectedSong();
                    }, 
                    text: lang.scanSong_scanAgain
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}