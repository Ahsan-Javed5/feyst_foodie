import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';

import 'package:chef/constants/constants.dart';
import 'package:chef/screens/screen.dart';
import 'package:chef/screens/sign_up/get_started_screen_v.dart';

import '../../screens/sign_up/sign_up_screen_v.dart';

export 'router.gr.dart';

abstract class Routes {
  static const login = '/login';
  static const signUp = '/signUp';
  static const forgotPassword = '/forgotPassword';
  static const splash = '/splash';
  static const customers = '/customers';
  static const activities = '/activitys';
  static const recordListApprover = '/recordapprovers';
  static const projects = '/projects';
  static const workspaces = '/workspaces';
  static const modules = '/modules';
  static const home = '/home';
  static const profile = '/profile';
  static const dashboard = '/dashboard';
  static const forms = '/forms/';
  static const records = '/forms/:formId';
  static const customForm = '/custom_form/:${Strings.formIdParam}';
  static const innerCheckListItem = '/inner_checklist_item';
  static const qrScanner = '/qr_scanner';
  static const mainProfile = '/main_profile';
  static const profileSwitcher = '/profile_switcher';
  static const profileInformation = '/profile_information';
  static const changePassword = '/change_password';
  static const accountSettings = '/account_settings';
  static const getStartedScreen = '/get_started_screen';
}

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: SplashScreen,
      initial: true,
    ),
    AutoRoute(
      page: GetStartedScreen,
      path: Routes.getStartedScreen,
    ),
    AutoRoute(
      page: SignUpScreen,
      path: Routes.signUp,
    ),
    AutoRoute(
      page: ForgotPasswordScreen,
      path: Routes.forgotPassword,
    ),
    // AutoRoute(
    //   page: HomeScreen,
    //   path: Routes.home,
    // ),
    RedirectRoute(
      path: '*',
      redirectTo: '/',
    ),
  ],
)
class $AppRouter {}
