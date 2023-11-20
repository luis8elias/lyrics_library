import 'package:flutter_guid/flutter_guid.dart';
import 'package:lyrics_library/presentation/features/genres/create/models/create_genre_model.dart';

import '/utils/db/sqlite.dart';
import '/utils/logger/logger_helper.dart';
import '/data/data_sources/interfaces/genres_data_source_inteface.dart';
import '/data/models/response_model.dart';
import '/presentation/features/genres/shared/models/genre_model.dart';

class GenresLocalSource extends GenresDataSource{
  @override
  Future<ResponseModel<List<GenreModel>?>> fetchGenres() async{

    try {
      
      final genresMapList = await SQLite.instance.query(
        GenresTable.name
      );
      await Future.delayed(const Duration(milliseconds: 500));
      return ResponseModel(
        success: true,
        model: GenreModel.fromMapList(genresMapList)
      );

    } catch (e) {

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en GenresLocalSource método [fetchGenres]');

      return ResponseModel(
        success: false,
        message: 'Ocurrió un probelma al obtener los géneros'
      );

    }
  }

  @override
  Future<ResponseModel<GenreModel?>> createGenre({
    required CreateGenreModel createGenreModel
  }) async{

    try {

      final genre = GenreModel(
        id: Guid.newGuid,
        name: createGenreModel.name!, 
        ownerId: Guid.newGuid
      );
      
      final result = await SQLite.instance.insert(
        GenresTable.name, genre.toMap()
      );

    if(result == 0){
      return ResponseModel(
        success: false,
        message: 'Ocurrió un problema al crear el género'
      );
    }
    await Future.delayed(const Duration(milliseconds: 500));
    
    return ResponseModel(
      success: true, 
      message: 'Género creado',
      model: genre
    );

    } catch (e) {

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en GenresLocalSource método [createGenre]');

      return ResponseModel(
        success: false,
        message: 'Ocurrió un problema al crear el género'
      );

    }
    
  }

}