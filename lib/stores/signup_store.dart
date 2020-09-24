import 'package:mobx/mobx.dart';

part 'signup_store.g.dart';

class SignupStore = _SignupStore with _$SignupStore;

abstract class _SignupStore with Store{

  @observable
  String name;

  @action
  void setName(String value) => name = value;

  @computed
  String get nameError{
    if (name != null && name.length > 6)
      return null;
    else if (name == null || name.isEmpty)
      return "Campo Obrigatório!";
    else
      return "Nome muito curto";
  }
}


