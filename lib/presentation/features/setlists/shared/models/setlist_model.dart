// ignore_for_file: public_member_api_docs,
import 'package:flutter_guid/flutter_guid.dart';

import '/data/models/syncable_model.dart';
import '/presentation/features/setlists/edit/models/edit_setlist_model.dart';

class SetlistModel extends SyncableModel{

  final Guid id;
  final String name;
  final Guid ownerId;
  final int allowToRemove;

  String get idAsStr => id.toString();

  String get nameInitials { 
    final nameArr = name.split(' ');
    if(nameArr.length > 1){
      return '${nameArr[0][0].toUpperCase()}${nameArr[1][0].toUpperCase()}';
    }
    return name[0].toUpperCase();
  }


  SetlistModel({
    required this.id, 
    required this.name, 
    required this.ownerId,
    super.isRemoved,
    super.isSync,
    this.allowToRemove = 1
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id.toString(),
      'name': name,
      'ownerId': ownerId.toString(),
      'sync' : isSync,
      'allowToRemove' : allowToRemove,
      'isRemoved': isRemoved
    };
  }

  bool get isEmpty => (
    id == Guid.defaultValue &&
    name.isEmpty &&
    id == Guid.defaultValue &&
    isSync == 0
  );

  factory SetlistModel.fromMap(Map<String, dynamic> map) {
    return SetlistModel(
      id: Guid(map['id']),
      name: map['name'] as String,
      ownerId: Guid(map['ownerId']),
      isSync: map['sync'],
      allowToRemove: map['allowToRemove'],
      isRemoved: map['isRemoved']
    );
  }

  factory SetlistModel.empty() {
    return SetlistModel(
      id: Guid.defaultValue,
      name: '',
      ownerId: Guid.defaultValue,
      isSync: 0,
      isRemoved: 0,
      allowToRemove: 1
    );
  }

  static List<SetlistModel> fromMapList(List<Map<String,dynamic>> mapList){
    return mapList.map(
      (genreMap) => SetlistModel.fromMap(genreMap)
    ).toList();
  }

  static SetlistModel fromEditSetlistModel(EditSetlistModel editSetlistModel){
    return SetlistModel.fromMap(editSetlistModel.toMap());
  }


  SetlistModel copyWith({
    Guid? id,
    String? name,
    Guid? ownerId,
  }) {
    return SetlistModel(
      id: id ?? this.id,
      name: name ?? this.name,
      ownerId: ownerId ?? this.ownerId,
    );
  }

   bool get allowToRemoveBool => allowToRemove == 1;
  
}
