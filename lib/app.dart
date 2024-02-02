import 'package:chef/screens/home/home_screen_v.dart';
import 'package:chef/setup.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:chef/services/services.dart';
import 'package:chef/theme/theme.dart';
import 'package:injectable/injectable.dart';

import 'constants/preferences.dart';

@singleton
class App extends StatelessWidget {
  const App({
    required IAppThemeData appThemeData,
    required AppRouter appRouter,
    Key? key,
  })  : _appThemeData = appThemeData,
        _appRouter = appRouter,
        super(key: key);

  final IAppThemeData _appThemeData;
  final AppRouter _appRouter;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: _appThemeData.colors.secondaryBackground,
        statusBarIconBrightness: _appThemeData.darkBrightness,
      ),
    );
    final loginInfo = locateService<IStorageService>()
        .readString(key: PreferencesKeys.sLoginData);
    if (loginInfo.isNotEmpty) {
      locateService<ApplicationService>().loadPrefData();
    }
    //bool firstLogin = locateService<ApplicationService>().loadPrefData().toString().isEmpty;
    return AppTheme(
        appThemeData: _appThemeData,
        child: FirebasePhoneAuthProvider(
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerDelegate: _appRouter.delegate(initialRoutes: [
              if (loginInfo.isEmpty) const GetStartedRoute() else BottomBar(),
            ]),
            routeInformationParser: _appRouter.defaultRouteParser(),
          ),
        ));
  }
}
