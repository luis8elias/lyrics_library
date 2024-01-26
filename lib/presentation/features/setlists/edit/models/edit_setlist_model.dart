
import 'package:flutter_guid/flutter_guid.dart';

import '/data/models/syncable_model.dart';
import '/data/models/form_model.dart';
import '/utils/extensions/string_extensions.dart';
import '/utils/utils.dart';

class EditSetlistModel extends SyncableModel implements FormModel {

  final Guid? id;
  final String? name;
  final Guid?  ownerId;


  EditSetlistModel({
    this.id,
    this.name,
    this.ownerId,
    super.isRemoved = 0,
    super.isSync = 0,
  });
  
  
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id.toString(),
      'name': name?.capitalize(),
      'ownerId': ownerId.toString(),
      'sync' : isSync,
      'allowToRemove' : 1,
      'isRemoved': isRemoved
    };
  }

  Map<String, dynamic> toMapWithoutId() {
    return <String, dynamic>{
      'name': name?.capitalize(),
      'ownerId' : ownerId.toString(),
      'sync' : isSync,
      'allowToRemove' : 1,
      'isRemoved': isRemoved
    };
  }

  @override
  bool get isValid =>
  (
    (id != null ) &&
    (ownerId != null ) &&
    (name == null? false : Validator.validateRequired(name ?? '') == null)
  );
  

  EditSetlistModel copyWith({
    Guid? id,
    String? name,
    final Guid?  ownerId
  }) {
    return EditSetlistModel(
      id: id ?? this.id,
      name: name ?? this.name,
      ownerId: ownerId ?? this.ownerId
    );
  }
}