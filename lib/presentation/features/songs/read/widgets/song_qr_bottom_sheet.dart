import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/songs/read/models/share_song_model.dart';
import '/utils/constants/sizes.dart';

class SongQrBottomSheet extends StatelessWidget {
  const SongQrBottomSheet({
    super.key,
    required this.songModel
  });

  final ShareSongModel songModel;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final lang = Lang.of(context);

     return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(Sizes.kBorderRadius),
            topRight: Radius.circular(Sizes.kBorderRadius)
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      CupertinoIcons.xmark_circle_fill,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                ],
              )
            ),
            const SizedBox(
              height: Sizes.kPadding,
            ),
            Text(
              lang.shareSongs_title(songModel.title),
              textAlign: TextAlign.center,
              style: theme.textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
            const SizedBox(
              height: Sizes.kPadding * 2,
            ),
            Center(
              child: QrImageView(
                backgroundColor: theme.colorScheme.onBackground,
                data: songModel.toShareEncoded(),
                version: QrVersions.auto,
                size: 300.0,
              ),
            ),
            const SizedBox(
              height: Sizes.kPadding * 2,
            ),
          ],
        ),
      ),
    );
  }
}