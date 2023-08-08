import 'dart:developer';
import 'dart:io';
import 'package:chef/services/renderer/field_renderer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

import 'package:chef/services/services.dart';
import 'package:chef/theme/theme.dart';
import 'package:chef/setup.config.dart';
import 'dart:developer' as developer;

final getIt = GetIt.instance;
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("${message.data['message']}");
// }

@pragma('vm:entry-point')
Future <void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
  await Firebase.initializeApp();
  developer.log(' the hahahaahahahahaha \n\n\n\n\n\n\n${message.notification!.title.toString()}');
  developer.log('${message.notification!.title.toString()}');
  developer.log('${message.data.toString()}');
}

Future<dynamic> configureDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = DevHttpOverrides(); // to ignore ssl certification
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

 // requestPermission();
  return $initGetIt(getIt);
}

// Future<Map<Permission, PermissionStatus>> requestPermission() async {
//   Map<Permission, PermissionStatus> statuses =
//   await [Permission.notification].request();
//   return statuses;
// }

T locateService<T extends Object>() => getIt.get<T>();

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
@module
abstract class RegisterModule {
  static final _appRouter = AppRouter();

  final _navigationService = NavigationService(_appRouter.navigatorKey);

  final _deviceService = DeviceServiceImpl();

  @singleton
  IDeviceService get deviceService => _deviceService;

  @Injectable(as: Key)
  UniqueKey get key;

  @singleton
  IAppThemeData get theme => DefaultTheme();

  @preResolve
  Future<IStorageService> get sharedPreferences async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return SharedPrefs(sharedPreferences: sharedPreferences);
  }

  @singleton
  INavigationService get navigationService => _navigationService;

  @preResolve
  Future<INetworkService> get network async => NetworkCall(
        client: Client(),
        storage: await sharedPreferences,
        appService: await appService,
      );

  @singleton
  AppRouter get appRouter => _appRouter;

  @singleton
  IRendererService get fieldRendererService => FieldRenderer();

  @preResolve
  Future<ApplicationService> get appService async => ApplicationService(
        navigation: navigationService,
        storage: await sharedPreferences,
      );
}
