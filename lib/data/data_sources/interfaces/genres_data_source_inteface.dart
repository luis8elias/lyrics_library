import '/presentation/features/genres/create/models/create_genre_model.dart';
import '/data/models/response_model.dart';
import '/presentation/features/genres/shared/models/genre_model.dart';

abstract class GenresDataSource{

  Future<ResponseModel<List<GenreModel>?>> fetchGenres();
  
  Future<ResponseModel<String?>> createGenre({
    required CreateGenreModel createGenreModel
  });

}