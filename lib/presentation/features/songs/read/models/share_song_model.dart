import 'dart:convert';

import 'package:flutter_guid/flutter_guid.dart';
import 'package:json_compress/json_compress.dart';

import '/presentation/features/setlist_songs/list/model/setlist_song_model.dart';
import '/presentation/features/songs/shared/model/song_model.dart';

class ShareSongModel{
  final Guid id;
  final String title;
  final String? lyric;
  final String? genreName;

  ShareSongModel({
    required this.id, 
    required this.title, 
    required this.lyric, 
    required this.genreName
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'lyric': lyric ?? '',
      'genre': genreName != null ?
      {
        'name' : genreName ?? ''
      }
      : null,
    };
  }

  String toShareEncoded (){
    return jsonEncode(compressJson(toJson()));
  }

  String toShareStr() {

    if(genreName == null){
      return '$title\n$lyric';
    }


    return  '$title -$genreName \n $lyric';
  }

  static ShareSongModel fromSongModel(SongModel songModel){
    return ShareSongModel(
      id: songModel.id,
      title: songModel.title,
      lyric: songModel.lyric,
      genreName: songModel.genreModel?.name
    );
  }

  static ShareSongModel fromSetlistSongModel(
    SetlistSongModel setlistSongModel,
    String lyric
  ){
    return ShareSongModel(
      id: setlistSongModel.id,
      title: setlistSongModel.title,
      lyric: lyric,
      genreName: setlistSongModel.genreName
    );
  }
 
}