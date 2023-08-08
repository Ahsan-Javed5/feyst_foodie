import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:chef/app.dart';
import 'package:chef/setup.dart';

import 'helpers/notification_service.dart';

//final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  await configureDependencies();
 //await NotificationService().init();
  runApp(locateService<App>());
}


