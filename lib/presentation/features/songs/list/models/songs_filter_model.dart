
import 'package:flutter_guid/flutter_guid.dart';

class SongFilterModel {

  final String query;
  final Guid? genreId;
  
  SongFilterModel({
    this.query = '',
    this.genreId,
  });

  SongFilterModel copyWith({
    String? query,
    Guid? genreId,
  }) {
    return SongFilterModel(
      query: query ?? this.query,
      genreId: Guid.defaultValue == genreId ? null : genreId ?? this.genreId 
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'query': query,
      'genreId': genreId?.toString(),
    };
  }

  bool get isEmpty{
    return (query.isEmpty) &&
    (genreId == null);
  }

 
}
