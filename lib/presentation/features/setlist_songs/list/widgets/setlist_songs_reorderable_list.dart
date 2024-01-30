import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import '/data/models/response_model.dart';
import '/presentation/features/setlist_songs/list/model/setlist_song_model.dart';
import '/presentation/features/setlist_songs/list/model/setlist_song_order_model.dart';
import '/presentation/features/setlist_songs/list/provider/providers.dart';
import '/presentation/features/setlist_songs/list/widgets/setlist_song_subtitle.dart';
import '/presentation/features/setlist_songs/list/widgets/setlist_song_title.dart';
import '/services/setlist_songs_service.dart';
import '/utils/constants/sizes.dart';

class SetlistSongsReorderableList extends ConsumerStatefulWidget {
  const SetlistSongsReorderableList({
    super.key,
    required this.songs,
    required this.onActionEnd
  });

  final List<SetlistSongModel> songs;
  final void Function(
    ResponseModel response,
    int oldIndex,
    int newIndex
  ) onActionEnd;

  @override
  ConsumerState<SetlistSongsReorderableList> createState() => _SetlistSongsReorderableListState();
}

class _SetlistSongsReorderableListState extends ConsumerState<SetlistSongsReorderableList> {

  //bool isLoading = false;
  final SetlistSongsService _setlistSongsService = Injector.appInstance.get();

  Future<ResponseModel> _orderSongs({
    required int oldIndex,
    required int newIndex,
    required List<SetlistSongModel> songs
  }) async{

    final  songsOrdered =  List.generate(songs.length, (index) {
        return SetlistSongOrderModel(
        indexOrder: (index + 1),
        setlistSongId: songs[index].id,
        title: songs[index].title
      );
    });
    final resp = await _setlistSongsService.orderSongs(
      songsOrdered: songsOrdered
    );
    return resp;
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final prov = ref.read(setlistSongsListProvider);
    final reactiveProv = ref.watch(setlistSongsListProvider);

    return ReorderableListView.builder(
      itemCount: widget.songs.length,
      buildDefaultDragHandles: true,
      itemBuilder: (context, index) => Column(
        key: Key(widget.songs[index].id.toString()),
        children: [
          ListTile(
            onTap: prov.isSelectItemOpened ? ()=> prov.selectItem(
              id: widget.songs[index].songId
            ) : null,
            onLongPress: prov.isSelectItemOpened 
            ? null
            : ()=> prov.openCloseSelectItem(
              id: widget.songs[index].songId
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: Sizes.kPadding,
              vertical: Sizes.kPadding * 0.3
            ),
            title: SetlistSongTitle(title: widget.songs[index].title),
            subtitle: widget.songs[index].genreName != null ?
            SetlistSongSubtitle(genreName: widget.songs[index].genreName!): null,
            leading: reactiveProv.isSelectItemOpened ? FadeInLeft(
              duration: const Duration(milliseconds: 100),
              child: CupertinoCheckbox(
                checkColor: theme.colorScheme.onPrimary,
                activeColor: theme.colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.kRoundedBorderRadius)
                ),
                value: reactiveProv.selectedItems.contains(widget.songs[index].songId), 
                onChanged: (value){
                  prov.selectItem(
                    id: widget.songs[index].songId
                  );
                },
              ),
            ) : null,
            trailing: FadeInRight(
              duration: const Duration(milliseconds: 100),
              child: ReorderableDragStartListener(
                index: index,
                child: const Icon(Icons.drag_handle),
              ),
            ),
          ),
          if(index + 1 != widget.songs.length )
          Container(
            height: 0.5,
            color : theme.colorScheme.outline
          ),
        ],
      ),
      onReorder: (oldIndex, newIndex) async{
        prov.reorderSongs(oldIndex, newIndex);
        final response = await _orderSongs(
          oldIndex: oldIndex,
          newIndex: newIndex,
          songs: prov.model!
        );
        widget.onActionEnd(response, oldIndex,newIndex);
      },
    );
  }
}