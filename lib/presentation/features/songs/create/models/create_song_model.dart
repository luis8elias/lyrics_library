// ignore_for_file: public_member_api_docs, sort_constructors_first
import '/data/models/form_model.dart';
import '/presentation/features/genres/shared/models/genre_model.dart';
import '/utils/utils.dart';

class CreateSongModel extends FormModel {
  final String? title;
  final String? lyric;
  final GenreModel? genre;

  CreateSongModel({
    this.title,
    this.lyric,
    this.genre
  });
  
  @override
  bool get isValid => 
  (
    (title == null? false : Validator.validateRequired(title ?? '') == null)    
  );
  
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title ?? '',
      'lyric': lyric ?? '',
      'genreId' : genre?.id.toString()
    };
  }

  CreateSongModel copyWith({
    String? title,
    String? lyric,
    GenreModel? genre,
  }) {
    return CreateSongModel(
      title: title ?? this.title,
      lyric: lyric ?? this.lyric,
      genre: genre ?? this.genre,
    );
  }
}
