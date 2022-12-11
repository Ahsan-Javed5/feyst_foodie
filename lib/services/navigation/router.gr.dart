// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../../screens/screen.dart' as _i1;
import '../../screens/sign_up/sign_up_screen_v.dart' as _i2;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      final args = routeData.argsAs<SplashRouteArgs>(
          orElse: () => const SplashRouteArgs());
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.SplashScreen(key: args.key),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.LoginScreen(key: args.key),
      );
    },
    SignUpRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpRouteArgs>(
          orElse: () => const SignUpRouteArgs());
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.SignUpScreen(key: args.key),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ForgotPasswordRouteArgs>();
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.ForgotPasswordScreen(
          baseUrl: args.baseUrl,
          key: args.key,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.HomeScreen(key: args.key),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          SplashRoute.name,
          path: '/',
        ),
        _i3.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i3.RouteConfig(
          SignUpRoute.name,
          path: '/signUp',
        ),
        _i3.RouteConfig(
          ForgotPasswordRoute.name,
          path: '/forgotPassword',
        ),
        _i3.RouteConfig(
          HomeRoute.name,
          path: '/home',
        ),
        _i3.RouteConfig(
          '*#redirect',
          path: '*',
          redirectTo: '/',
          fullMatch: true,
        ),
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashRoute extends _i3.PageRouteInfo<SplashRouteArgs> {
  SplashRoute({_i4.Key? key})
      : super(
          SplashRoute.name,
          path: '/',
          args: SplashRouteArgs(key: key),
        );

  static const String name = 'SplashRoute';
}

class SplashRouteArgs {
  const SplashRouteArgs({this.key});

  final _i4.Key? key;

  @override
  String toString() {
    return 'SplashRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i1.LoginScreen]
class LoginRoute extends _i3.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i4.Key? key})
      : super(
          LoginRoute.name,
          path: '/login',
          args: LoginRouteArgs(key: key),
        );

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i4.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.SignUpScreen]
class SignUpRoute extends _i3.PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({_i4.Key? key})
      : super(
          SignUpRoute.name,
          path: '/signUp',
          args: SignUpRouteArgs(key: key),
        );

  static const String name = 'SignUpRoute';
}

class SignUpRouteArgs {
  const SignUpRouteArgs({this.key});

  final _i4.Key? key;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i1.ForgotPasswordScreen]
class ForgotPasswordRoute extends _i3.PageRouteInfo<ForgotPasswordRouteArgs> {
  ForgotPasswordRoute({
    required String baseUrl,
    _i4.Key? key,
  }) : super(
          ForgotPasswordRoute.name,
          path: '/forgotPassword',
          args: ForgotPasswordRouteArgs(
            baseUrl: baseUrl,
            key: key,
          ),
        );

  static const String name = 'ForgotPasswordRoute';
}

class ForgotPasswordRouteArgs {
  const ForgotPasswordRouteArgs({
    required this.baseUrl,
    this.key,
  });

  final String baseUrl;

  final _i4.Key? key;

  @override
  String toString() {
    return 'ForgotPasswordRouteArgs{baseUrl: $baseUrl, key: $key}';
  }
}

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i3.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({_i4.Key? key})
      : super(
          HomeRoute.name,
          path: '/home',
          args: HomeRouteArgs(key: key),
        );

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final _i4.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}
