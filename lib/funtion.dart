
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'main.dart';
import 'package:timezone/timezone.dart' as tz;

final now = DateTime.now();

class Alarm{

  Future<bool> initNotification() async {
    if (flutterLocalNotificationsPlugin == null) {
      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    }
    var initSettingAndroid = AndroidInitializationSettings("icons");
    var initiosSetting = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true);
    var initSetting = InitializationSettings(
      android: initSettingAndroid,
      iOS: initiosSetting,
    );
    await flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: (payload) async {});
    setScheduling();
    return true;
  }

  void setScheduling() {
    var android = AndroidNotificationDetails('study', 'studyapp', 'studyapp',
        importance: Importance.max, priority: Priority.max);
    var ios = IOSNotificationDetails();
    NotificationDetails details =
    NotificationDetails(iOS: ios, android: android);
    flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        "Study Picker",
        "오늘한 공부를 기록으로 남겨보는건 어떨까요?🔥".tr(),
        tz.TZDateTime.from(
            DateTime(now.year, now.month, now.day, 21, 0), tz.local),
        details,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        payload: "studyapp",
        matchDateTimeComponents: DateTimeComponents.time);
  }
}