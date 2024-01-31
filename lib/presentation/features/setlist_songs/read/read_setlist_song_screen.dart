import 'dart:io';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lyrics_library/presentation/features/setlist_songs/read/providers/read_setlist_song_provider.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/setlist_songs/list/model/setlist_song_model.dart';
import '/presentation/features/setlists/shared/models/setlists_route_params_model.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/providers.dart';
import '/utils/constants/sizes.dart';

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

  @override
  void initState() {
    final prov = ref.read(readSetlistSongProvider);
    prov.initializeProvider(
      initialIndex: widget.selectedIndex,
      setlistSongs: widget.setlistSongs
    );
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      prov.loadData();
    });
  }
@override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final lang = Lang.of(context);
    final reactiveProv = ref.watch(readSetlistSongProvider);
    final prov = ref.read(readSetlistSongProvider);
    final extra = GoRouter.of(context).routerDelegate.currentConfiguration.extra as SetlistRouteParamsModel;

    final setlist = extra.setlistModel.allowToRemoveBool 
    ? extra.setlistModel.name 
    : lang.app_favorites;
    
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
            FadeIn(
              key: Key(widget.setlistSongs[reactiveProv.selectedIndex].title),
              child: Text(
                widget.setlistSongs[reactiveProv.selectedIndex].title,
                style: theme.textTheme.titleSmall,
                overflow: TextOverflow.ellipsis,
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
                              color: theme.colorScheme.onSurface
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Sizes.kPadding + Sizes.kBottomNavHeight,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,left: 0,right: 0,
            child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: Sizes.kBottomNavHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.inverseSurface.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: (){
                          prov.changeSong(ChangeSongOptions.decrease);
                        },
                        icon: const Icon(CupertinoIcons.arrow_left)
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
                      IconButton(
                        onPressed: (){
                          prov.changeSong(ChangeSongOptions.increase);
                        },
                        icon: const Icon(CupertinoIcons.arrow_right)
                      ),
                    ],
                  )
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}