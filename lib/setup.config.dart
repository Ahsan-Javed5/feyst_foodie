// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/foundation.dart' as _i7;
import 'package:flutter/material.dart' as _i20;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'app.dart' as _i19;
import 'base/screen_layout_base/screen_layout_base_vm.dart' as _i30;
import 'helpers/helpers.dart' as _i10;
import 'helpers/workspace_helper.dart' as _i15;
import 'screens/account_settings/account_settings_screen_vm.dart' as _i18;
import 'screens/booking/advance_payment/food_item_advance_payment_vm.dart'
    as _i26;
import 'screens/booking/booking_confirmed/booking_in_process_screen_vm.dart'
    as _i21;
import 'screens/booking/booking_list/booking_list_screen_vm.dart' as _i22;
import 'screens/change_password/change_password_screen_vm.dart' as _i23;
import 'screens/food_product_experience_details/food_product_details_screen_vm.dart'
    as _i27;
import 'screens/forgot_password/forgot_password_screen_vm.dart' as _i28;
import 'screens/home/component/food_detail_screen_vm.dart' as _i25;
import 'screens/home/home_screen_vm.dart' as _i29;
import 'screens/sign_in/sign_in_screen_vm.dart' as _i9;
import 'screens/sign_up/get_started_screen_vm.dart' as _i13;
import 'screens/sign_up/questionire/sign_up_questionire_screen_vm.dart' as _i11;
import 'screens/sign_up/sign_up_screen_vm.dart' as _i12;
import 'screens/splash/splash_screen_vm.dart' as _i14;
import 'screens/user_account/edit_profie/edit_profile_screen_vm.dart' as _i24;
import 'screens/username_profile/profile_information_screen_vm.dart' as _i8;
import 'services/application_state.dart' as _i17;
import 'services/navigation/app_router.dart' as _i3;
import 'services/renderer/field_renderer.dart' as _i5;
import 'services/services.dart' as _i4;
import 'services/storage/storage_service.dart' as _i16;
import 'setup.dart' as _i31;
import 'theme/theme.dart' as _i6;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.AppRouter>(() => registerModule.appRouter);
  await gh.factoryAsync<_i4.ApplicationService>(
    () => registerModule.appService,
    preResolve: true,
  );
  gh.lazySingleton<_i5.FieldRenderer>(
      () => _i5.FieldRenderer(fieldInputData: gh<Map<String, dynamic>>()));
  gh.singleton<_i6.IAppThemeData>(() => registerModule.theme);
  gh.singleton<_i4.IDeviceService>(() => registerModule.deviceService);
  gh.singleton<_i4.INavigationService<dynamic>>(
      () => registerModule.navigationService);
  await gh.factoryAsync<_i4.INetworkService<dynamic>>(
    () => registerModule.network,
    preResolve: true,
  );
  gh.singleton<_i4.IRendererService<dynamic, dynamic>>(
      () => registerModule.fieldRendererService);
  await gh.factoryAsync<_i4.IStorageService>(
    () => registerModule.sharedPreferences,
    preResolve: true,
  );
  gh.factory<_i7.Key>(() => registerModule.key);
  gh.factory<_i8.ProfileInformationScreenViewModel>(
      () => _i8.ProfileInformationScreenViewModel(
            navigation: gh<_i4.INavigationService<dynamic>>(),
            appService: gh<_i4.ApplicationService>(),
          ));
  gh.factory<_i9.SignInScreenViewModel>(() => _i9.SignInScreenViewModel(
        navigation: gh<_i10.INavigationService<dynamic>>(),
        network: gh<_i10.INetworkService<dynamic>>(),
        storage: gh<_i10.IStorageService>(),
        appService: gh<_i10.ApplicationService>(),
      ));
  gh.factory<_i11.SignUpQuestionnaireScreenViewModel>(
      () => _i11.SignUpQuestionnaireScreenViewModel(
            network: gh<_i10.INetworkService<dynamic>>(),
            appService: gh<_i10.ApplicationService>(),
          ));
  gh.factory<_i12.SignUpScreenViewModel>(() => _i12.SignUpScreenViewModel(
        navigation: gh<_i10.INavigationService<dynamic>>(),
        network: gh<_i10.INetworkService<dynamic>>(),
        storage: gh<_i10.IStorageService>(),
        appService: gh<_i10.ApplicationService>(),
      ));
  gh.factory<_i13.SignUpScreenViewModel>(() => _i13.SignUpScreenViewModel());
  gh.factory<_i14.SplashScreenViewModel>(() => _i14.SplashScreenViewModel(
        navigationService: gh<_i4.INavigationService<dynamic>>(),
        storage: gh<_i4.IStorageService>(),
        appService: gh<_i4.ApplicationService>(),
      ));
  gh.factory<_i15.WorkspaceHelper>(() => _i15.WorkspaceHelper(
        storage: gh<_i16.IStorageService>(),
        appService: gh<_i17.ApplicationService>(),
      ));
  gh.factory<_i18.AccountSettingsScreenViewModel>(
      () => _i18.AccountSettingsScreenViewModel(
            storage: gh<_i4.IStorageService>(),
            navigation: gh<_i4.INavigationService<dynamic>>(),
          ));
  gh.singleton<_i19.App>(() => _i19.App(
        appThemeData: gh<_i6.IAppThemeData>(),
        appRouter: gh<_i4.AppRouter>(),
        key: gh<_i20.Key>(),
      ));
  gh.factory<_i21.BookingInProcessScreenViewModel>(() =>
      _i21.BookingInProcessScreenViewModel(
          network: gh<_i10.INetworkService<dynamic>>()));
  gh.factory<_i22.BookingListScreenViewModel>(() =>
      _i22.BookingListScreenViewModel(
          network: gh<_i10.INetworkService<dynamic>>()));
  gh.factory<_i23.ChangePasswordScreenViewModel>(() =>
      _i23.ChangePasswordScreenViewModel(
          navigation: gh<_i4.INavigationService<dynamic>>()));
  gh.factory<_i24.EditProfileScreenViewModel>(
      () => _i24.EditProfileScreenViewModel(
            navigation: gh<_i10.INavigationService<dynamic>>(),
            network: gh<_i10.INetworkService<dynamic>>(),
            storage: gh<_i10.IStorageService>(),
            appService: gh<_i10.ApplicationService>(),
          ));
  gh.factory<_i25.FoodDetailScreenViewModel>(
      () => _i25.FoodDetailScreenViewModel(
            navigation: gh<_i10.INavigationService<dynamic>>(),
            network: gh<_i10.INetworkService<dynamic>>(),
            storage: gh<_i10.IStorageService>(),
            appService: gh<_i10.ApplicationService>(),
          ));
  gh.factory<_i26.FoodItemAdvancePaymentViewModel>(() =>
      _i26.FoodItemAdvancePaymentViewModel(
          network: gh<_i10.INetworkService<dynamic>>()));
  gh.factory<_i27.FoodProductExperienceDetailsViewModel>(
      () => _i27.FoodProductExperienceDetailsViewModel(
            navigation: gh<_i10.INavigationService<dynamic>>(),
            network: gh<_i10.INetworkService<dynamic>>(),
            storage: gh<_i10.IStorageService>(),
            appService: gh<_i10.ApplicationService>(),
          ));
  gh.factory<_i28.ForgotPasswordScreenViewModel>(() =>
      _i28.ForgotPasswordScreenViewModel(
          navigation: gh<_i4.INavigationService<dynamic>>()));
  gh.factory<_i29.HomeScreenViewModel>(() => _i29.HomeScreenViewModel(
        navigation: gh<_i4.INavigationService<dynamic>>(),
        storage: gh<_i4.IStorageService>(),
        appService: gh<_i4.ApplicationService>(),
        network: gh<_i4.INetworkService<dynamic>>(),
      ));
  gh.factory<_i30.ScreenLayoutBaseViewModel>(
      () => _i30.ScreenLayoutBaseViewModel(
            appService: gh<_i10.ApplicationService>(),
            storage: gh<_i10.IStorageService>(),
            workspaceHelper: gh<_i10.WorkspaceHelper>(),
          ));
  return getIt;
}

class _$RegisterModule extends _i31.RegisterModule {
  @override
  _i7.UniqueKey get key => _i7.UniqueKey();
}
