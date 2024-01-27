// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_guid/flutter_guid.dart';

import '/data/models/syncable_model.dart';
import '/presentation/features/genres/shared/models/genre_model.dart';
import '/presentation/features/songs/create/models/create_song_model.dart';
import '/utils/extensions/string_extensions.dart';
import '/utils/utils.dart';

class SongModel extends SyncableModel {
  final Guid id;
  final String title;
  final String lyric;
  final Guid ownerId;
  final GenreModel? genreModel;
  final bool isNew;
  final int isFavorite;

  String? get genreIdAsStr => genreModel?.idAsStr;
  bool get isFavoriteAsBool => isFavorite == 1;

  SongModel({
    super.isRemoved, 
    super.isSync, 
    required this.id, 
    required this.title, 
    required this.lyric, 
    required this.ownerId, 
    required this.genreModel,
    required this.isFavorite,
    this.isNew = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id.toString(),
      'title': title,
      'lyric': lyric,
      'ownerId': ownerId.toString(),
      'sync' : isSync,
      'genre': genreModel?.toMap(),
      'isRemoved': isRemoved,
      'isFavorite' : isFavorite
    };
  }

  Map<String, dynamic> toInsertMap() {
    return <String, dynamic>{
      'id': id.toString(),
      'title': title,
      'lyric': lyric,
      'searchKeywords' : _getSearchKeywords(title, lyric),
      'ownerId': ownerId.toString(),
      'genreId': genreModel?.id.toString(),
      'sync' : isSync,
      'isRemoved': isRemoved,
      'isFavorite' : isFavorite 
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
      isRemoved: map['isRemoved'],
      isFavorite: map['isFavorite']
    );
  }


  factory SongModel.fromCreateSongModel({
    required CreateSongModel createSongModel,
    required String userId
  } ) {
    return SongModel(
      id: Guid.newGuid,
      title: createSongModel.title!.capitalize(),
      lyric: createSongModel.lyric ?? '', 
      ownerId: Guid(userId),
      genreModel: createSongModel.genre,
      isRemoved: 0,
      isSync: 0,
      isNew: true,
      isFavorite: 0
    );
  }

  static List<SongModel> fromMapList(List<Map<String,dynamic>> mapList){
    return mapList.map(
      (songMap) => SongModel.fromMap(songMap)
    ).toList();
  }

  static String _getSearchKeywords(String title, String lyric){
    final fullStr = '$title $lyric';
    return SearchKeywords.get(fullStr);
  }
  

  SongModel copyWith({
    int? isFavorite,
  }) {
    return SongModel(
      id: id,
      title: title,
      lyric: lyric,
      ownerId: ownerId ,
      genreModel: genreModel ,
      isNew: isNew,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
