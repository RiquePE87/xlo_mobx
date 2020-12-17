import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:xlo_mobx/repositories/category_repository.dart';
import 'package:xlo_mobx/repositories/ibge_repository.dart';
import 'package:xlo_mobx/screens/base/base_screen.dart';
import 'package:xlo_mobx/screens/category/category_screen.dart';
import 'package:xlo_mobx/stores/category_store.dart';
import 'package:xlo_mobx/stores/pages_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  setupLocators();
  runApp(MyApp());

  IBGERepository().getUFListFromApi().then((value) => print(value));
}

Future<void> initializeParse() async {
  await Parse().initialize("phJeGgQYZhSUFmJ6IWfh1qXsmVoB2dg9zkkNa9GM",
      "https://parseapi.back4app.com/",
      clientKey: "OgxlLATuA3pCOuwYolVLEsSeaIpcL4mDtp43b1d9",
      autoSendSessionId: true,
      debug: true);
}

void setupLocators() {
  GetIt.I.registerSingleton(PagesStore());
  GetIt.I.registerSingleton(UserManagerStore());
  GetIt.I.registerSingleton(CategoryStore());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'XLO',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            cursorColor: Colors.orange,
            primaryColor: Colors.purple,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: AppBarTheme(elevation: 0),
            scaffoldBackgroundColor: Colors.purple),
        home: BaseScreen());
  }
}
