import 'package:flutter_guid/flutter_guid.dart';
import 'package:lyrics_library/presentation/providers/send_provider.dart';
import 'package:lyrics_library/services/genres_service.dart';

class DeleteGenreProvider extends SendProvider<String?>{
  final GenresService _genresService;

  DeleteGenreProvider({
    required GenresService genreService
  }) : _genresService = genreService;

  Future<void> deleteGenres({
    required List<Guid> genresIds
  }) async {

    applyStatus(SendStatus.loading);
    final deleteGenreResp = await _genresService.deleteGenres(
      genresIds: genresIds
    );
    message = deleteGenreResp.message ?? '';
    if(deleteGenreResp.isFailed){
      return  applyStatus(SendStatus.failed);
    }
    model = deleteGenreResp.model;
    return  applyStatus(SendStatus.success);
  }
}