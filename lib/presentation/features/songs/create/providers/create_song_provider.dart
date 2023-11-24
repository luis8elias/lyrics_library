import 'package:lyrics_library/services/songs_service.dart';

import '/presentation/features/songs/create/models/create_song_model.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/presentation/providers/providers.dart';

class CreateSongProvider extends SendProvider<SongModel?> with FormProvider<CreateSongModel>{

  final SongsService _songsService;

  CreateSongProvider({
    required SongsService songsService
  }) : _songsService = songsService{
    formModel = CreateSongModel();
  }

  void updateFormModel(CreateSongModel Function(CreateSongModel formModel) update) {
    super.updateInnerFormModel(update,runtimeType.toString());
    notifyListeners();
  }

  void createSong() async {
    applyStatus(SendStatus.loading);
    final response = await _songsService.createSong(
      createSongModel: formModel
    );
    if(response.isFailed){
      message = response.message!;
      return applyStatus(SendStatus.failed);
    }
    message = response.message!;
    model = response.model!;
    formModel = CreateSongModel();
    isFormValid = formModel.isValid;
    return applyStatus(SendStatus.success);
  }

  void resetFormModel(){
    updateFormModel((formModel) => CreateSongModel());
  }

}