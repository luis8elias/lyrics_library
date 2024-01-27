import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:lyrics_library/data/models/response_model.dart';
import 'package:lyrics_library/presentation/features/songs/shared/model/song_model.dart';
import 'package:lyrics_library/presentation/widgets/widgets.dart';
import 'package:lyrics_library/services/songs_service.dart';

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
  final SongsService _songsService = Injector.appInstance.get();

  Future<ResponseModel<SongModel?>> _toggleIsFavorite(SongModel songModel) async{
    setState(() {
      isLoading = true;
    });
    final resp = await _songsService.toogleIsFavorite(songModel: songModel);
    setState(() {
      isLoading = false;
    });
    return resp;
  }


  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return isLoading 
    ? const SizedBox(
      height: 30,
      width: 45,
      child: Center(
        child: CleanLoaderWidget(
          iosSize: 10,
          androidSize: 20,
        ),
      ),
    )
    :  IconButton(
      onPressed: () async{
        final response = await _toggleIsFavorite(widget.songModel);
        widget.onActionEnd(response);
      }, 
      icon: Icon(
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