class UserModel{
  final int id;
  final String? name;
  final String? lastName;
  final String? email;

  UserModel({
    required this.id, 
    this.name, 
    this.lastName, 
    this.email
  });


  UserModel get empty => UserModel(id: 0);
}