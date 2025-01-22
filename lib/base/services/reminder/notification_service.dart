import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print("Bildirim Tıklandı: ${details.payload}");
      },
    );
    tz.initializeTimeZones();
  }

  static Future<void> requestPermissions() async {
    final bool? result = await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    if (result == false) {
      print('Bildirim izinleri reddedildi.');
    }
  }

  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    required bool isRecurring,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'reminder_channel',
      'Hatırlatıcılar',
      channelDescription: 'Hatırlatıcı bildirim kanalı',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    tz.TZDateTime tzScheduledDate = tz.TZDateTime.from(
      scheduledDate.toUtc(),
      tz.local,
    );

    if (isRecurring) {
      final currentTime = tz.TZDateTime.now(tz.local);

      if (tzScheduledDate.isBefore(currentTime)) {
        tzScheduledDate = tzScheduledDate.add(Duration(days: 1));
      }
    } else {
      if (tzScheduledDate.isBefore(tz.TZDateTime.now(tz.local))) {
        print('Hatırlatıcı zamanı geçmiş! Lütfen gelecekte bir zaman seçin.');
        return;
      }
    }

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tzScheduledDate,
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
