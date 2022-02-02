
import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'my_clip.dart';
import 'package:flutter/services.dart';

final supportedLocales = [
  Locale('en', 'US'),
  Locale('ko', 'KR')
];

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();

  runZonedGuarded(()async{
    initializeDateFormatting().then((_) => runApp(
        EasyLocalization(child: MyApp(),supportedLocales: supportedLocales, path: "translations",
        fallbackLocale: Locale("en","US"),)));
  },(error, stackTrace){
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });

}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);
  final analytics = FirebaseAnalytics();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      //localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Study Picker',
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
