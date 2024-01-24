
class SongFilterModel {

  final String query;
  final String genreId;
  
  SongFilterModel({
    this.query = '',
    this.genreId = '',
  });

  SongFilterModel copyWith({
    String? query,
    String? genreId,
  }) {
    return SongFilterModel(
      query: query ?? this.query,
      genreId: genreId ?? this.genreId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'query': query,
      'genreId': genreId,
    };
  }

  bool get isEmpty{
    return (query.isEmpty) &&
    (genreId.isEmpty);
  }

 
}
