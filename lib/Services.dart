import 'dart:math';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notificationmanager extends StatelessWidget {
  const Notificationmanager({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class LocalNotification {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //initialize the local notification
  static Future init() async {
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher_adaptive_fore');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) {});
  }

  //show a simple notification
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

  Future initializetimezone() async {
    tz.initializeTimeZones();
  }

//scheduling random notifications
  Future<void> scheduleRandomNotification(List<String> notificationList) async {
    await initializetimezone();
    final Random random = Random();
    DateTime dt = DateTime.now();

//converting DateTime to TZDateTime
    final scheduledTime = tz.TZDateTime.from(dt, tz.local);

// random days between 0 and 29
    final int randomDays = random.nextInt(30);
    // random hours between 0 and 24
    final int randomHours = random.nextInt(24);
    //random minutes between 0 and 59
    final int randomMinutes = random.nextInt(60);

//setting schedule time to set random day, hour and minutes
    final updatedScheduledTime = scheduledTime.add(
        Duration(days: randomDays, hours: randomHours, minutes: randomMinutes));

    if (updatedScheduledTime.isBefore(dt)) {
      //If the scheduled time is in the pas, add one day to it
      updatedScheduledTime.add(const Duration(days: 1));
    }

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Random Notification',
      notificationList[random.nextInt(notificationList.length)],
      updatedScheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'random_channel_id',
          'Random Channel',
          importance: Importance.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // cancel all Notifications

  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
