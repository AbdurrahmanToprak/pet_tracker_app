import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/timezone.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap logic here
      },
    );
  }

  // Make these notification channels static
  static const AndroidNotificationDetails feedingChannel =
      AndroidNotificationDetails(
    'feeding_channel',
    'Feeding Notifications',
    channelDescription: 'Evcil hayvanınız için beslenme hatırlatmaları',
    importance: Importance.high,
    priority: Priority.high,
  );

  static const AndroidNotificationDetails medicationChannel =
      AndroidNotificationDetails(
    'medication_channel',
    'Medication Notifications',
    channelDescription: 'Evcil hayvanınızın ilaç hatırlatmaları',
    importance: Importance.high,
    priority: Priority.high,
  );

  static const AndroidNotificationDetails exerciseChannel =
      AndroidNotificationDetails(
    'exercise_channel',
    'Exercise Notifications',
    channelDescription: 'Evcil hayvanınızın egzersiz hatırlatmaları',
    importance: Importance.high,
    priority: Priority.high,
  );

  static const AndroidNotificationDetails vetAppointmentChannel =
      AndroidNotificationDetails(
    'vet_appointment_channel',
    'Vet Appointment Notifications',
    channelDescription: 'Evcil hayvanınızın veteriner randevusu hatırlatmaları',
    importance: Importance.high,
    priority: Priority.high,
  );

  // Keep this method static as it accesses static channel members
  static Future<void> scheduleTaskNotification({
    required int id,
    required String title,
    required String body,
    required Time time,
    required String channelType,
  }) async {
    AndroidNotificationDetails selectedChannel =
        feedingChannel; // Default channel

    switch (channelType) {
      case 'feeding':
        selectedChannel = feedingChannel;
        break;
      case 'medication':
        selectedChannel = medicationChannel;
        break;
      case 'exercise':
        selectedChannel = exerciseChannel;
        break;
      case 'vet_appointment':
        selectedChannel = vetAppointmentChannel;
        break;
      default:
        throw ArgumentError('Invalid channel type: $channelType');
    }

    final NotificationDetails details =
        NotificationDetails(android: selectedChannel);

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _convertTimeToTZDateTime(time),
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static TZDateTime _convertTimeToTZDateTime(Time time) {
    final now = TZDateTime.now(tz.local);
    final scheduledDate = TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    return scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;
  }
}
