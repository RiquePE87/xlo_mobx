import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';

part 'signup_store.g.dart';

class SignupStore = _SignupStore with _$SignupStore;

abstract class _SignupStore with Store{

  @observable
  String name;

  @observable
  String email;

  @observable
  String phone;

  @observable
  String password1;

  @observable
  String password2;


  @action
  void setEmail(String value) => email = value;

  @action
  void setName(String value) => name = value;

  @action
  void setPhone(String value) => phone = value;

  @action
  void setPassword1(String value) => password1 = value;

  @action
  void setPassword2(String value) => password2 = value;


  @computed
  bool get nameValid => name != null && name.length > 6;
  String get nameError{
    if (name == null || nameValid)
      return null;
    else if (name.isEmpty)
      return "Campo Obrigatório!";
    else
      return "Nome muito curto";
  }

  @computed
  bool get emailValid => email != null && email.isEmailValid();
  String get emailError{
    if (email == null || emailValid){
      return null;
    }else if (email.isEmpty){
      return "Campo Obrigatório";
    }else{
      return "E-mail inválido";
    }
  }

  @computed
  bool get phoneValid => phone != null && phone.length >= 14;
  String get phoneError{
    if (phone == null || phoneValid){
      return null;
    }else if (phone.isEmpty){
      return "Campo Obrigatório";
    }else{
      return "Celular inválido";
    }
  }

  @computed
  bool get password1Valid => password1 != null && password1.length >= 6;
  String get password1Error{
    if (password1 == null || password1Valid){
      return null;
    }else if (password1.isEmpty){
      return "Campo Obrigatório";
    }else{
      return "Senha Inválida!";
    }
  }

  @computed
  bool get password2Valid => password1 != null && password1 == password2;
  String get password2Error{
    if (password2 == null || password2Valid){
      return null;
    }else{
      return "Senhas não coincidem";
    }
  }
  @computed
  bool get isFormValid => nameValid && emailValid && phoneValid && password1Valid && password2Valid;
}


