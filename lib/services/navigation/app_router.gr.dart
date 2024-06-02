// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    BookingInProcessRouteView.name: (routeData) {
      final args = routeData.argsAs<BookingInProcessRouteViewArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BookingInProcessScreenView(
          bookingItem: args.bookingItem,
          key: args.key,
        ),
      );
    },
    BottomBarRoute.name: (routeData) {
      final args = routeData.argsAs<BottomBarRouteArgs>(
          orElse: () => const BottomBarRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BottomBarScreen(
          key: args.key,
          bottomBarType: args.bottomBarType,
        ),
      );
    },
    FoodItemAdvancePaymentRoute.name: (routeData) {
      final args = routeData.argsAs<FoodItemAdvancePaymentRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BookingItemScreen(
          bookingItem: args.bookingItem,
          key: args.key,
        ),
      );
    },
    FoodItemInProcessBookingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FoodItemInProcessBookingScreen(),
      );
    },
    FoodProductAdvancePendingDetailsRoute.name: (routeData) {
      final args =
          routeData.argsAs<FoodProductAdvancePendingDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: BookingItemDetailsScreen(
          key: args.key,
          advancePendingDetails: args.advancePendingDetails,
        ),
      );
    },
    FoodProductBookingConfirmedDetailsRoute.name: (routeData) {
      final args =
          routeData.argsAs<FoodProductBookingConfirmedDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: FoodProductBookingConfirmedDetailsScreen(
          key: args.key,
          advancePendingDetails: args.advancePendingDetails,
          chefData: args.chefData,
        ),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ForgotPasswordRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ForgotPasswordScreen(
          baseUrl: args.baseUrl,
          key: args.key,
        ),
      );
    },
    GetStartedRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const GetStartedScreen(),
      );
    },
    SignInRoute.name: (routeData) {
      final args = routeData.argsAs<SignInRouteArgs>(
          orElse: () => const SignInRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SignInScreen(key: args.key),
      );
    },
    SignUpRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SignUpScreen(
          args.isProfileDetails,
          key: args.key,
        ),
      );
    },
  };
}

