
import '/utils/extensions/string_extensions.dart';
import '/presentation/features/genres/edit/models/edit_genre_model.dart';
import '/presentation/features/genres/shared/models/genre_model.dart';
import '/presentation/providers/providers.dart';

import '/services/genres_service.dart';

class EditGenreProvider extends SendProvider<GenreModel> with FormProvider<EditGenreModel>{

  final GenresService _genresService;

  EditGenreProvider({
    required GenresService genresService
  }) : _genresService = genresService{
    formModel = EditGenreModel();
  }

  void updateFormModel(EditGenreModel Function(EditGenreModel formModel) update) {
    super.updateInnerFormModel(update,runtimeType.toString());
    notifyListeners();
  }

  void editGenre() async {
    applyStatus(SendStatus.loading);
    final response = await _genresService.editGenre(
      editGenreModel: formModel
    );
    if(response.isFailed){
      message = response.message!;
      return applyStatus(SendStatus.failed);
    }
    message = response.message!;
    model = GenreModel.fromEditGenreModel(formModel);
    formModel = EditGenreModel();
    isFormValid = formModel.isValid;
    return applyStatus(SendStatus.success);
  }

  void resetFormModel(){
    updateFormModel((formModel) => EditGenreModel());
  }

  void initFormModel({required GenreModel genreModel}){
    super.updateInnerFormModel((formModel) => formModel.copyWith(
      id: genreModel.id,
      name: genreModel.name.capitalize(),
      ownerId: genreModel.ownerId
    ),runtimeType.toString());
  }

}