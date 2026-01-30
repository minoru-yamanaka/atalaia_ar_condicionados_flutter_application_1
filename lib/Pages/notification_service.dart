import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin notifications = FlutterLocalNotificationsPlugin();
  static int _notificationId = 0;

  static Future<void> initialize() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Sao_Paulo'));

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: DarwinInitializationSettings(),
    );

    await notifications.initialize(settings);

    final android = notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    
    if (android != null) {
      await android.requestNotificationsPermission();
      await android.requestExactAlarmsPermission();
    }
  }

  // ================= NOTIFICAÇÃO MENSAL (SEM O PARÂMETRO COM ERRO) =================
  static Future<void> scheduleMonthlyNotification({
    int? id,
    required String title,
    required String body,
    required DateTime startDate,
  }) async {
    final int notificationId = id ?? _notificationId++;
    
 
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'monthly_maintenance',
      'Manutenção Mensal',
      channelDescription: 'Lembretes mensais de revisão Atalaia',
      importance: Importance.max,
      priority: Priority.high,
    );
 
    final location = tz.getLocation('America/Sao_Paulo');
    final scheduledTZ = tz.TZDateTime.from(startDate, location);

    // Se o seu Flutter Local Notifications for uma versão que EXIGE o parâmetro,
    // o código abaixo pode dar erro em tempo de execução. 
    // Se isso acontecer, você precisará atualizar o plugin no pubspec.yaml.
    await notifications.zonedSchedule(
      notificationId,
      title,
      body,
      scheduledTZ,
      const NotificationDetails(android: androidDetails, iOS: DarwinNotificationDetails()),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime, // Ativa repetição mensal
    );

    debugPrint("📅 Lembrete Mensal configurado para todo dia ${scheduledTZ.day}");
  }

  // Notificação única (Ex: 1 dia antes)
  static Future<void> scheduleNotificationAt({
    int? id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    final int notificationId = id ?? _notificationId++;
    final location = tz.getLocation('America/Sao_Paulo');
    final scheduledTZ = tz.TZDateTime.from(scheduledDate, location);

    await notifications.zonedSchedule(
      notificationId,
      title,
      body,
      scheduledTZ,
      const NotificationDetails(
        android: AndroidNotificationDetails('atalaia_single', 'Avisos Únicos'),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}