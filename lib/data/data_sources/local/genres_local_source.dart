import 'package:flutter_guid/flutter_guid.dart';

import '/data/data_sources/interfaces/genres_data_source_inteface.dart';
import '/data/models/response_model.dart';
import '/presentation/features/genres/create/models/create_genre_model.dart';
import '/presentation/features/genres/edit/models/edit_genre_model.dart';
import '/presentation/features/genres/shared/models/genre_model.dart';
import '/utils/db/sqlite.dart';
import '/utils/logger/logger_helper.dart';

class GenresLocalSource extends GenresDataSource{

  @override
  Future<ResponseModel<List<GenreModel>?>> fetchGenres() async{

    try {
      
      final genresMapList = await SQLite.instance.query(
        GenresTable.name,
        where: '${GenresTable.columnIsRemoved} = ?',
        whereArgs: [0]
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
  
  @override
  Future<ResponseModel<String>> deleteGenres({
    required List<Guid> genresIds
  }) async {

    try {

      final questionSymbols = genresIds.map((e) => '?').join(',');
      final result = await  SQLite.instance.rawUpdate('UPDATE ${GenresTable.name} SET isRemoved = ? WHERE ${GenresTable.columnId} IN ($questionSymbols)', [1, ...genresIds.map((e) => e.toString()).toList()]);
      
      if(result == 0){
        return ResponseModel(
          success: false,
          message: 'Ocurrió un problema al eliminar el género'
        );
      }
      await Future.delayed(const Duration(milliseconds: 500));
      
      return ResponseModel(
        success: true, 
        message: genresIds.length > 1 ? 'Géneros eliminados' : 'Género eliminado' ,
        model: ''
      );

    } catch (e) {

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en GenresLocalSource método [deleteGenres]');

      return ResponseModel(
        success: false,
        message: 'Ocurrió un problema al eliminar el género'
      );

    }
    
  }

  @override
  Future<ResponseModel<String>> editGenre({
    required EditGenreModel editGenreModel
  }) async{

    try {

      final editedGenre = editGenreModel.toMapWithoutId();
      final rowsAffected = await  SQLite.instance.update(
        GenresTable.name, 
        editedGenre,
        where: '${GenresTable.columnId} = ?',
        whereArgs: [editGenreModel.id.toString()]
      );
      
      if(rowsAffected == 0){
        return ResponseModel(
          success: false,
          message: 'Ocurrió un problema al editar el género'
        );
      }
      await Future.delayed(const Duration(milliseconds: 500));
      
      return ResponseModel(
        success: true, 
        message: 'Género editado' ,
        model: ''
      );

    } catch (e) {

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en GenresLocalSource método [editGenre]');

      return ResponseModel(
        success: false,
        message: 'Ocurrió un problema al editar el género'
      );

    }
    
  }

}