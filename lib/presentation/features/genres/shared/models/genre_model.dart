// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_guid/flutter_guid.dart';
import 'package:lyrics_library/presentation/features/genres/edit/models/edit_genre_model.dart';

class GenreModel {

  final Guid id;
  final String name;
  final Guid ownerId;

  GenreModel({
    required this.id, 
    required this.name, 
    required this.ownerId
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id.toString(),
      'name': name,
      'ownerId': ownerId.toString(),
    };
  }

  factory GenreModel.fromMap(Map<String, dynamic> map) {
    return GenreModel(
      id: Guid(map['id']),
      name: map['name'] as String,
      ownerId: Guid(map['ownerId']),
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
