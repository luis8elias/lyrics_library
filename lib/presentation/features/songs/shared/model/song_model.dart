
import 'package:flutter_guid/flutter_guid.dart';

import '/data/models/syncable_model.dart';
import '/presentation/features/genres/shared/models/genre_model.dart';

class SongModel extends SyncableModel{
  final Guid id;
  final String title;
  final String lyric;
  final Guid ownerId;
  final GenreModel? genreModel;

  String? get genreIdAsStr => genreModel?.idAsStr;

  SongModel({
    super.isRemoved, 
    super.isSync, 
    required this.id, 
    required this.title, 
    required this.lyric, 
    required this.ownerId, 
    required this.genreModel
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id.toString(),
      'title': title,
      'lyric': lyric,
      'ownerId': ownerId.toString(),
      'sync' : isSync,
      'genre': genreModel?.toMap(),
      'isRemoved': isRemoved
    };
  }

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
      id: Guid(map['id']),
      title: map['title'] as String,
      lyric: map['lyric'] as String,
      ownerId: Guid(map['ownerId']),
      genreModel: map['genreName'] != null ? GenreModel.fromSongMap(map) : null,
      isSync: map['sync'],
      isRemoved: map['isRemoved']
    );
  }

  static List<SongModel> fromMapList(List<Map<String,dynamic>> mapList){

    return mapList.map(
      (songMap) => SongModel.fromMap(songMap)
    ).toList();
  }
  
}