import '/services/config_service.dart';

import '/data/models/response_model.dart';
import '/presentation/providers/fetch_provider.dart';

class ChangeFontSizeProvider extends FetchProvider<double>{
  final ConfigService _configService;

  ChangeFontSizeProvider({
    super.autoCall, 
    required ConfigService configService
  }) : _configService = configService;

  bool isSaveLoading = false;
  bool showSnackbar = false;
  ResponseModel? responseModel;
  
  @override
  Future<ResponseModel<double>> fetchMethod() {
    return _configService.getFontSize();
  }

  void changeFontSize(double newValue){
    model = newValue;
    notifyListeners();
  }

  Future<void> saveFontSize() async{
    isSaveLoading = true;
    notifyListeners();
    showSnackbar = true;
    await Future.delayed(const Duration(milliseconds: 500));
    final resp = await _configService.setFontSize(fontSize: model);
    responseModel = resp;
    isSaveLoading = false;
    notifyListeners();
  }

  void resetShowSanckbar(){
    showSnackbar = false;
  }

}