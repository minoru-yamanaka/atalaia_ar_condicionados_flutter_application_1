import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
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

    // Solicita permissão para Android 13+
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    var scheduledTZDate = tz.TZDateTime.from(scheduledTime, tz.local);

    // Se a data já passou, agenda para daqui a 5 segundos para não dar erro
    if (scheduledTZDate.isBefore(tz.TZDateTime.now(tz.local))) {
      scheduledTZDate = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5));
    }

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'atalaia_channel_id',
      'Agendamentos Atalaia',
      channelDescription: 'Lembretes de manutenção de ar condicionado',
      importance: Importance.max,
      priority: Priority.high,
    );

    await _notificationsPlugin.zonedSchedule(
      scheduledTime.millisecondsSinceEpoch.remainder(100000),
      title,
      body,
      scheduledTZDate,
      const NotificationDetails(android: androidDetails),
      // --- ESTAS DUAS LINHAS ABAIXO SÃO OBRIGATÓRIAS NA VERSÃO 19.x ---
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}