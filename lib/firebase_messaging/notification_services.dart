import 'dart:io';
import 'dart:math';

import 'package:chef/helpers/helpers.dart';
import 'package:chef/screens/food_product_experience_details/food_product_details_screen_v.dart';
import 'package:chef/screens/home/home_screen_v.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('user granted provisiona permission');
    } else {
      print('user denied permission');
    }
  }

  void initLocalNotifications(BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings = const AndroidInitializationSettings('@drawable/ic_launcher');
    var iosInitializationSettings = const IOSInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings,
        iOS: iosInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onSelectNotification: (payload) {
        handleMessage(context, message);
      },
    );
  }

  void fireBaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode){
        //developer.log('\n\n\n\n\nfirebaseinit\n${message.notification!.title.toString()}');
        //developer.log('firebase init body:${message.notification!.body.toString()}');
       // developer.log('firebase init payload is:\n\n${message.data.toString()}');

      }
      if(Platform.isAndroid ){
        initLocalNotifications(context, message);
        showNotification(message);
      }
      else{
        showNotification(message);
      }


    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        'High Importance Notifications',
        importance: Importance.high,
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
            channel.id.toString(),
            channel.name.toString(),
            channelDescription: 'your channel description',
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'ticker');

    IOSNotificationDetails iosNotificationDetails =  const IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: iosNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification?.title.toString(),
          message.notification?.body.toString(),
          notificationDetails);
    });
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    developer.log('FCM token is \n ${token}');
    return token!;
  }



  Future<void> setupInteractMessage(BuildContext context) async{

    // when app is terminated
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null){
      handleMessage(context, initialMessage);
    }
    // when app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message){

    if(message.data['type'] == ['msj']){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>HomeScreen())
      );
    }
    else{
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>HomeScreen())
      );
    }

  }

}




















