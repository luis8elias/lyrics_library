import '/presentation/features/setlists/create/models/create_setlist_model.dart';
import '/presentation/features/setlists/shared/models/setlist_model.dart';
import '/presentation/providers/providers.dart';
import '/services/setlists_service.dart';

class CreateSetlistProvider extends SendProvider<SetlistModel?> with FormProvider<CreateSetlistModel>{

  final SetlistsService _setlistsService;

  CreateSetlistProvider({
    required SetlistsService setlistsService
  }) : _setlistsService = setlistsService{
    formModel = CreateSetlistModel();
  }

  void updateFormModel(CreateSetlistModel Function(CreateSetlistModel formModel) update) {
    super.updateInnerFormModel(update,runtimeType.toString());
    notifyListeners();
  }

  void createSetlist() async {
    applyStatus(SendStatus.loading);
    final response = await _setlistsService.createSetlist(
      createGenreModel: formModel
    );
    if(response.isFailed){
      message = response.message!;
      return applyStatus(SendStatus.failed);
    }
    message = response.message!;
    model = response.model!;
    formModel = CreateSetlistModel();
    isFormValid = formModel.isValid;
    return applyStatus(SendStatus.success);
  }

  void resetFormModel(){
    updateFormModel((formModel) => CreateSetlistModel());
  }

}