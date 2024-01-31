// ignore_for_file: public_member_api_docs, sort_constructors_first
import '/presentation/features/setlist_songs/list/model/setlist_song_model.dart';
import '/presentation/features/setlists/shared/models/setlist_model.dart';

class SetlistRouteParamsModel {
  final SetlistModel setlistModel;
  final List<SetlistSongModel> setlistSongs;

  SetlistRouteParamsModel({
    required this.setlistModel, 
    this.setlistSongs = const []
  });

  SetlistRouteParamsModel copyWith({
    List<SetlistSongModel>? setlistSongs,
  }) {
    return SetlistRouteParamsModel(
      setlistModel: setlistModel,
      setlistSongs: setlistSongs ?? this.setlistSongs,
    );
  }
}
