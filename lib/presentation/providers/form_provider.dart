import 'dart:developer';

import '/data/models/form_model.dart';

mixin class FormProvider<T extends FormModel> {

  late T formModel;
  bool isFormValid = false;

  void updateInnerFormModel(
    T Function(T formModel) update,
    String providerName
  ){
    formModel = update(formModel);
    isFormValid = formModel.isValid;
    log('[ $providerName ] Model 👉🏼 ${formModel.toMap().toString()}');
  }

}