import '/presentation/features/auth/login/models/login_model.dart';
import '/presentation/features/auth/shared/models/auth_model.dart';
import '/presentation/providers/providers.dart';
import '/services/auth_service.dart';
import '/services/session_service.dart';

class LoginProvider extends SendProvider<AuthModel> with FormProvider<LoginModel> {

  final AuthService _authService;
  final SessionService _sessionService;

  LoginProvider({
    required AuthService authService,
    required SessionService sessionService,
  })
  :
  _authService = authService,
  _sessionService = sessionService{
    formModel = LoginModel();
  }

  void tryLogin() async {
    applyStatus(SendStatus.loading);
    final loginResp = await _authService.login(loginModel: formModel);
    if(loginResp.isFailed){
      message = loginResp.message!;
      return applyStatus(SendStatus.failed);
    }
    message = loginResp.message!;
    model = loginResp.model!;
    await _sessionService.saveAuthModel(authModel: loginResp.model!);
    await _sessionService.setFirstTime();
    return applyStatus(SendStatus.success);
  }

  void updateFormModel(LoginModel Function(LoginModel formModel) update) {
    super.updateInnerFormModel(update,runtimeType.toString());
    notifyListeners();
  }

}