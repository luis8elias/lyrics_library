import 'package:flutter_guid/flutter_guid.dart';

class AddSongToSetListModel {

  final Guid id;
  final Guid setlistId;
  final Guid songId;
  final int indexOrder;
  final String ownerId;
  final int isSync;

  AddSongToSetListModel({
    required this.id, 
    required this.setlistId, 
    required this.songId, 
    this.indexOrder = 0 , 
    required this.ownerId, 
    this.isSync = 0
  });

 



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id.toString(),
      'setlistId': setlistId.toString(),
      'songId': songId.toString(),
      'indexOrder': indexOrder,
      'ownerId': ownerId,
      'sync': isSync,
    };
  }

 

}
