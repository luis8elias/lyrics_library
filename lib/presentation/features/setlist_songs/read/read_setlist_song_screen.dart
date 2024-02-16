import 'dart:io';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:ticker_text/ticker_text.dart';

import '/app/providers/providers.dart';
import '/config/lang/generated/l10n.dart';
import '/presentation/features/setlist_songs/list/model/setlist_song_model.dart';
import '/presentation/features/setlist_songs/read/providers/read_setlist_song_provider.dart';
import '/presentation/features/setlists/shared/models/setlists_route_params_model.dart';
import '/presentation/features/songs/read/models/share_song_model.dart';
import '/presentation/features/songs/read/widgets/share_options_bottom_sheet.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/change_read_song_font_size_bottomsheet.dart';
import '/presentation/widgets/providers.dart';
import '/presentation/widgets/scroll_to_hide.dart';
import '/utils/utils.dart';
import 'providers/providers.dart';

class ReadSetlistSongScreen extends ConsumerStatefulWidget {
  const ReadSetlistSongScreen({
    super.key,
    required this.selectedIndex,
    required this.setlistSongs
  });

  final List<SetlistSongModel> setlistSongs;
  final int selectedIndex;

  static const String routeName = 'read-setlist-song';
  static const String routePath = ':selectedIndex';

  @override
  ConsumerState<ReadSetlistSongScreen> createState() => _ReadSetlistSongScreenState();
}

class _ReadSetlistSongScreenState extends ConsumerState<ReadSetlistSongScreen> {

  late ScrollController _scrollBottomBarController;

  final debouncer = DebouncerObj(const Duration(seconds: 50));

  void incrementSongViewCont(){
    debouncer.run(() { 
      ref.read(readSetlistSongProvider).incrementSongViewCont(
        songId: widget.setlistSongs[ref.read(readSetlistSongProvider).selectedIndex].songId
      );
    });
  }
  

  @override
  void initState() {
    _scrollBottomBarController = ScrollController();
    final prov = ref.read(readSetlistSongProvider);
    prov.initializeProvider(
      initialIndex: widget.selectedIndex,
      setlistSongs: widget.setlistSongs
    );
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      prov.loadData();
    });
    incrementSongViewCont();
  }

  @override
  void dispose() {
    _scrollBottomBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final lang = Lang.of(context);
    final reactiveProv = ref.watch(readSetlistSongProvider);
    final prov = ref.read(readSetlistSongProvider);
    final appProv = ref.read(appProvider);
    final extra = GoRouter.of(context).routerDelegate.currentConfiguration.extra as SetlistRouteParamsModel;

    final setlist = extra.setlistModel.allowToRemoveBool 
    ? extra.setlistModel.name 
    : lang.app_favorites;
    
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
                      songModel: ShareSongModel.fromSetlistSongModel(
                        widget.setlistSongs[prov.selectedIndex],
                        prov.model
                      ),
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
                      defaultFontSize: prov.fontSize,
                      onFontSizeChanged: (newFontSize){
                        prov.changeFontSize(newFontSize);
                      },
                    )
                  );
                  final resp = await prov.saveFontSize();
                  if(resp.isFailed){
                    showErrorAlert(resp.message!);
                  }else{
                    appProv.changeFontSize(prov.fontSize);
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
          children: [
            TickerText(
              scrollDirection: Axis.horizontal,
              speed: 20,
              startPauseDuration: const Duration(seconds: 5),
              endPauseDuration: const Duration(seconds: 5),
              returnDuration: const Duration(seconds: 5),
              primaryCurve: Curves.linear,
              returnCurve: Curves.easeOut,
              child: FadeIn(
                key: Key(widget.setlistSongs[reactiveProv.selectedIndex].title),
                child: Text(
                  widget.setlistSongs[reactiveProv.selectedIndex].title,
                  style: theme.textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            if(widget.setlistSongs[reactiveProv.selectedIndex].genreName != null)
            const SizedBox(
              height: 4,
            ),
            if(widget.setlistSongs[reactiveProv.selectedIndex].genreName != null)
            FadeIn(
              key: Key(widget.setlistSongs[reactiveProv.selectedIndex].genreName?? ''),
              child: Container(
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
                      widget.setlistSongs[reactiveProv.selectedIndex].genreName ?? '',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onBackground,
                        fontWeight: FontWeight.bold,
                        fontSize: 8,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              controller: _scrollBottomBarController,            
                child: Padding(
                padding: const EdgeInsets.only(
                  left: Sizes.kPadding ,
                  right: Sizes.kPadding ,
                  bottom: Sizes.kPadding ,
                ),
                child: FetchProviderBuilder(
                  provider: readSetlistSongProvider,
                  builder: (lyric) =>  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: Sizes.kPadding,
                      ),
                      FadeIn(
                        key: Key(lyric),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            lyric,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: theme.colorScheme.onSurface,
                              fontSize: reactiveProv.fontSize
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height:Sizes.kPadding,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,left: 0,right: 0,
            child: ScrollToHide(
              scrollController: _scrollBottomBarController,
              child: FadeIn(
                duration: const Duration(milliseconds: 250),
                child: ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      height: Sizes.kBottomNavHeight,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.inverseSurface.withOpacity(0.6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _BottomBtn(
                            onPressed: (){
                              debouncer.timer?.cancel();
                              prov.changeSong(ChangeSongOptions.decrease);
                              incrementSongViewCont();
                            },
                            iconData: CupertinoIcons.arrow_left,
                            text: lang.actions_prev,
                          ),
                          SizedBox(
                            width: 170,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${reactiveProv.selectedIndex + 1}/${widget.setlistSongs.length}',
                                   style: theme.textTheme.labelSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.primary,
                                    fontSize: 14
                                   )
                                ),
                                Text(
                                  setlist,
                                  style: theme.textTheme.labelSmall,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                          _BottomBtn(
                            onPressed: (){
                              debouncer.timer?.cancel();
                              prov.changeSong(ChangeSongOptions.increase);
                              incrementSongViewCont();
                            },
                            iconData: CupertinoIcons.arrow_right,
                            text: lang.actions_next,
                          ),
                        ],
                      )
                    )
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
class _BottomBtn extends StatelessWidget {
  const _BottomBtn({
    required this.iconData,
    required this.onPressed,
    required this.text
  });

  final IconData iconData;
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            size: 15,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 10
            ),
          ),
        ],
      )
    );
  }
}