import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

import '/data/models/response_model.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/presentation/widgets/widgets.dart';
import '/services/setlist_songs_service.dart';


class LikeSongButton extends StatefulWidget {
  const LikeSongButton({
    super.key,
    required this.songModel,
    required this.onActionEnd
  });

  final SongModel songModel;
  final void Function(ResponseModel<SongModel?> response) onActionEnd;

  @override
  State<LikeSongButton> createState() => _LikeSongButtonState();
}

class _LikeSongButtonState extends State<LikeSongButton> {

  bool isLoading = false;
  final SetlistSongsService _setlistSongsService = Injector.appInstance.get();

  Future<ResponseModel<SongModel?>> _toggleIsFavorite(SongModel songModel) async{
    setState(() {
      isLoading = true;
    });
    final resp = await _setlistSongsService.toogleIsFavorite(songModel: songModel);
    setState(() {
      isLoading = false;
    });
    return resp;
  }


  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return IconButton(
      highlightColor: Colors.transparent,
      onPressed: isLoading ? (){} :
      () async{
        final response = await _toggleIsFavorite(widget.songModel);
        widget.onActionEnd(response);
      }, 
      icon: isLoading  ?  SizedBox(
        width: Platform.isIOS ? 30 : 20 ,
        child: const CleanLoaderWidget(
          iosSize: 10,
          androidSize: 20,
        ),
      )
      : Icon(
        widget.songModel.isFavoriteAsBool 
        ? CupertinoIcons.heart_fill
        : CupertinoIcons.heart,
        color: widget.songModel.isFavoriteAsBool 
        ? theme.colorScheme.primary 
        : null,
      )
    );
  }
}