import '/presentation/features/genres/create/models/create_genre_model.dart';
import '/presentation/providers/providers.dart';

import '/services/genres_service.dart';


class CreateGenreProvider extends SendProvider<String?> with FormProvider<CreateGenreModel>{

  final GenresService _genresService;

  CreateGenreProvider({
    required GenresService genresService
  }) : _genresService = genresService{
    formModel = CreateGenreModel();
  }

  void updateFormModel(CreateGenreModel Function(CreateGenreModel formModel) update) {
    super.updateInnerFormModel(update,runtimeType.toString());
    notifyListeners();
  }

  void createGenre() async {
    applyStatus(SendStatus.loading);
    final response = await _genresService.createGenre(
      createGenreModel: formModel
    );
    if(response.isFailed){
      message = response.message!;
      return applyStatus(SendStatus.failed);
    }
    message = response.message!;
    model = response.model!;
    formModel = CreateGenreModel();
    isFormValid = formModel.isValid;
    return applyStatus(SendStatus.success);
  }

  void resetFormModel(){
    updateFormModel((formModel) => CreateGenreModel());
  }

}