import 'package:flutter_guid/flutter_guid.dart';

class SetlistSongModel {
  final Guid id;
  final String title;
  final String? genreName;
  final int indexOrder;


  SetlistSongModel({
    required this.id,
    required this.title,
    required this.genreName,
    required this.indexOrder
  });

  static List<SetlistSongModel> fromMapList(List<Map<String,dynamic>> mapList){
    return mapList.map(
      (songMap) {
        songMap;
        return SetlistSongModel.fromMap(songMap);
      }
    ).toList();
  }

  factory SetlistSongModel.fromMap(Map<String, dynamic> map) {
    return SetlistSongModel(
      id: Guid(map['id'] as String),
      title: map['title'] as String,
      genreName: map['genreName'] as String?,
      indexOrder: map['indexOrder'] as int
    );
  }
 
}
