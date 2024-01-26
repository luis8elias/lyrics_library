import 'package:flutter_guid/flutter_guid.dart';

import '/data/models/response_model.dart';
import '/presentation/features/setlists/create/models/create_setlist_model.dart';
import '/presentation/features/setlists/edit/models/edit_setlist_model.dart';
import '/presentation/features/setlists/shared/models/setlist_model.dart';
import '/services/session_service.dart';

abstract class SetlistsDataSource{

  final SessionService sessionService;

  SetlistsDataSource({required this.sessionService});

  Future<ResponseModel<List<SetlistModel>?>> fetchSetlists();
  
  Future<ResponseModel<SetlistModel?>> createSetlist({
    required CreateSetlistModel createSetlistModel
  });

  Future<ResponseModel<String>> deleteSetlists({
    required List<Guid> setlistsIds
  });

  Future<ResponseModel<String>> editSetlist({
    required EditSetlistModel editSetlistModel
  });

}