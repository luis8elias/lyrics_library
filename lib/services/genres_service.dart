import 'package:lyrics_library/data/models/response_model.dart';
import 'package:lyrics_library/presentation/features/genres/create/models/create_genre_model.dart';
import 'package:lyrics_library/presentation/features/genres/shared/models/genre_model.dart';

import '/data/data_sources/local/genres_local_source.dart';

class GenresService {
  final GenresLocalSource _localSource;

  GenresService({
    required GenresLocalSource localSource
  }) : _localSource = localSource;

  Future<ResponseModel<List<GenreModel>?>> fetchGenres() async {
    return _localSource.fetchGenres();
  }

  Future<ResponseModel<GenreModel?>> createGenre({
    required CreateGenreModel createGenreModel
  }) async {
    return _localSource.createGenre(createGenreModel: createGenreModel);
  }
}