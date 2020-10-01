import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';


part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store{
  
  @observable
  String email ;

  @action
  void setEmail (String value) => email = value;

  @observable
  String password ;

  @action
  void setPassword (String value) => password = value;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @computed
  bool get emailValid => email != null && email.isEmailValid();
  String get emailError{
    if (email == null || emailValid){
      return null;
    }else{
      return "E-mail inválido";
    }
  }

  @computed
  bool get passwordValid => password != null && password.length >= 6;
  String get passwordError{
    if (password == null || passwordValid){
      return null;
    }else{
      return "Senha Inválida!";
    }
  }

  @computed
  Function get loginPressed => emailValid && passwordValid && !loading ? _login : null;

  @action
  Future<void> _login() async{
  loading = true;
  await UserRepository().loginWithEmail(email, password);
  loading = false;
  }
}


