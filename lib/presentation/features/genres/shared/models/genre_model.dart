import 'package:flutter_guid/flutter_guid.dart';

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

}
