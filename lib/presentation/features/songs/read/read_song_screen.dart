import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:ticker_text/ticker_text.dart';

import '/app/providers/providers.dart';
import '/presentation/features/songs/read/models/share_song_model.dart';
import '/presentation/features/songs/read/providers/providers.dart';
import '/presentation/features/songs/read/widgets/share_options_bottom_sheet.dart';
import '/presentation/widgets/change_read_song_font_size_bottomsheet.dart';
import '/presentation/widgets/providers.dart';
import '/utils/utils.dart';

//import '/config/lang/generated/l10n.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/presentation/widgets/buttons.dart';

class ReadSongScreen extends ConsumerStatefulWidget {
  const ReadSongScreen({
    super.key,
    required this.songModel
  });

  final SongModel songModel;

  static const String routeName = 'read-song';
  static const String routePath = ':sid';

  @override
  ConsumerState<ReadSongScreen> createState() => _ReadSongScreenState();
}

class _ReadSongScreenState extends ConsumerState<ReadSongScreen> {

  final debouncer = DebouncerObj(const Duration(seconds: 50));
  

  @override
  void initState(){
    super.initState();
    debouncer.run(() { 
      ref.read(readSongProvider).incrementSongViewCont(
        songId: widget.songModel.id
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    
    final theme = Theme.of(context);
    //final lang = Lang.of(context);
    final prov = ref.read(readSongProvider);
    final appProv = ref.read(appProvider); 
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          PullDownButton(
            routeTheme: PullDownMenuRouteTheme(
              backgroundColor: theme.appBarTheme.backgroundColor,
            ),
            itemBuilder: (context) => [
              PullDownMenuItem(
                title: 'Share',
                subtitle: 'Share with yours friends',
                onTap: () {
                  showModalBottomSheet(
                    enableDrag: false,
                    elevation: 0.5,
                    context: context, 
                    builder: (context) => ShareOptionsBottomSheet(
                      songModel: ShareSongModel.fromSongModel(widget.songModel),
                    )
                  );
                },
                icon: Platform.isIOS ? CupertinoIcons.share : Icons.share_outlined,
              ),
              PullDownMenuItem(
                title: 'Font size',
                subtitle: 'Change lyrics font size',
                onTap: () async{
                  void showErrorAlert(String message){
                    SnackbarHelper.show(context: context, message: message);
                  }
                  await showModalBottomSheet(
                    enableDrag: false,
                    elevation: 0.5,
                    context: context, 
                    builder: (context) => ChangeReadSongFontSizeBottomSheet(
                      defaultFontSize: prov.model,
                      onFontSizeChanged: (newFontSize){
                        prov.setNewFontSize(newFontSize);
                      },
                    )
                  );
                  final resp = await prov.saveFontSize();
                  if(resp.isFailed){
                    showErrorAlert(resp.message!);
                  }else{
                    appProv.changeFontSize(prov.model);
                  }
                },
                icon: CupertinoIcons.textformat_size,
              ),
            ],
            buttonBuilder: (context, showMenu) => IconButton(
              splashRadius: 10,
              onPressed: showMenu,
              icon: Icon(
                Platform.isIOS ? CupertinoIcons.ellipsis_circle : Icons.more_vert,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ], 
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BackButtonWidget(
            onPressed: () {
              debouncer.timer?.cancel();
              GoRouter.of(context).pop();
            },
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: TickerText(
                scrollDirection: Axis.horizontal,
                speed: 20,
                startPauseDuration: const Duration(seconds: 5),
                endPauseDuration: const Duration(seconds: 5),
                returnDuration: const Duration(seconds: 5),
                primaryCurve: Curves.linear,
                returnCurve: Curves.easeOut,
                child: Text(
                  widget.songModel.title,
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ),
            // Text(
            //   songModel.title,
            //   style: theme.textTheme.titleSmall,
            //   overflow: TextOverflow.ellipsis,
            // ),
            if(widget.songModel.genreModel != null)
            const SizedBox(
              height: 4,
            ),
            if(widget.songModel.genreModel != null)
            Container(
              height: 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: theme.colorScheme.tertiary.withOpacity(0.3),
                border: Border.all(
                  color: theme.colorScheme.tertiary
                ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: Platform.isIOS ? 0: 2
                  ),
                  child: Text(
                    widget.songModel.genreModel?.name ?? '',
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
            child: FetchProviderBuilder(
              provider: readSongProvider,
              builder:(fontSize) =>  SingleChildScrollView(
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
                          widget.songModel.lyric,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: theme.colorScheme.onSurface,
                            fontSize: fontSize
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
          ),
        ],
      ),
    );
  }
}