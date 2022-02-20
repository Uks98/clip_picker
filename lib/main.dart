import 'package:clip_picker/style/color_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'my_clip.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl_standalone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

final supportedLocales = [
  Locale('ko','KR'),
  Locale('en','US'),
];

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  tz.initializeTimeZones(); // 추가
  await findSystemLocale();
  await Firebase.initializeApp();
    initializeDateFormatting().then((_) => runApp(
        EasyLocalization(
          fallbackLocale: Locale('en','Us'),
          child: MyApp(
        ),supportedLocales: supportedLocales, path: "translations",)));

  WidgetsFlutterBinding.ensureInitialized();
  const AndroidNotificationChannel androidNotificationChannel =
  AndroidNotificationChannel('study', 'studyapp', 'studyapp');
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidNotificationChannel);
}

class MyApp extends StatelessWidget {

  MyApp({Key key}) : super(key: key);
  final analytics = FirebaseAnalytics();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      builder: (context,child) => MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor:1.0 ), child: child),
      home: SplashScreenView(
        home: MyClip(),
        duration: 1000,
        imageSize: 230,
        text:"똑똑하게 기록하자.".tr(),
        textStyle: TextStyle(color: Palette.textColor1,fontSize: 16),
        imageSrc: "lib/assets/icons.png",
        backgroundColor: Palette.backgroundColor,
      ),
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Study Picker',
      theme: ThemeData(
        fontFamily: "dream",
      ),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics)
      ],
    );
  }
}
