import 'package:lyrics_library/data/models/response_model.dart';
import 'package:lyrics_library/presentation/features/genres/shared/models/genre_model.dart';
import 'package:lyrics_library/presentation/providers/providers.dart';
import 'package:lyrics_library/services/genres_service.dart';

class GenresListProvider extends FetchProvider<List<GenreModel>?>{
  final GenresService _genresService;

  GenresListProvider({
    required GenresService genresService
  }) : _genresService = genresService;



  @override
  Future<ResponseModel<List<GenreModel>?>> fetchMethod() {
    return _genresService.fetchGenres();
  }

  Future<void> refreshGenres() async{
    loadData();
  }

}