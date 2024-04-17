// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// import '../main.dart';
//
// class NotificationService {
//   static final NotificationService _notificationService =
//   NotificationService._internal();
//
//   factory NotificationService() {
//     return _notificationService;
//   }
//
//   NotificationService._internal();
//
//   Future<void> init() async {
//     final AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@minmap/LaunchImage.png');
//
//     final IOSInitializationSettings initializationSettingsIOS =
//     IOSInitializationSettings(
//       requestSoundPermission: false,
//       requestBadgePermission: false,
//       requestAlertPermission: false,
//       //onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//     );
//
//     final InitializationSettings initializationSettings =
//     InitializationSettings(
//         android: initializationSettingsAndroid,
//         iOS: initializationSettingsIOS,
//         macOS: null);
//
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         //onSelectNotification: selectNotification
//     );
//   }
//
//
//   Future selectNotification(String payload) async {
//     //Handle notification tapped logic here
//   }
//
//   AndroidNotificationDetails androidPlatformChannelSpecifics =
//   const AndroidNotificationDetails(
//      '123',
//     'abc',
//     'nothing'
//   );
//
// }
