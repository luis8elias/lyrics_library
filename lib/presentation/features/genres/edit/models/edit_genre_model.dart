
import 'package:flutter_guid/flutter_guid.dart';

import '/data/models/syncable_model.dart';
import '/data/models/form_model.dart';
import '/utils/extensions/string_extensions.dart';
import '/utils/utils.dart';

class EditGenreModel extends SyncableModel implements FormModel {

  final Guid? id;
  final String? name;
  final Guid?  ownerId;


  EditGenreModel({
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
      'isRemoved': isRemoved
    };
  }

  Map<String, dynamic> toMapWithoutId() {
    return <String, dynamic>{
      'name': name?.capitalize(),
      'ownerId' : ownerId.toString(),
      'sync' : isSync,
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
  

  EditGenreModel copyWith({
    Guid? id,
    String? name,
    final Guid?  ownerId
  }) {
    return EditGenreModel(
      id: id ?? this.id,
      name: name ?? this.name,
      ownerId: ownerId ?? this.ownerId
    );
  }
}