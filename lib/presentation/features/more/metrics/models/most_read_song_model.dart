class MostReadSongModel {
  final int views;
  final String song;
  final String? genre;

  MostReadSongModel({
    required this.views, 
    required this.song, 
    this.genre = ''
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'views': views,
      'song': song,
      'genre': genre,
    };
  }

  factory MostReadSongModel.fromMap(Map<String, dynamic> map) {
    return MostReadSongModel(
      views: map['views'] as int,
      song: map['song'] as String,
      genre: map['genre'] != null ? map['genre'] as String : '',
    );
  }
}
