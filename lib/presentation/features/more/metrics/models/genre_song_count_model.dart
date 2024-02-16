import '/config/lang/generated/l10n.dart';

class GenreSongCountModel {
  final double count;
  final String genre;

  GenreSongCountModel({
    required this.count, 
    required this.genre
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'genre': genre,
    };
  }

  factory GenreSongCountModel.fromMap(Map<String, dynamic> map) {
    final lang = Lang.current;
    return GenreSongCountModel(
      count: (map['count'] as int).toDouble(),
      genre: map['genre'] == null 
      ? lang.metricsScreen_topReadSongsNoGenre 
      : map['genre'] as String ,
    );
  }
  
}

class GenresSongCountResp{
  List<GenreSongCountModel> data;
  

  double get maxValue {
    final count = data[0].count;
    if(count <= 10 ){
      return 10;
    }
    return data[0].count + (data[0].count / 4.round());
  }

  double get inrtervals{
    return maxValue / 4.round();
  }

  GenresSongCountResp({
    required this.data
  });}
