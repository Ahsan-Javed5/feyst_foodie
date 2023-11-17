import 'dart:convert';

import 'package:chef/screens/home/home_screen_v.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



Future <void> handleBackgroundMessage(RemoteMessage message) async {
  developer.log('title of message:.................${message.notification?.title}');
  developer.log('body of message:.................${message.notification?.body}');
  developer.log('pay load of message:.................${message.data}');
}

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'this channel is used for important notifications',
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();






  void handleMessage(RemoteMessage? message){
    if (message == null){
      developer.log('................................................message is nulll');
      return;
    }
    else{
      developer.log('...................................................not nulll');
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomeScreenView()),
      // );
      // // navigatorkey.currentState?.pushNamed(
      // //   HomeScreenView(),
      // //   arguments:message,
      // // );
    }

  }





  Future initLocalNotifications() async {
    developer.log('................................................................init local notification function');

    const iOS = IOSInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(
        android: android,
        iOS: iOS
    );

    await _localNotifications.initialize(
      settings,
      onSelectNotification: (payload){
        final message = RemoteMessage.fromMap(jsonDecode(payload!));
        handleMessage(message);
      }
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
    AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }






  Future initPushNotifications() async {
    developer.log('................................................................init push notification function');
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/ic_launcher',
            ),
          ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }





  Future<void> initNotifications()async{
    await _firebaseMessaging.requestPermission();
    final FCMToken = await _firebaseMessaging.getToken();
    developer.log('FCM token is>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${FCMToken}');
    initPushNotifications();
    initLocalNotifications();
    //FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
