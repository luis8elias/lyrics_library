import 'package:flutter_guid/flutter_guid.dart';

import '/presentation/providers/send_provider.dart';
import '/services/setlists_service.dart';

class DeleteSetlistsProvider extends SendProvider<String?>{
  final SetlistsService _setlistsService;

  DeleteSetlistsProvider({
    required SetlistsService setlistsService
  }) : _setlistsService = setlistsService;

  Future<void> deleteSetlists({
    required List<Guid> genresIds
  }) async {

    applyStatus(SendStatus.loading);
    final deleteGenreResp = await _setlistsService.deleteSetlist(
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