import '/data/models/form_model.dart';
import '/utils/utils.dart';

class CreateSetlistModel extends FormModel {

  final String? name;

  CreateSetlistModel({
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

  CreateSetlistModel copyWith({
    String? name,
  }) {
    return CreateSetlistModel(
      name: name ?? this.name,
    );
  }
}