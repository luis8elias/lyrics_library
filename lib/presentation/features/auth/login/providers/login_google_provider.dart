import '/presentation/providers/providers.dart';
import '/services/auth_service.dart';
import '/services/session_service.dart';

class LoginGoogleProvider extends SendProvider<dynamic>{

  final AuthService _authService;
  final SessionService _sessionService;

  LoginGoogleProvider({
    required AuthService authService,
    required SessionService sessionService,
  })
  :
  _authService = authService,
  _sessionService = sessionService;

  void tryLoginWithGoogle() async {
    applyStatus(SendStatus.loading);
    await  Future.delayed(const Duration(seconds: 3));
    final loginResp = await _authService.loginGoogle();
    if(loginResp.isFailed){
      message = loginResp.message!;
      return applyStatus(SendStatus.failed);
    }
    message = loginResp.message!;
    model = loginResp.model!;
    await _sessionService.saveAuthModel(authModel: loginResp.model!.authModel);
    await _sessionService.setFirstTime();
    return applyStatus(SendStatus.success);
  }

}