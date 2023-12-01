
import '/presentation/features/songs/edit/models/edit_song_model.dart';
import '/presentation/features/songs/shared/model/song_model.dart';
import '/presentation/providers/providers.dart';
import '/services/songs_service.dart';
import '/utils/extensions/string_extensions.dart';

class EditSongProvider extends SendProvider<SongModel> with FormProvider<EditSongModel>{

  final SongsService _songsService;

  EditSongProvider({
    required SongsService songsService
  }) : _songsService = songsService{
    formModel = EditSongModel();
  }

  void updateFormModel(EditSongModel Function(EditSongModel formModel) update) {
    super.updateInnerFormModel(update,runtimeType.toString());
    notifyListeners();
  }

  void editGenre() async {
    applyStatus(SendStatus.loading);
    final response = await _songsService.editSong(
      editSongModel: formModel
    );
    if(response.isFailed){
      message = response.message!;
      return applyStatus(SendStatus.failed);
    }
    message = response.message!;
    model = response.model!;
    formModel = EditSongModel();
    isFormValid = formModel.isValid;
    return applyStatus(SendStatus.success);
  }

  void resetFormModel(){
    updateFormModel((formModel) => EditSongModel());
  }

  void initFormModel({required SongModel songModel}){
    super.updateInnerFormModel((formModel) => formModel.copyWith(
      id: songModel.id,
      title: songModel.title.capitalize(),
      lyric: songModel.lyric.capitalize(),
      ownerId: songModel.ownerId
    ),runtimeType.toString());
  }

}