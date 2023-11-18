import 'package:lyrics_library/utils/utils.dart';

import '/data/models/form_model.dart';

class CreateGenreModel extends FormModel {

  final String? name;

  CreateGenreModel({
    this.name, 
  });
  
  
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  @override
  bool get isValid =>
  (
    (name == null? false : Validator.validateRequired(name ?? '') == null)    
  );

  CreateGenreModel copyWith({
    String? name,
  }) {
    return CreateGenreModel(
      name: name ?? this.name,
    );
  }
}