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
        message: 'Exito',
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

}