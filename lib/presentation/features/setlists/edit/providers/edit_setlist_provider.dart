import '/presentation/features/setlists/edit/models/edit_setlist_model.dart';
import '/presentation/features/setlists/shared/models/setlist_model.dart';
import '/presentation/providers/providers.dart';
import '/services/setlists_service.dart';
import '/utils/extensions/string_extensions.dart';

class EditSetlistProvider extends SendProvider<SetlistModel> with FormProvider<EditSetlistModel>{

  final SetlistsService _setlistsService;

  EditSetlistProvider({
    required SetlistsService setlistsService
  }) : _setlistsService = setlistsService{
    formModel = EditSetlistModel();
  }

  void updateFormModel(EditSetlistModel Function(EditSetlistModel formModel) update) {
    super.updateInnerFormModel(update,runtimeType.toString());
    notifyListeners();
  }

  void editSetlist() async {
    applyStatus(SendStatus.loading);
    final response = await _setlistsService.editSetlist(
      editSetlistModel: formModel
    );
    if(response.isFailed){
      message = response.message!;
      return applyStatus(SendStatus.failed);
    }
    message = response.message!;
    model = SetlistModel.fromEditSetlistModel(formModel);
    formModel = EditSetlistModel();
    isFormValid = formModel.isValid;
    return applyStatus(SendStatus.success);
  }

  void resetFormModel(){
    updateFormModel((formModel) => EditSetlistModel());
  }

  void initFormModel({required SetlistModel setlistModel}){
    super.updateInnerFormModel((formModel) => formModel.copyWith(
      id: setlistModel.id,
      name: setlistModel.name.capitalize(),
      ownerId: setlistModel.ownerId
    ),runtimeType.toString());
  }

}