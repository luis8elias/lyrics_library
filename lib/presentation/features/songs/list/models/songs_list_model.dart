import 'package:lyrics_library/presentation/features/songs/shared/model/song_model.dart';

class SongsListModel{
  final int totalSongs;
  final List<SongModel> items;

  SongsListModel({
    required this.totalSongs,
     required this.items
  });
}