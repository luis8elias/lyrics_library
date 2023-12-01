import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/songs/delete/delete_song_button.dart';
import '/presentation/features/songs/list/providers/providers.dart';
import '/presentation/features/songs/list/widgets/create_song_button.dart';
import '/presentation/features/songs/list/widgets/new_page_progress_indicator.dart';
import '/presentation/features/songs/list/widgets/no_items_found.dart';
import '/presentation/features/songs/list/widgets/song_leading.dart';
import '/presentation/features/songs/list/widgets/song_subtitle.dart';
import '/presentation/features/songs/list/widgets/song_title.dart';
import '/presentation/features/songs/list/widgets/songs_appbar_leading.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/presentation/presentation.dart';
import '/presentation/widgets/custom_bottom_nav_bar.dart';
import '/presentation/widgets/transparent_appbar.dart';
import '/utils/utils.dart';

class SongsListScreen extends ConsumerStatefulWidget {
  const SongsListScreen({super.key});

  static const String routeName = '/songs';

  @override
  ConsumerState<SongsListScreen> createState() => _SongsListScreenState();
}

class _SongsListScreenState extends ConsumerState<SongsListScreen> {

  @override
  void initState() {
    ref.read(songsListProvider).addListenerToPagingController();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    final lang = Lang.of(context);
    final prov = ref.read(songsListProvider);
    final reactiveProv = ref.watch(songsListProvider);
    final bottomPadding = Platform.isIOS ? 50.0 : 70.0;
    final topPadding = Platform.isIOS ? Sizes.kAppBarSize * 0.45 : Sizes.kAppBarSize * 0.70;

    return  Scaffold(
      body: CustomBottomNavBar(
        selectedIndex: 1,
        appBar: CustomAppBar(
          actions: const [
            Padding(
              padding: EdgeInsets.only(
                right: Sizes.kPadding/2
              ),
              child: CreateSongButton()
            ),
          ],
          leading: const SongsAppBarLeading(),
          title: lang.songsListScreen_title
        ),
        buttonBottomRow: prov.isSelectItemOpened 
        ? FadeInUp(
          duration: const Duration(milliseconds: 100),
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.kPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: reactiveProv.isOneItemSelected 
                  ? ()=> GoRouter.of(context).go(
                    context.namedLocation(
                      EditSongScreen.routeName,
                      pathParameters: {
                        'sid': prov.getFirstSongSelected.id.toString()
                      },
                    ),
                    extra: prov.getFirstSongSelected
                  )
                  : null, 
                  child: Text(lang.actions_edit)
                ),
                DeleteSongButton(
                  enabled: reactiveProv.selectedItems.isNotEmpty
                ),
              ],
            ),
          ),
        )
        : null,
        body: RefreshIndicator(
          displacement: Platform.isIOS ? Sizes.kAppBarSize : topPadding,
          onRefresh: () => Future.sync(
            () => prov.songsController.refresh(),
          ),
          child: PagedListView<int, SongModel>.separated(
            separatorBuilder: (context, index) => const Divider(thickness: 0.09 ),
            pagingController: reactiveProv.songsController,
            builderDelegate: PagedChildBuilderDelegate<SongModel>(
              firstPageProgressIndicatorBuilder: (context) => const LoadingScreen(),
              noItemsFoundIndicatorBuilder: (conetxt)=> const NoSongsFound(),
              newPageProgressIndicatorBuilder: (context) => const NewPageProgressIndicator(),
              itemBuilder: (context, song, index) {
                return Padding(
                padding: EdgeInsets.only(
                  bottom: (index+1) == prov.totalSongs ? bottomPadding : 0.0,
                  top: index == 0 ? topPadding : 0,
                ),
                child: ListTile(
                  onTap: (){},
                  onLongPress: prov.isSelectItemOpened 
                  ? null 
                  : ()=> prov.openCloseSelectItem(
                    id: song.id
                  ),
                  leading: reactiveProv.isSelectItemOpened ? FadeInLeft(
                    duration: const Duration(milliseconds: 100),
                    child: SongLeading(songModel: song),
                  ) : null,
                  title: SongTitle(title: song.title),
                  subtitle: SongSubtitle(songModel: song)
                ));
              },
            ),
          ),
        ),
      ),
    );
  }
}