
import 'package:flutter_guid/flutter_guid.dart';
import 'package:lyrics_library/presentation/features/genres/shared/models/genre_model.dart';

import '/data/models/syncable_model.dart';
import '/data/models/form_model.dart';
import '/utils/extensions/string_extensions.dart';
import '/utils/utils.dart';

class EditSongModel extends SyncableModel implements FormModel {

  final Guid? id;
  final String? title;
  final String? lyric;
  final Guid?  ownerId;
  final GenreModel? genre;


  EditSongModel({
    this.id,
    this.title,
    this.lyric,
    this.ownerId,
    super.isRemoved = 0,
    super.isSync = 0,
    this.genre
  });
  
  
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id.toString(),
      'title': title?.capitalize(),
      'lyric': lyric?.capitalize(),
      'ownerId': ownerId.toString(),
      'sync' : isSync,
      'isRemoved': isRemoved,
      'genreId' : genre?.id.toString()
    };
  }

  Map<String, dynamic> toMapWithoutId() {
    return <String, dynamic>{
      'title': title?.capitalize(),
      'lyric': lyric?.capitalize(),
      'searchKeywords' : _getSearchKeywords(title ?? '', lyric ?? ''),
      'ownerId' : ownerId.toString(),
      'sync' : isSync,
      'isRemoved': isRemoved,
      'genreId' : genre?.id.toString()
    };
  }

  @override
  bool get isValid =>
  (
    (id != null ) &&
    (ownerId != null ) &&
    (title == null? false : Validator.validateRequired(title ?? '') == null)
    
  );
  

  EditSongModel copyWith({
    Guid? id,
    String? name,
    final String? title,
    final String? lyric,
    final Guid?  ownerId,
    GenreModel? genre,
  }) {
    return EditSongModel(
      id: id ?? this.id,
      title: title ?? this.title,
      lyric: lyric ?? this.lyric,
      ownerId: ownerId ?? this.ownerId,
      genre: genre ?? this.genre
    );
  }

  static String _getSearchKeywords(String title, String lyric){
    final fullStr = '$title $lyric';
    return SearchKeywords.get(fullStr);
  }
}