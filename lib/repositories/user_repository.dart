import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

class UserRepository {
  Future<User> signUp(User user) async {
    final parserUser = ParseUser(user.email, user.password, user.email);
    parserUser.set<String>(keyUserName, user.name);
    parserUser.set(keyUserType, user.type.index);
    parserUser.set<String>(keyUserPhone, user.phone);
    final response = await parserUser.signUp();

    if (response.success) {
      return mapParsetoUser(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<User> loginWithEmail(String email, String password) async {
    final parseUser = ParseUser(email, password, null);

    final response = await parseUser.login();
    print(response.result);

    if (response.success) {
      return mapParsetoUser(response.result);
    }else{
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<User> currentUser() async{
    final parseUser = await ParseUser.currentUser();

    if (parseUser != null){
      final response = await ParseUser.getCurrentUserFromServer(parseUser.sectionToken);
      if (response.success){
        return mapParsetoUser(response.result);
      }else{
        await parseUser.logOut();
      }
    }else{
      return null;
    }
  }

  User mapParsetoUser(ParseUser parseUser) {
    return User(
        id: parseUser.objectId,
        name: parseUser.get(keyUserName),
        email: parseUser.get(keyUserEmail),
        phone: parseUser.get(keyUserPhone),
        type: UserType.values[parseUser.get(keyUserType)],
        createdAt: parseUser.get(keyUserCreatedAt));
  }
}
