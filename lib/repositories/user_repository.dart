import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

class UserRepository {
  Future<void> signUp(User user) async {
    final parserUser = ParseUser(user.email, user.password, user.email);
    parserUser.set<String>(keyUserName, user.name);
    parserUser.set(keyUserType, user.type.index);
    parserUser.set<String>(keyUserPhone, user.phone);
    final response = await parserUser.signUp();

    if (response.success) {
      print(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }
}
