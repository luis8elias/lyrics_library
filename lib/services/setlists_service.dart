import 'package:flutter_guid/flutter_guid.dart';

import '/data/data_sources/local/setlists_local_source.dart';
import '/data/models/response_model.dart';
import '/presentation/features/setlists/create/models/create_setlist_model.dart';
import '/presentation/features/setlists/edit/models/edit_setlist_model.dart';
import '/presentation/features/setlists/shared/models/setlist_model.dart';

class SetlistsService {
  final SetlistsLocalSource _localSource;

  SetlistsService({
    required SetlistsLocalSource localSource
  }) : _localSource = localSource;

  Future<ResponseModel<List<SetlistModel>?>> fetchSetlists() async {
    return _localSource.fetchSetlists();
  }

  Future<ResponseModel<SetlistModel?>> createSetlist({
    required CreateSetlistModel createGenreModel
  }) async {
    return _localSource.createSetlist(createSetlistModel: createGenreModel);
  }

  Future<ResponseModel<String>> deleteSetlist({
    required List<Guid> genresIds
  }) async {
    return _localSource.deleteSetlists(
      setlistsIds: genresIds
    );
  }

  Future<ResponseModel<String?>> editSetlist({
    required EditSetlistModel editSetlistModel
  }) async {
    return _localSource.editSetlist(editSetlistModel: editSetlistModel);
  }
}