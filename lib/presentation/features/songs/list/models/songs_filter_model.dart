import 'package:flutter_guid/flutter_guid.dart';

class SongFilterModel {

  final String query;
  final GenreFilterModel? genre;

  
  SongFilterModel({
    this.query = '',
    this.genre,
  });

  SongFilterModel copyWith({
    String? query,
    GenreFilterModel? genre,
  }) {
    return SongFilterModel(
      query: query ?? this.query,
      genre: genre == null ? this.genre : genre.id == Guid.defaultValue ? null : genre
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'query': query,
      'genreId': genre?.id.toString().toString(),
    };
  }

  bool get isEmpty{
    return (query.isEmpty) &&
    (genre == null);
  }

  bool get isNotEmpty{
    return !isEmpty;
  }

 
}

class GenreFilterModel {
  final Guid id;
  final String genreName;


  GenreFilterModel({
    required this.id, required this.genreName
  });
}
