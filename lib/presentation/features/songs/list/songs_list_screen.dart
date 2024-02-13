import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/songs/delete/delete_song_button.dart';
import '/presentation/features/songs/list/providers/providers.dart';
import '/presentation/features/songs/list/widgets/add_to_setlist_bottom_sheet.dart';
import '/presentation/features/songs/list/widgets/like_song_button.dart';
import '/presentation/features/songs/list/widgets/new_page_progress_indicator.dart';
import '/presentation/features/songs/list/widgets/no_items_found.dart';
import '/presentation/features/songs/list/widgets/song_leading.dart';
import '/presentation/features/songs/list/widgets/song_subtitle.dart';
import '/presentation/features/songs/list/widgets/song_title.dart';
import '/presentation/features/songs/list/widgets/songs_appbar_leading.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/presentation/presentation.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/custom_bottom_nav_bar.dart';
import '/presentation/widgets/search_input.dart';
import '/utils/utils.dart';

class SongsListScreen extends ConsumerStatefulWidget {
  const SongsListScreen({super.key});

  static const String routeName = '/songs';

  @override
  ConsumerState<SongsListScreen> createState() => _SongsListScreenState();
}

class _SongsListScreenState extends ConsumerState<SongsListScreen> {

  bool showSearchInput = false;


  @override
  void initState() {
    ref.read(songsListProvider).addListenerToPagingController();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    final lang = Lang.of(context);
    final prov = ref.read(songsListProvider);
    final theme = Theme.of(context);
    final reactiveProv = ref.watch(songsListProvider);
    final bottomPadding = Platform.isIOS ? 42.0 : 70.0;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: CustomBottomNavBar(
          selectedIndex: 0,
          appBar: AppBar(
            centerTitle: true,
            actions: [
              if(!showSearchInput)
              IconButton(
                iconSize: 25,
                onPressed: (){
                  setState(() {
                    showSearchInput = true;
                  });
                },
                icon: Icon(
                  CupertinoIcons.search,
                  color: theme.colorScheme.onBackground,
                ),
              ),
              showSearchInput 
              ? FadeIn(
                child: TextButton(
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerRight,
                    textStyle: theme.textTheme.labelLarge,
                  ),
                  onPressed: (){
                    setState(() {
                      showSearchInput = false;
                    });
                    prov.updateFilters(
                      (filters) => filters.copyWith(
                        query: ''
                      ),
                    );
                  },
                  child: Text(
                    lang.actions_cancel
                  ),
                ),
              )
              : Padding(
                padding: const EdgeInsets.only(
                  right: Sizes.kPadding / 2,
                ),
                child: CreateButton(
                  onPressed: () => GoRouter.of(context).pushNamed(
                    CreateSongScreen.routeName
                  )
                )
              ),
            ],
            title: showSearchInput ? 
            SearchInput(
              onChangeSearch: (query) => prov.updateFilters((filters) {
                return filters.copyWith(
                  query: query
                );
              }),
            )
            : Text(
              lang.songsListScreen_title,
              style: theme.textTheme.titleSmall,
            ),
            leading: const SongsAppBarLeading(),
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
                  TextButton(
                    onPressed: reactiveProv.isOneItemSelected 
                    ? () async {
                      await showModalBottomSheet(
                        enableDrag: false,
                        context: context, 
                        isScrollControlled: true,
                        builder: (context) => AddToSetlistBottomSheet(
                          songModel: prov.getFirstSongSelected,
                        )
                      );
                    }
                    : null, 
                    child: Text(
                      lang.actions_addToSetlist
                    )
                  ),
                  DeleteSongButton(
                    enabled: reactiveProv.selectedItems.isNotEmpty
                  ),
                ],
              ),
            ),
          )
          : null,
          body: Column(
            children: [
              Container(
                height: 30,
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.kPadding
                ),
                width: double.infinity,
                color: theme.colorScheme.inverseSurface.withOpacity(0.5),
                child: Text(
                  reactiveProv.isSelectItemOpened 
                  ? '${reactiveProv.selectedItems.length} ${lang.app_selectedItems}'
                  : '${reactiveProv.totalSongs} ${lang.app_items}',
                  style: theme.textTheme.bodySmall,
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => Future.sync(
                    () => prov.songsController.refresh(),
                  ),
                  child: PagedListView<int, SongModel>.separated(
                    separatorBuilder: (context, index) => Container(
                      height: 0.5,
                      color : theme.colorScheme.outline
                    ),
                    pagingController: reactiveProv.songsController,
                    builderDelegate: PagedChildBuilderDelegate<SongModel>(
                      firstPageProgressIndicatorBuilder: (context) => const LoadingScreen(),
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
                          onTap: (){
                            if( !reactiveProv.isSelectItemOpened ){
                              GoRouter.of(context).go(
                                context.namedLocation(
                                  ReadSongScreen.routeName,
                                  pathParameters: {
                                    'sid': song.id.toString()
                                  },
                                ),
                                extra: song
                              );
                            }else{
                              prov.selectItem(
                                id: song.id
                              );
                            }
                          },
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
                          subtitle: song.genreModel != null ? SongSubtitle(songModel: song): null,
                          trailing: FadeInRight(
                            duration: const Duration(milliseconds: 100),
                            child: LikeSongButton(
                              songModel: song,
                              onActionEnd: (response) {
                                if(response.success){
                                  prov.toggleFavoriteSong(songModel: response.model!);
                                }else{
                                  SnackbarHelper.show(
                                    context: context,
                                    message: response.message!
                                  );
                                }
                              },
                            )
                          ),
                        ));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

