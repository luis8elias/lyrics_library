import 'package:flutter_guid/flutter_guid.dart';

import '/data/models/response_model.dart';
import '/presentation/features/genres/create/models/create_genre_model.dart';
import '/presentation/features/genres/edit/models/edit_genre_model.dart';
import '/presentation/features/genres/shared/models/genre_model.dart';

import '/data/data_sources/local/genres_local_source.dart';

class GenresService {
  final GenresLocalSource _localSource;

  GenresService({
    required GenresLocalSource localSource
  }) : _localSource = localSource;

  Future<ResponseModel<List<GenreModel>?>> fetchGenres({
    required String query
  }) async {
    return _localSource.fetchGenres(
      query: query
    );
  }

  Future<ResponseModel<GenreModel?>> createGenre({
    required CreateGenreModel createGenreModel
  }) async {
    return _localSource.createGenre(createGenreModel: createGenreModel);
  }

  Future<ResponseModel<String>> deleteGenres({
    required List<Guid> genresIds
  }) async {
    return _localSource.deleteGenres(
      genresIds: genresIds
    );
  }

  Future<ResponseModel<String?>> editGenre({
    required EditGenreModel editGenreModel
  }) async {
    return _localSource.editGenre(editGenreModel: editGenreModel);
  }
}