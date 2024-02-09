class ScannedSongModel {
  final String title;
  final String lyric;
  final String? genreName;

  ScannedSongModel({
    required this.title, 
    required this.lyric, 
    this.genreName
  });


 

  factory ScannedSongModel.fromMap(Map<String, dynamic> map) {
    return ScannedSongModel(
      title: map['title'] as String,
      lyric: map['lyric'] as String,
      genreName: map['genre']['name'] != null ? map['genre']['name'] as String : null,
    );
  }
 
}
