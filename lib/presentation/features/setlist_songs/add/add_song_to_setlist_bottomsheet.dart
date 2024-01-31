import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lyrics_library/presentation/features/setlist_songs/add/widgets/add_to_setlist_btn.dart';
import 'package:lyrics_library/presentation/features/setlist_songs/list/provider/providers.dart';
import 'package:lyrics_library/presentation/features/setlists/list/providers/providers.dart';
import 'package:lyrics_library/utils/utils.dart';
import '/presentation/features/setlist_songs/list/widgets/setlist_song_subtitle.dart';
import '/presentation/features/songs/list/widgets/new_page_progress_indicator.dart';
import '/presentation/features/songs/list/widgets/no_items_found.dart';
import '/presentation/features/songs/list/widgets/song_title.dart';
import '/presentation/widgets/loaders.dart';
import '/presentation/widgets/search_input.dart';
import '/utils/constants/sizes.dart';
import 'models/song_model_from_add_song_to_setlist_model.dart';
import 'provider/providers.dart';

class AddSongToSetlistBottomsheet extends ConsumerStatefulWidget {
  const AddSongToSetlistBottomsheet({
    super.key,
    required this.setlistId
  });

  final Guid setlistId;

  @override
  ConsumerState<AddSongToSetlistBottomsheet> createState() => _AddSongToSetlistBottomsheetState();
}

class _AddSongToSetlistBottomsheetState extends ConsumerState<AddSongToSetlistBottomsheet> {

  @override
  void initState() {
    final prov = ref.read(addSetlistSongsListProvider);
    prov.setSetlistId(setlistId: widget.setlistId);
    prov.addListenerToPagingController();
    super.initState();
  }
@override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final height = MediaQuery.sizeOf(context).height;
    final prov = ref.read(addSetlistSongsListProvider);
    final reactiveProv = ref.watch(addSetlistSongsListProvider);
    final bottomPadding = Platform.isIOS ? 42.0 : 70.0;
    
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        width: double.infinity,
        height: height,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Sizes.kBorderRadius),
              topRight: Radius.circular(Sizes.kBorderRadius)
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: kToolbarHeight,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: Sizes.kPadding * 0.3,
                      ),
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 40,
                              width: 60,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 5
                              ),
                              child: Text(
                                'Add song to setlist',
                                style: theme.textTheme.titleSmall,
                              ),
                            ),
                            IconButton(
                              onPressed: ()=> Navigator.of(context).pop(),
                              icon:  Icon(
                                CupertinoIcons.xmark_circle_fill,
                                color: theme.colorScheme.onBackground,
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                    const SizedBox(
                      height: Sizes.kPadding,
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.kPadding
                        ),
                        child: SearchInput(
                          onChangeSearch: (query) => {
                           
                          },
                          autoFocus: false,
                        ),
                      ),
                      const SizedBox(
                        height: Sizes.kPadding,
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () => Future.sync(
                            () => prov.songsController.refresh(),
                          ),
                          child: PagedListView<int, SongModelFromAddSongToSetlistModel>(
                            pagingController: reactiveProv.songsController,
                            builderDelegate: PagedChildBuilderDelegate<SongModelFromAddSongToSetlistModel>(
                              firstPageProgressIndicatorBuilder: (context) => LoadingScreen(
                                backgroundColor: theme.appBarTheme.surfaceTintColor,
                              ),
                              noItemsFoundIndicatorBuilder: (conetxt)=> const NoSongsFound(),
                              newPageProgressIndicatorBuilder: (context) => const NewPageProgressIndicator(),
                              itemBuilder: (context, song, index) {
                                return Padding(
                                padding: EdgeInsets.only(
                                  bottom: (index+1) == prov.totalSongs ? bottomPadding : 0.0,
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.only(
                                    left: Sizes.kPadding,
                                    right: Sizes.kPadding * 0.5,
                                    top: Sizes.kPadding * 0.2,
                                    bottom: Sizes.kPadding * 0.2
                                  ),
                                  title: SongTitle(title: song.title),
                                  subtitle: song.genreName != null ? 
                                  SetlistSongSubtitle(genreName: song.genreName!)
                                  : null,
                                  trailing: Builder(
                                    builder: (context) {
                                      return AddToSetlistBtn(
                                        song: song,
                                        onActionEnd: (response) {
                                          if(response.isFailed){
                                            SnackbarHelper.show(
                                              context,
                                              response.message!
                                            );
                                          }
                                          SnackbarHelper.show(
                                            context,
                                            response.message!
                                          );
                                          prov.removeSong(response.model!.songId);
                                          ref.read(setlistSongsListProvider).addSong(response.model!);
                                          ref.read(setlistsListProvider).incrementSetlistTotalSongsCount(
                                            prov.getSetlistId,
                                          );
                                        },
                                      );
                                    }
                                  )
                                ));
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: Sizes.kPadding,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: Sizes.kPadding * 1.5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}