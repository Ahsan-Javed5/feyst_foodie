import 'dart:io';
import 'package:chef/firebase_messaging/notification_services.dart';
import 'package:chef/services/renderer/field_renderer.dart';
import 'package:chef/ui_kit/widgets/custom_dialog.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'services/navigation/app_router.dart' as nav;
//import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

import 'package:chef/services/services.dart';
import 'package:chef/theme/theme.dart';
import 'package:chef/setup.config.dart';
import 'dart:developer' as developer;

import 'constants/resources.dart';
import 'models/booking/booking_list_response_model.dart';

final getIt = GetIt.instance;
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("${message.data['message']}");
// }

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  NotificationServices().showNotification(message);
}

int notificationCounter = 0;

Future<dynamic> configureDependencies() async {
  HttpOverrides.global = DevHttpOverrides(); // to ignore ssl certification
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  await FirebaseAppCheck.instance.activate(
    //webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.appAttest,
  );
  //await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   NotificationServices().showNotification(message);
  //   CustomDialog.getDialog(
  //     ctx: locateService<INavigationService>().navigatorKey.currentContext,
  //     title: message.data['title']?.toString() ?? 'title is null',
  //     //titleColor: Colors.white,
  //     //descColor: const Color(0xFFfee4a4),
  //     description: message.data['body']?.toString() ?? 'body is null',
  //     iconUrl: Resources.cashWaitingIcon,
  //     onTap: () {
  //       locateService<INavigationService>().pop();
  //     },
  //   );
  // });
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
  //   BookingItem item = BookingItem(id: int.parse(message.data['bookingId']));
  //   locateService<INavigationService>()
  //       .navigateTo(route: nav.FoodItemAdvancePaymentRoute(bookingItem: item));
  // });
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
