// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_guid/flutter_guid.dart';
import 'package:lyrics_library/data/models/syncable_model.dart';
import '/presentation/features/genres/edit/models/edit_genre_model.dart';

class GenreModel extends SyncableModel{

  final Guid id;
  final String name;
  final Guid ownerId;


  GenreModel({
    required this.id, 
    required this.name, 
    required this.ownerId,
    super.isRemoved = 0,
    super.isSync = 0,
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

  factory GenreModel.fromMap(Map<String, dynamic> map) {
    return GenreModel(
      id: Guid(map['id']),
      name: map['name'] as String,
      ownerId: Guid(map['ownerId']),
      isSync: map['sync'],
      isRemoved: map['isRemoved']
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
