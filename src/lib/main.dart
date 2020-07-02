import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:flutterAnimatedSwitcher/src/store/theme.dart';
import 'package:flutterAnimatedSwitcher/src/app/anaSayfa.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

final ThemeStore themeStore = ThemeStore();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: themeStore.darkMode == true ? ThemeData.dark() : ThemeData.light(),
          home: AnaSayfa(),
        );
      },
    );
  }
}