/// generated route for
/// [BookingInProcessScreenView]
class BookingInProcessRouteView
    extends PageRouteInfo<BookingInProcessRouteViewArgs> {
  BookingInProcessRouteView({
    required BookingItem bookingItem,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          BookingInProcessRouteView.name,
          args: BookingInProcessRouteViewArgs(
            bookingItem: bookingItem,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'BookingInProcessRouteView';

  static const PageInfo<BookingInProcessRouteViewArgs> page =
      PageInfo<BookingInProcessRouteViewArgs>(name);
}

class BookingInProcessRouteViewArgs {
  const BookingInProcessRouteViewArgs({
    required this.bookingItem,
    this.key,
  });

  final BookingItem bookingItem;

  final Key? key;

  @override
  String toString() {
    return 'BookingInProcessRouteViewArgs{bookingItem: $bookingItem, key: $key}';
  }
}

/// generated route for
/// [BottomBarScreen]
class BottomBarRoute extends PageRouteInfo<BottomBarRouteArgs> {
  BottomBarRoute({
    Key? key,
    BottomBarType bottomBarType = BottomBarType.home,
    List<PageRouteInfo>? children,
  }) : super(
          BottomBarRoute.name,
          args: BottomBarRouteArgs(
            key: key,
            bottomBarType: bottomBarType,
          ),
          initialChildren: children,
        );

  static const String name = 'BottomBarRoute';

  static const PageInfo<BottomBarRouteArgs> page =
      PageInfo<BottomBarRouteArgs>(name);
}

class BottomBarRouteArgs {
  const BottomBarRouteArgs({
    this.key,
    this.bottomBarType = BottomBarType.home,
  });

  final Key? key;

  final BottomBarType bottomBarType;

  @override
  String toString() {
    return 'BottomBarRouteArgs{key: $key, bottomBarType: $bottomBarType}';
  }
}

/// generated route for
/// [BookingItemScreen]
class FoodItemAdvancePaymentRoute
    extends PageRouteInfo<FoodItemAdvancePaymentRouteArgs> {
  FoodItemAdvancePaymentRoute({
    required BookingItem bookingItem,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          FoodItemAdvancePaymentRoute.name,
          args: FoodItemAdvancePaymentRouteArgs(
            bookingItem: bookingItem,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'FoodItemAdvancePaymentRoute';

  static const PageInfo<FoodItemAdvancePaymentRouteArgs> page =
      PageInfo<FoodItemAdvancePaymentRouteArgs>(name);
}

class FoodItemAdvancePaymentRouteArgs {
  const FoodItemAdvancePaymentRouteArgs({
    required this.bookingItem,
    this.key,
  });

  final BookingItem bookingItem;

  final Key? key;

  @override
  String toString() {
    return 'FoodItemAdvancePaymentRouteArgs{bookingItem: $bookingItem, key: $key}';
  }
}

/// generated route for
/// [FoodItemInProcessBookingScreen]
class FoodItemInProcessBookingRoute extends PageRouteInfo<void> {
  const FoodItemInProcessBookingRoute({List<PageRouteInfo>? children})
      : super(
          FoodItemInProcessBookingRoute.name,
          initialChildren: children,
        );

  static const String name = 'FoodItemInProcessBookingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BookingItemDetailsScreen]
class FoodProductAdvancePendingDetailsRoute
    extends PageRouteInfo<FoodProductAdvancePendingDetailsRouteArgs> {
  FoodProductAdvancePendingDetailsRoute({
    Key? key,
    required AdvancePendingResponse advancePendingDetails,
    List<PageRouteInfo>? children,
  }) : super(
          FoodProductAdvancePendingDetailsRoute.name,
          args: FoodProductAdvancePendingDetailsRouteArgs(
            key: key,
            advancePendingDetails: advancePendingDetails,
          ),
          initialChildren: children,
        );

  static const String name = 'FoodProductAdvancePendingDetailsRoute';

  static const PageInfo<FoodProductAdvancePendingDetailsRouteArgs> page =
      PageInfo<FoodProductAdvancePendingDetailsRouteArgs>(name);
}

class FoodProductAdvancePendingDetailsRouteArgs {
  const FoodProductAdvancePendingDetailsRouteArgs({
    this.key,
    required this.advancePendingDetails,
  });

  final Key? key;

  final AdvancePendingResponse advancePendingDetails;

  @override
  String toString() {
    return 'FoodProductAdvancePendingDetailsRouteArgs{key: $key, advancePendingDetails: $advancePendingDetails}';
  }
}

/// generated route for
/// [FoodProductBookingConfirmedDetailsScreen]
class FoodProductBookingConfirmedDetailsRoute
    extends PageRouteInfo<FoodProductBookingConfirmedDetailsRouteArgs> {
  FoodProductBookingConfirmedDetailsRoute({
    Key? key,
    required AdvancePendingResponse advancePendingDetails,
    required ChefDataResponse chefData,
    List<PageRouteInfo>? children,
  }) : super(
          FoodProductBookingConfirmedDetailsRoute.name,
          args: FoodProductBookingConfirmedDetailsRouteArgs(
            key: key,
            advancePendingDetails: advancePendingDetails,
            chefData: chefData,
          ),
          initialChildren: children,
        );

  static const String name = 'FoodProductBookingConfirmedDetailsRoute';

  static const PageInfo<FoodProductBookingConfirmedDetailsRouteArgs> page =
      PageInfo<FoodProductBookingConfirmedDetailsRouteArgs>(name);
}

class FoodProductBookingConfirmedDetailsRouteArgs {
  const FoodProductBookingConfirmedDetailsRouteArgs({
    this.key,
    required this.advancePendingDetails,
    required this.chefData,
  });

  final Key? key;

  final AdvancePendingResponse advancePendingDetails;

  final ChefDataResponse chefData;

  @override
  String toString() {
    return 'FoodProductBookingConfirmedDetailsRouteArgs{key: $key, advancePendingDetails: $advancePendingDetails, chefData: $chefData}';
  }
}

/// generated route for
/// [ForgotPasswordScreen]
class ForgotPasswordRoute extends PageRouteInfo<ForgotPasswordRouteArgs> {
  ForgotPasswordRoute({
    required String baseUrl,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ForgotPasswordRoute.name,
          args: ForgotPasswordRouteArgs(
            baseUrl: baseUrl,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static const PageInfo<ForgotPasswordRouteArgs> page =
      PageInfo<ForgotPasswordRouteArgs>(name);
}

class ForgotPasswordRouteArgs {
  const ForgotPasswordRouteArgs({
    required this.baseUrl,
    this.key,
  });

  final String baseUrl;

  final Key? key;

  @override
  String toString() {
    return 'ForgotPasswordRouteArgs{baseUrl: $baseUrl, key: $key}';
  }
}

/// generated route for
/// [GetStartedScreen]
class GetStartedRoute extends PageRouteInfo<void> {
  const GetStartedRoute({List<PageRouteInfo>? children})
      : super(
          GetStartedRoute.name,
          initialChildren: children,
        );

  static const String name = 'GetStartedRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignInScreen]
class SignInRoute extends PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SignInRoute.name,
          args: SignInRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const PageInfo<SignInRouteArgs> page = PageInfo<SignInRouteArgs>(name);
}

class SignInRouteArgs {
  const SignInRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SignInRouteArgs{key: $key}';
  }
}

/// generated route for
/// [SignUpScreen]
class SignUpRoute extends PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({
    required bool isProfileDetails,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SignUpRoute.name,
          args: SignUpRouteArgs(
            isProfileDetails: isProfileDetails,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const PageInfo<SignUpRouteArgs> page = PageInfo<SignUpRouteArgs>(name);
}

class SignUpRouteArgs {
  const SignUpRouteArgs({
    required this.isProfileDetails,
    this.key,
  });

  final bool isProfileDetails;

  final Key? key;

  @override
  String toString() {
    return 'SignUpRouteArgs{isProfileDetails: $isProfileDetails, key: $key}';
  }
}
