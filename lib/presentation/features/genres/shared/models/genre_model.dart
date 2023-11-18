import 'package:flutter_guid/flutter_guid.dart';

class GenreModel{

  final Guid id;
  final String name;
  final Guid ownerId;

  GenreModel({
    required this.id, 
    required this.name, 
    required this.ownerId
  });
  
}