import '/data/models/response_model.dart';
import '/presentation/providers/fetch_provider.dart';
import '/services/config_service.dart';

class ReadSongProvider extends FetchProvider<double>{

  final ConfigService _configService;

  ReadSongProvider({
    super.autoCall, 
    required ConfigService configService
  }) : _configService = configService;


  @override
  Future<ResponseModel<double>> fetchMethod() {
    return _configService.getFontSize();
  }

  void setNewFontSize(double newFontSize){
    model = newFontSize;
    notifyListeners();
  }

  Future<ResponseModel> saveFontSize() async{
    final saveFontSizeResp = await _configService.setFontSize(
      fontSize: model
    );
    if(saveFontSizeResp.isFailed){
      final getFontSizeResp = await _configService.getFontSize();
      model = getFontSizeResp.model!;
      notifyListeners();
      return saveFontSizeResp;
    }
    return saveFontSizeResp;
  }

}