import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lyrics_library/presentation/features/songs/shared/model/song_model.dart';
import 'package:lyrics_library/utils/constants/sizes.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SongQrBottomSheet extends StatelessWidget {
  const SongQrBottomSheet({
    super.key,
    required this.songModel
  });

  final SongModel songModel;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

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
                    icon:  Icon(
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
              'Share ${songModel.title}',
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
                dataModuleStyle: QrDataModuleStyle(
                  color: theme.colorScheme.background,
                  dataModuleShape: QrDataModuleShape.square
                ),
                data: jsonEncode(songModel.toJson())  ,
                version: QrVersions.auto,
                size: 250.0,
              ),
            ), 
            const SizedBox(
              height: Sizes.kPadding * 3,
            ),
          ],
        ),
      ),
    );
  }
}