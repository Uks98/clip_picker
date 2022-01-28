
import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'my_clip.dart';
import 'package:flutter/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runZonedGuarded(()async{
    initializeDateFormatting().then((_) => runApp(MyApp()));
  },(error, stackTrace){
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });

}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);
  final analytics = FirebaseAnalytics();
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
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics)
      ],
    );
  }
}
