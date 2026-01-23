import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // <--- ESSA LINHA É OBRIGATÓRIA
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> scheduleNotification({
  required String title,
  required String body,
  required DateTime scheduledTime,
}) async {
  const AndroidNotificationDetails androidDetails =
      AndroidNotificationDetails(
        'channel_id_cleaning',
        'Lembretes de Manutenção',
        channelDescription: 'Lembretes de serviço',
        importance: Importance.max,
        priority: Priority.high,
      );

  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidDetails);

  await _notificationsPlugin.zonedSchedule(
    scheduledTime.millisecondsSinceEpoch.remainder(100000),
    title,
    body,
    tz.TZDateTime.from(scheduledTime, tz.local),
    notificationDetails,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  );
}
}