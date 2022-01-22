import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'my_clip.dart';
import 'package:flutter/services.dart';
void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "godo",
      ),
      home: MyClip(),
    );
  }
}
