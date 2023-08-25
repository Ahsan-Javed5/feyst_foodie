import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:chef/app.dart';
import 'package:chef/setup.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'helpers/notification_service.dart';

//final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

InAppLocalhostServer localhostServer = new InAppLocalhostServer();
void main() async {
  await configureDependencies();
 //await NotificationService().init();
  await localhostServer.start();
  runApp(locateService<App>());
}


