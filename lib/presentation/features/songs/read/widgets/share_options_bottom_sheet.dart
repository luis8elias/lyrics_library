import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lyrics_library/presentation/features/songs/read/widgets/song_qr_bottom_sheet.dart';
import 'package:share_plus/share_plus.dart';

import '/config/config.dart';
import '/presentation/features/more/menu/widgets/menu_option_widget.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/utils/constants/sizes.dart';

class ShareOptionsBottomSheet extends StatelessWidget {
  const ShareOptionsBottomSheet({
    super.key,
    required this.songModel
  });

  final SongModel songModel;

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
                    icon:  Icon(
                      CupertinoIcons.xmark_circle_fill,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                ],
              )
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
              height: Sizes.kPadding,
            ),
            const SizedBox(
              height: Sizes.kPadding * 0.5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.kPadding
              ),
              child: MenuOptionWidget(
                onPressed: (){
                  Share.share(songModel.toShareStr().toString());
                },
                title: lang.shareSongs_text,
                icon: CupertinoIcons.doc_on_doc,
                menuRoundedOption: MenuRoundedOption.top,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.kPadding
              ),
              child: MenuOptionDivider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.kPadding
              ),
              child: MenuOptionWidget(
                onPressed: (){
                  showModalBottomSheet(
                    enableDrag: false,
                    elevation: 0.5,
                    backgroundColor: Colors.transparent,
                    context: context, 
                    builder: (context) => SongQrBottomSheet(
                      songModel: songModel,
                    )
                  );
                },
                title: lang.shareSongs_qr,
                icon: CupertinoIcons.qrcode,
                menuRoundedOption: MenuRoundedOption.bottom,
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