import 'package:flutter_guid/flutter_guid.dart';

class SongModelFromAddSongToSetlistModel {

  final Guid songId;
  final String title;
  final String? genreName;

  SongModelFromAddSongToSetlistModel({
    required this.songId, 
    required this.title,
    this.genreName
  });

  SongModelFromAddSongToSetlistModel copyWith({
    Guid? songId,
    String? title,
    String? genreName,
  }) {
    return SongModelFromAddSongToSetlistModel(
      songId: songId ?? this.songId,
      title: title ?? this.title,
      genreName: genreName ?? this.genreName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'songId': songId.toString(),
      'title': title,
      'genreName': genreName,
    };
  }

  factory SongModelFromAddSongToSetlistModel.fromMap(Map<String, dynamic> map) {
    return SongModelFromAddSongToSetlistModel(
      songId: Guid(map['id']),
      title: map['title'] as String,
      genreName: map['genreName'] as String?,
    );
  }

  static List<SongModelFromAddSongToSetlistModel> fromMapList(
    List<Map<String,dynamic>> mapList
  ){
    return mapList.map(
      (songMap) => SongModelFromAddSongToSetlistModel.fromMap(songMap)
    ).toList();
  }

 
}





class ListAddSongs{
  final int totalSongs;
  final List<SongModelFromAddSongToSetlistModel> items;

  ListAddSongs({
    required this.totalSongs,
     required this.items
  });
}
