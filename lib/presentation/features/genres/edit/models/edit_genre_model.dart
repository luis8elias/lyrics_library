
import 'package:flutter_guid/flutter_guid.dart';
import 'package:lyrics_library/utils/utils.dart';

import '/data/models/form_model.dart';

class EditGenreModel extends FormModel {

  final Guid? id;
  final String? name;
  final Guid?  ownerId;

  EditGenreModel({
    this.id,
    this.name,
    this.ownerId,
  });
  
  
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id.toString(),
      'name': name,
      'ownerId': ownerId.toString()
    };
  }

  Map<String, dynamic> toMapWithoutId() {
    return <String, dynamic>{
      'name': name,
      'ownerId' : ownerId.toString()
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