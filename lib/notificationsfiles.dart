import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class Notifications {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  showNotification(var title, var body, var payload) async {
    var android = new AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platforms = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(0, title, body, platforms,
        payload: 'Welcome to the Local Notification demo ');
  }

// Schudule Notifications
  Future<void> scheduleNotification(
    var title,
    var body,
  ) async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 5));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
      icon: 'feasturent',
      // playSound: true,
      priority: Priority.high,
      importance: Importance.max,
      // sound:"test_sound.mp3",
      largeIcon: DrawableResourceAndroidBitmap('feasturent'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    // ignore: deprecated_member_use
    await flutterLocalNotificationsPlugin.schedule(0, title, body,
        scheduledNotificationDateTime, platformChannelSpecifics);
    Future.delayed(Duration.zero, () {
      FlutterRingtonePlayer.playNotification(asAlarm: true);
    });
  }

  Future<void> showBigPictureNotification(var contenttitle, var summary,
      var bigtexttitle, var body, var image) async {
    var bigPictureStyleInformation = BigPictureStyleInformation(
        DrawableResourceAndroidBitmap("feasturent"),
        largeIcon: image,
        contentTitle: contenttitle,
        htmlFormatContentTitle: true,
        summaryText: summary,
        htmlFormatSummaryText: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'big text channel id',
        'big text channel name',
        'big text channel description',
        styleInformation: bigPictureStyleInformation);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: null);
    await flutterLocalNotificationsPlugin.show(
      0,
      bigtexttitle,
      body,
      platformChannelSpecifics,
    );
  }
}
