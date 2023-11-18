import '/data/models/response_model.dart';
import '/presentation/features/genres/shared/models/genre_model.dart';

abstract class GenresDataSource{

  Future<ResponseModel<List<GenreModel>?>> fetchGenres();

}