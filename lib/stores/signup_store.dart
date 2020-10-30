import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

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

  @observable
  bool loading = false;

  @observable
  String error;

  @action
  void setloading (bool value) => loading = value;

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

  @computed
  Function get signUpPressed => (isFormValid && !loading) ? _signUp : null;

  @action
  Future<void> _signUp() async{
    loading = true;
    final user = User(name: name, email: email, phone: phone, password: password1);
    try {
      final resultUser = await UserRepository().signUp(user);
      GetIt.I<UserManagerStore>().setUser(resultUser);
    } catch (e) {
      error = e;
    }
    loading = false;
  }
}


