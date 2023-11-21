import 'package:flutter_guid/flutter_guid.dart';
import 'package:lyrics_library/presentation/features/genres/edit/models/edit_genre_model.dart';

import '/presentation/features/genres/create/models/create_genre_model.dart';
import '/data/models/response_model.dart';
import '/presentation/features/genres/shared/models/genre_model.dart';

abstract class GenresDataSource{

  Future<ResponseModel<List<GenreModel>?>> fetchGenres();
  
  Future<ResponseModel<GenreModel?>> createGenre({
    required CreateGenreModel createGenreModel
  });

  Future<ResponseModel<String>> deleteGenres({
    required List<Guid> genresIds
  });

  Future<ResponseModel<String>> editGenre({
    required EditGenreModel editGenreModel
  });

}