import 'package:budgetapps/model/Task.dart';
import 'package:budgetapps/pages/notified_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:get/get.dart';
class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    _configurationLocalTime();
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@drawable/icon_not');



    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,

    );

    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        );
  }
  Future selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
    Get.to(()=>NotifiedPage(label: payload));
  }
  scheduledNotification(int min,int hour,Task task) async {
    print("notification function");
    print(tz.TZDateTime.now(tz.local));

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      task.title,
      task.note,
      _convertTime(hour,min),

      // tz.TZDateTime.now(tz.local).add( Duration(seconds: 5)),
      const NotificationDetails(
          android: AndroidNotificationDetails('your channel id',
            'your channel name',)),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents : DateTimeComponents.time,
      payload: task.title.toString()+"|"+task.note.toString()+"|",
    );

  }
  tz.TZDateTime _convertTime(int hour,int min){
    Duration offsetTime= DateTime.now().timeZoneOffset;
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime sheduledTime = tz.TZDateTime(tz.local,now.year,now.month,now.day,hour,min);
    print("sheduled time is");
    print(sheduledTime);
    if(sheduledTime.isBefore(now)){
      sheduledTime = sheduledTime.add(Duration(days: 1) );
    }

    return sheduledTime.subtract(offsetTime);

  }
  Future<void> _configurationLocalTime() async{
    print("configured");
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }
  displayNotification({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high);

    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics, );
    await flutterLocalNotificationsPlugin.show(
      0,
      'You change your theme',
      'You changed your theme back !',
      platformChannelSpecifics,
      payload: 'It could be anything you pass',
    );
  }
  Future<void> showNotification(int id, String title, String body, int seconds) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
            'main_channel',
            'Main Channel',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@drawable/icon_not'
        ),

      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}