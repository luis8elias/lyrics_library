// ignore_for_file: public_member_api_docs,
import 'package:flutter_guid/flutter_guid.dart';

import '/data/models/syncable_model.dart';
import '/presentation/features/genres/edit/models/edit_genre_model.dart';

class GenreModel extends SyncableModel{

  final Guid id;
  final String name;
  final Guid ownerId;

  String get idAsStr => id.toString();

  String get nameInitials { 
    final nameArr = name.split(' ');
    if(nameArr.length > 1){
      return '${nameArr[0][0].toUpperCase()}${nameArr[1][0].toUpperCase()}';
    }
    return name[0].toUpperCase();
  }


  GenreModel({
    required this.id, 
    required this.name, 
    required this.ownerId,
    super.isRemoved,
    super.isSync,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id.toString(),
      'name': name,
      'ownerId': ownerId.toString(),
      'sync' : isSync,
      'isRemoved': isRemoved
    };
  }

  bool get isEmpty => (
    id == Guid.defaultValue &&
    name.isEmpty &&
    id == Guid.defaultValue &&
    isSync == 0
  );

  factory GenreModel.fromMap(Map<String, dynamic> map) {
    return GenreModel(
      id: Guid(map['id']),
      name: map['name'] as String,
      ownerId: Guid(map['ownerId']),
      isSync: map['sync'],
      isRemoved: map['isRemoved']
    );
  }

  factory GenreModel.empty() {
    return GenreModel(
      id: Guid.defaultValue,
      name: '',
      ownerId: Guid.defaultValue,
      isSync: 0,
      isRemoved: 0
    );
  }

  factory GenreModel.fromSongMap(Map<String, dynamic> map) {
    return GenreModel(
      id: Guid(map['genreId']),
      name: map['genreName'] as String,
      ownerId: Guid(map['genreOwnerId']),
      isSync: map['genreSync'],
      isRemoved: map['genreIsRemoved']
    );
  }

  static List<GenreModel> fromMapList(List<Map<String,dynamic>> mapList){
    return mapList.map(
      (genreMap) => GenreModel.fromMap(genreMap)
    ).toList();
  }

  static GenreModel fromEditGenreModel(EditGenreModel editGenreModel){
    return GenreModel.fromMap(editGenreModel.toMap());
  }

  


  GenreModel copyWith({
    Guid? id,
    String? name,
    Guid? ownerId,
  }) {
    return GenreModel(
      id: id ?? this.id,
      name: name ?? this.name,
      ownerId: ownerId ?? this.ownerId,
    );
  }
  
}
