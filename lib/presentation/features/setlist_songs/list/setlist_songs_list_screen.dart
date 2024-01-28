import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/genres/delete/delete_genre_button.dart';
import '/presentation/features/setlist_songs/list/widgets/setlist_song_subtitle.dart';
import '/presentation/features/setlist_songs/list/widgets/setlist_song_title.dart';
import '/presentation/features/setlists/shared/models/setlist_model.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/custom_bottom_nav_bar.dart';
import '/presentation/widgets/providers.dart';
import '/presentation/widgets/search_input.dart';
import '/utils/constants/sizes.dart';
import 'provider/providers.dart';

class SetlistSongsListScreen extends ConsumerStatefulWidget {
  const SetlistSongsListScreen({
    super.key,
    required this.setlistModel
  });

  final SetlistModel setlistModel;

  static const String routeName = 'setlist-songs';
  static const String routePath = ':sid';

  @override
  ConsumerState<SetlistSongsListScreen> createState() => _ReadSetlistScreenState();
}

class _ReadSetlistScreenState extends ConsumerState<SetlistSongsListScreen> {

  bool showSearchInput = false;

  @override
  void initState() {
    final prov = ref.read(setlistSongsListProvider);
    prov.setSetlistId(setlistId: widget.setlistModel.id);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      prov.loadData();
    });
  }


@override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final lang = Lang.of(context);
    final prov = ref.read(setlistSongsListProvider);
    final reactiveProv = ref.watch(setlistSongsListProvider);
    
    return Scaffold(
      body: CustomBottomNavBar(
        selectedIndex: 0,
        hideBottomNavBar: true,
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
                    prov.updateQuery('');
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
                onPressed: (){}
              ),
            ),
          ], 
          leading: reactiveProv.isSelectItemOpened ?
          TextButton(
            onPressed: () => prov.openCloseSelectItem(), 
            child: Text(lang.actions_ok)
          ):
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BackButtonWidget(
              onPressed: () {
                GoRouter.of(context).pop();
              },
            ),
          ),
          title: showSearchInput ? 
            SearchInput(
              onChangeSearch: (query) => prov.updateQuery(query),
            )
            : Text(
            widget.setlistModel.allowToRemoveBool 
            ? widget.setlistModel.name 
            : lang.app_favorites,
            style: theme.textTheme.titleSmall,
            overflow: TextOverflow.ellipsis,
          ),
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
                const SizedBox.shrink(),
                DeleteGenreButton(
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
              //color: Colors.red,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          reactiveProv.isSelectItemOpened 
                          ? '${reactiveProv.selectedItems.length} ${lang.app_selectedItems}'
                          : reactiveProv.isModelInitialized ?
                          '${reactiveProv.model!.length  } ${lang.app_items}'
                          : '0 ${lang.app_items}',
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 15,
                          margin: const EdgeInsets.only(
                            top: 4
                          ),
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
                                lang.app_setlist,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onBackground,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 2,
                        child: SizedBox.shrink(),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: FetchProviderBuilder(
                provider: setlistSongsListProvider,
                builder: (songs) => RefreshIndicator(
                  onRefresh: () => Future.sync(
                    () => prov.refreshSetlistSongs(),
                  ),
                  child: ReorderableListView.builder(
                    itemCount: songs!.length,
                    buildDefaultDragHandles: true,
                    itemBuilder: (context, index) => Column(
                      key: Key(songs[index].id.toString()),
                      children: [
                        ListTile(
                          onTap: (){},
                          onLongPress: prov.isSelectItemOpened 
                          ? null 
                          : ()=> prov.openCloseSelectItem(
                            id: songs[index].id
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: Sizes.kPadding,
                            vertical: Sizes.kPadding * 0.3
                          ),
                          title: SetlistSongTitle(title: songs[index].title),
                          subtitle: songs[index].genreName != null ?
                          SetlistSongSubtitle(genreName: songs[index].genreName!): null,
                          leading: reactiveProv.isSelectItemOpened ? FadeInLeft(
                            duration: const Duration(milliseconds: 100),
                            child: CupertinoCheckbox(
                              checkColor: theme.colorScheme.onPrimary,
                              activeColor: theme.colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(Sizes.kRoundedBorderRadius)
                              ),
                              value: reactiveProv.selectedItems.contains(songs[index].id), 
                              onChanged: (value){
                                prov.selectItem(
                                  id: songs[index].id
                                );
                              },
                            ),
                          ) : null,
                          trailing:  FadeInRight(
                            duration: const Duration(milliseconds: 100),
                            child: ReorderableDragStartListener(
                              index: index,
                              child: const Icon(Icons.drag_handle),
                            ),
                          ),
                        ),
                        if(index + 1 != songs.length )
                        Container(
                          height: 0.5,
                          color : theme.colorScheme.outline
                        ),
                      ],
                    ),
                    onReorder: (oldIndex, newIndex) {
                      prov.reorderSongs(oldIndex, newIndex);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}