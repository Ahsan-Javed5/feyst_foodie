import 'package:auto_route/auto_route.dart';

import '../../constants/strings.dart';
import '../../helpers/helpers.dart';
import '../../models/booking/advance_pending_response.dart';
import '../../models/booking/booking_list_response_model.dart';
import '../../models/home/chef_data_response.dart';
import '../../screens/booking/advance_payment/booking_item_screen_v.dart';
import '../../screens/booking/booking_confirmed/booking_in_process_screen_v.dart';
import '../../screens/booking/booking_in_process_screen.dart';
import '../../screens/booking/booking_item_detail_screen.dart';
import '../../screens/bottom_bar/bottom_bar.dart';
import '../../screens/forgot_password/forgot_password_screen_v.dart';
import '../../screens/home/food_item_booking_confirmed.dart';
import '../../screens/sign_in/sign_in_screen_v.dart';
import '../../screens/sign_up/get_started_screen_v.dart';

part 'app_router.gr.dart';

abstract class Routes {
  static const login = '/login';
  static const signUp = '/signUp';
  static const bottomBar = '/bottomBar';
  static const forgotPassword = '/forgotPassword';
  static const splash = '/splash';
  static const home = '/home';
  static const profile = '/profile';
  static const dashboard = '/dashboard';
  static const bookingItemDetailsScreen =
      '/bookingItemDetailsScreen/:advancePendingDetails';
  static const bookingItemScreen = '/bookingItemScreen/:bookingItem';

  static const foodInProcessScreen = '/foodInProcessScreen/:bookedItem';

  static const foodItemInProcessScreen = '/foodItemInProcessScreen';
  static const foodProductBookingConfirmedDetailsScreen =
      '/foodProductBookingConfirmedDetailsScreen/:bookingConfirmedDetails';
  static const records = '/forms/:formId';
  static const customForm = '/custom_form/:${Strings.formIdParam}';
  static const mainProfile = '/main_profile';
  static const profileSwitcher = '/profile_switcher';
  static const profileInformation = '/profile_information';
  static const changePassword = '/change_password';
  static const accountSettings = '/account_settings';
  static const getStartedScreen = '/get_started_screen';
}

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// routes go here
        // AutoRoute(
        //   page: SplashScreen,
        //   initial: true,
        // ),
        AutoRoute(
          page: GetStartedRoute.page,
          initial: true,
          //path: Routes.getStartedScreen,
        ),
        AutoRoute(
          page: SignUpRoute.page,
          path: Routes.signUp,
        ),
        AutoRoute(
          page: ForgotPasswordRoute.page,
          path: Routes.forgotPassword,
        ),
        AutoRoute(
          page: SignInRoute.page,
          path: Routes.login,
        ),
        AutoRoute(
          page: BookingItemDetailsRoute.page,
          path: Routes.bookingItemDetailsScreen,
        ),

        AutoRoute(
          page: BookingItemRoute.page,
          path: Routes.bookingItemScreen,
        ),
        AutoRoute(
          page: BookingInProcessRouteView.page,
          path: Routes.foodInProcessScreen,
        ),

        AutoRoute(
          page: FoodItemInProcessBookingRoute.page,
          path: Routes.foodItemInProcessScreen,
        ),

        AutoRoute(
          page: FoodProductBookingConfirmedDetailsRoute.page,
          path: Routes.foodProductBookingConfirmedDetailsScreen,
        ),

        AutoRoute(
          page: BottomBarRoute.page,
          path: Routes.bottomBar,
        ),
        // AutoRoute(
        //   page: HomeScreen,
        //   path: Routes.home,
        // ),
        RedirectRoute(
          path: '*',
          redirectTo: '/',
        ),
      ];
}
