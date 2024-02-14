import 'package:flutter_guid/flutter_guid.dart';

import '/config/config.dart';
import '/data/data_sources/interfaces/setlists_data_source_interface.dart';
import '/data/models/response_model.dart';
import '/presentation/features/setlists/create/models/create_setlist_model.dart';
import '/presentation/features/setlists/edit/models/edit_setlist_model.dart';
import '/presentation/features/setlists/shared/models/setlist_model.dart';
import '/utils/db/sqlite.dart';
import '/utils/extensions/string_extensions.dart';
import '/utils/logger/logger_helper.dart';

class SetlistsLocalSource extends SetlistsDataSource {
  SetlistsLocalSource({required super.sessionService});

  @override
  Future<ResponseModel<List<SetlistModel>?>> fetchSetlists({
    required String query
  }) async{
    try {

      final setlistsMapList = await SQLite.instance.rawQuery(
        'SELECT S.*, '
        'COUNT(SS.id) AS totalSongs '
        'FROM ${SetlistsTable.name} as S '
        'LEFT JOIN ${SetlistSongsTable.name} as SS ON '
        'S.${SetlistsTable.colId} = SS.${SetlistSongsTable.colSetlistId} '
        'WHERE S.${SetlistsTable.colIsAllowToRemove} = 0 OR '
        '( S.${SetlistsTable.colIsRemoved} = 0 AND '
        "S.${SetlistsTable.colName} LIKE '%$query%' )"
        'GROUP BY S.id , S.name '
        'ORDER BY S.${SetlistsTable.colIsAllowToRemove} ASC '
      );

      await Future.delayed(Config.manualLocalServicesDelay);
      return ResponseModel(
        success: true,
        model: SetlistModel.fromMapList(setlistsMapList)
      );

    } catch (e) {

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en SetlistsLocalSource método [fetchSetlists]');

      return ResponseModel(
        success: false,
        message: 'Ocurrió un probelma al obtener los setlists'
      );

    }
  }

  @override
  Future<ResponseModel<SetlistModel?>> createSetlist({
    required CreateSetlistModel createSetlistModel
  }) async{

    try {

      final authModel = await sessionService.getAuthModel();

      final setlist = SetlistModel(
        id: Guid.newGuid,
        name: createSetlistModel.name!.capitalize().trim(), 
        ownerId: Guid(authModel?.userId),
        totalSongs: 0
      );
      
      final result = await SQLite.instance.insert(
        SetlistsTable.name, setlist.toMap()
      );

    if(result == 0){
      return ResponseModel(
        success: false,
        message: 'Ocurrió un problema al crear el setlist'
      );
    }
    await Future.delayed(Config.manualLocalServicesDelay);
    
    return ResponseModel(
      success: true, 
      message: 'Setlist creado',
      model: setlist
    );

    } catch (e) {

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en SetlistsLocalSource método [createSetlist]');

      return ResponseModel(
        success: false,
        message: 'Ocurrió un problema al crear el setlist'
      );

    }
  }

  @override
  Future<ResponseModel<String>> deleteSetlists({
    required List<Guid> setlistsIds
  }) async {
    try {

      final questionSymbols = setlistsIds.map((e) => '?').join(',');
      final rowsAffected = await  SQLite.instance.rawUpdate(
        'UPDATE ${SetlistsTable.name} SET isRemoved = ? '
        'WHERE ${SetlistsTable.colId} IN ($questionSymbols) AND '
        '${SetlistsTable.colIsAllowToRemove} = 1',
        [1, ...setlistsIds.map((e) => e.toString()).toList()]
      );
      
      if(rowsAffected == 0){
        return ResponseModel(
          success: false,
          message: 'Ocurrió un problema al eliminar el setlist'
        );
      }
      await Future.delayed(Config.manualLocalServicesDelay);
      
      return ResponseModel(
        success: true, 
        message: setlistsIds.length > 1 ? 'Setlists eliminados' : 'Setlist eliminado' ,
        model: ''
      );

    } catch (e) {

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en SetlistsLocalSource método [deleteSetlists]');

      return ResponseModel(
        success: false,
        message: 'Ocurrió un problema al eliminar el setlist'
      );

    }
  }

  @override
  Future<ResponseModel<String>> editSetlist({
    required EditSetlistModel editSetlistModel
  }) async {

    try {
      
      final editedSetlist = editSetlistModel.toMapWithoutId();
      final rowsAffected = await  SQLite.instance.update(
        SetlistsTable.name, 
        editedSetlist,
        where: '${SetlistsTable.colId} = ?',
        whereArgs: [editSetlistModel.id.toString()]
      );
      
      if(rowsAffected == 0){
        return ResponseModel(
          success: false,
          message: 'Ocurrió un problema al editar el setlist'
        );
      }
      await Future.delayed(Config.manualLocalServicesDelay);
      
      return ResponseModel(
        success: true, 
        message: 'Setlist editado' ,
        model: ''
      );

    } catch (e) {

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en SetlistsLocalSource método [editSetlist]');

      return ResponseModel(
        success: false,
        message: 'Ocurrió un problema al editar el setlist'
      );

    }

   
  }


 

}