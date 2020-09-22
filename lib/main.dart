import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:xlo_mobx/screens/base/base_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  runApp(MyApp());
}

Future<void> initializeParse() async {
  await Parse().initialize("phJeGgQYZhSUFmJ6IWfh1qXsmVoB2dg9zkkNa9GM",
      "https://parseapi.back4app.com/",
      clientKey: "OgxlLATuA3pCOuwYolVLEsSeaIpcL4mDtp43b1d9",
      autoSendSessionId: true,
      debug: true);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XLO',
      home: BaseScreen()
    );
  }
}
