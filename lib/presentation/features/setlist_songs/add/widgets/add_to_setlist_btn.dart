import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import '/data/models/response_model.dart';
import '/presentation/features/setlist_songs/add/models/song_model_from_add_song_to_setlist_model.dart';
import '/presentation/features/setlist_songs/add/provider/providers.dart';
import '/presentation/features/setlist_songs/list/model/setlist_song_model.dart';
import '/presentation/widgets/loaders.dart';
import '/services/setlist_songs_service.dart';

class AddToSetlistBtn extends ConsumerStatefulWidget {
  const AddToSetlistBtn({
    super.key,
    required this.song,
    required this.onActionEnd
  });

  final SongModelFromAddSongToSetlistModel song;
  final void Function(ResponseModel<SetlistSongModel?> response) onActionEnd;

  @override
  ConsumerState<AddToSetlistBtn> createState() => _AddToSetlistBtnState();
}

class _AddToSetlistBtnState extends ConsumerState<AddToSetlistBtn> {

  bool isLoading = false;
  final SetlistSongsService _setlistSongsService = Injector.appInstance.get();

  Future<ResponseModel<SetlistSongModel?>> _addSongToSetlist({
    required Guid songId,
    required Guid setlistId
  }) async{
    setState(() {
      isLoading = true;
    });
    final resp = await _setlistSongsService.addSongToSetlist(
      songId: widget.song.songId,
      setlistId: setlistId
    );
    setState(() {
      isLoading = false;
    });
    return resp;
  }


  @override
  Widget build(BuildContext context) {

    final provList = ref.read(addSetlistSongsListProvider);

    return IconButton(
      highlightColor: Colors.transparent,
      onPressed: isLoading ? (){} :
      () async{
        final response = await _addSongToSetlist(
          songId: widget.song.songId,
          setlistId: provList.getSetlistId
        );
        widget.onActionEnd(response);
      }, 
      icon: isLoading  ?  SizedBox(
        width: Platform.isIOS ? 30 : 20 ,
        child: const CleanLoaderWidget(
          iosSize: 10,
          androidSize: 20,
        ),
      )
      : const Icon(CupertinoIcons.add_circled )
    );
  }
}