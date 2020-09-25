import 'package:mobx/mobx.dart';

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
  String password;

  @action
  void setEmail(String value) => email = value;

  @action
  void setName(String value) => name = value;

  @action
  void setPhone(String value) => phone = value;

  @action
  void setPassword(String value) => password = value;

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
  String get emailError{

  }
}


