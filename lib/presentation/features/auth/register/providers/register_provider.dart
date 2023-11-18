import '/presentation/providers/providers.dart';
import '/presentation/features/auth/register/models/register_model.dart';
import '/presentation/features/auth/shared/models/auth_model.dart';
import '/services/auth_service.dart';
import '/services/session_service.dart';

class RegisterProvider extends SendProvider<AuthModel?> with FormProvider<RegisterModel>{

  final AuthService _authService;
  final SessionService _sessionService;

  RegisterProvider({
    required AuthService authService,
    required SessionService sessionService,
  })
  :
  _authService = authService,
  _sessionService = sessionService{
    formModel = RegisterModel();
  }


  

  void tryRegister()async{
    applyStatus(SendStatus.loading);
    final loginResp = await _authService.register(registerModel: formModel);
    if(loginResp.isFailed){
      message = loginResp.message!;
      return applyStatus(SendStatus.failed);
    }
    message = loginResp.message!;
    model = loginResp.model!;
    _sessionService.saveAuthModel(authModel: model!);
    _sessionService.setFirstTime();
    return applyStatus(SendStatus.success);
  }

  
  void updateFormModel(RegisterModel Function(RegisterModel formModel) update) {
    super.updateInnerFormModel(update,runtimeType.toString());
    notifyListeners();
  }

}

