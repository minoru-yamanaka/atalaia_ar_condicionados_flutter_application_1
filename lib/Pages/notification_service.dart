import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> init() async {
//     tz.initializeTimeZones();

//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);

//     await _notificationsPlugin.initialize(initializationSettings);

//     await _notificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.requestNotificationsPermission();
//   }

//   static Future<void> scheduleNotification({
//     required String title,
//     required String body,
//     required DateTime scheduledTime,
//   }) async {
//     var scheduledTZDate = tz.TZDateTime.from(scheduledTime, tz.local);

//     if (scheduledTZDate.isBefore(tz.TZDateTime.now(tz.local))) {
//       scheduledTZDate = tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5));
//     }

//     const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//       'atalaia_channel_id',
//       'Agendamentos Atalaia',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     // SOLUÇÃO: Usando o método zonedSchedule com os parâmetros da v19+
//     await _notificationsPlugin.zonedSchedule(
//       scheduledTime.millisecondsSinceEpoch.remainder(100000),
//       title,
//       body,
//       scheduledTZDate,
//       const NotificationDetails(android: androidDetails),
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      
//     );
//   }
// }



 


class NotificationService {
  static final FlutterLocalNotificationsPlugin notifications = FlutterLocalNotificationsPlugin();
  static int _notificationId = 0;

  /// Inicializa o serviço, configura fusos horários e canais de notificação
  static Future<void> initialize() async {
    tz.initializeTimeZones();
    // Define o fuso horário local para São Paulo
    tz.setLocalLocation(tz.getLocation('America/Sao_Paulo'));

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint("Notificação clicada! Payload: ${response.payload}");
      },
    );
  }

  /// Solicita permissões específicas para Android 13+ e iOS
  static Future<bool> requestPermissions() async {
    // Permissões para Android
    final android = notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    
    if (android != null) {
      // Solicita permissão de postar notificações (Android 13+)
      await android.requestNotificationsPermission();
      // Solicita permissão para alarmes exatos (Android 14+)
      await android.requestExactAlarmsPermission();
    }

    // Permissões para iOS
    final ios = notifications.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    
    if (ios != null) {
      return await ios.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
    }

    return true;
  }

  /// Exibe uma notificação instantânea
  static Future<void> showNotification({
    int? id,
    required String title,
    required String body,
    String? payload,
  }) async {
    final int notificationId = id ?? _notificationId++;

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'main_channel',
      'Notificações Gerais',
      channelDescription: 'Canal principal para notificações instantâneas',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await notifications.show(notificationId, title, body, details, payload: payload);
  }

  /// Agenda uma notificação para uma data e hora específica
 static Future<void> scheduleNotificationAt({
    int? id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    final int notificationId = id ?? _notificationId++;
 
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'scheduled_channel',
      'Scheduled Channel',
      channelDescription: 'Canal para notificações agendadas',
      importance: Importance.max,
      priority: Priority.high,
    );
 
    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();
 
    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
      macOS: iosDetails,
    );
 
    final location = tz.getLocation('America/Sao_Paulo');
 
    final scheduledTZ = tz.TZDateTime(
      location,
      scheduledDate.year,
      scheduledDate.month,
      scheduledDate.day,
      scheduledDate.hour,
      scheduledDate.minute,
      scheduledDate.second,
    );
 
    await notifications.zonedSchedule(
      notificationId,
      title,
      body,
      scheduledTZ,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
    );
    debugPrint("Agendado para");
    debugPrint(scheduledTZ.toString());
    await getPendingNotifications();
  }
  
  /// Cancela uma notificação específica
  static Future<void> cancelNotification(int id) async {
    await notifications.cancel(id);
  }

  /// Limpa todas as notificações agendadas e pendentes
  static Future<void> cancelAllNotifications() async {
    await notifications.cancelAll();
  }

  /// Retorna a lista de notificações que ainda serão disparadas
  static Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    final List<PendingNotificationRequest> pending = await notifications.pendingNotificationRequests();
    debugPrint("Total de notificações pendentes: ${pending.length}");
    return pending;
  }
}
