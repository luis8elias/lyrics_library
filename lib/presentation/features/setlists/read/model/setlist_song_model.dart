import 'package:flutter_guid/flutter_guid.dart';

class SetlistSongModel {
  final Guid id;
  final Guid title;
  final String genreName;


  SetlistSongModel({
    required this.id,
    required this.title,
    required this.genreName,
  });


}