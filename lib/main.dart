import 'package:clip_picker/style/color_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'my_clip.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl_standalone.dart';

final supportedLocales = [
  Locale('ko', 'KR'),
  Locale('en', 'US'),
];

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await findSystemLocale();
  await Firebase.initializeApp();
    initializeDateFormatting().then((_) => runApp(
        EasyLocalization(
          fallbackLocale: Locale('en'),
          child: MyApp(
        ),supportedLocales: supportedLocales, path: "translations",)));

}

class MyApp extends StatelessWidget {

  MyApp({Key key}) : super(key: key);
  final analytics = FirebaseAnalytics();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MaterialApp(
      home: SplashScreenView(
        home: MyClip(),
        duration: 3000,
        imageSize: 230,
        text: "똑똑하게 기록하자.".tr(),
        textStyle: TextStyle(color: Palette.textColor1,fontSize: 16),
        imageSrc: "lib/assets/icons.png",
        backgroundColor: Palette.backgroundColor,
      ),
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Study Picker',
      theme: ThemeData(
        fontFamily: "godo",
      ),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics)
      ],
    );
  }
}
