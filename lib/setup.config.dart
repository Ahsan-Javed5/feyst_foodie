// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i12;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'app.dart' as _i23;
import 'base/screen_layout_base/screen_layout_base_vm.dart' as _i14;
import 'helpers/helpers.dart' as _i7;
import 'helpers/workspace_helper.dart' as _i19;
import 'screens/account_settings/account_settings_screen_vm.dart' as _i22;
import 'screens/booking/booking_list/booking_list_screen_vm.dart' as _i4;
import 'screens/change_password/change_password_screen_vm.dart' as _i24;
import 'screens/food_product_experience_details/food_product_details_screen_vm.dart'
    as _i10;
import 'screens/forgot_password/forgot_password_screen_vm.dart' as _i25;
import 'screens/home/component/food_detail_screen_vm.dart' as _i9;
import 'screens/home/home_screen_vm.dart' as _i26;
import 'screens/sign_in/sign_in_screen_vm.dart' as _i15;
import 'screens/sign_up/questionire/sign_up_questionire_screen_vm.dart' as _i16;
import 'screens/sign_up/sign_up_screen_vm.dart' as _i17;
import 'screens/splash/splash_screen_vm.dart' as _i18;
import 'screens/user_account/edit_profie/edit_profile_screen_vm.dart' as _i6;
import 'screens/username_profile/profile_information_screen_vm.dart' as _i13;
import 'services/application_state.dart' as _i21;
import 'services/network/network_service.dart' as _i5;
import 'services/renderer/field_renderer.dart' as _i8;
import 'services/services.dart' as _i3;
import 'services/storage/storage_service.dart' as _i20;
import 'setup.dart' as _i27;
import 'theme/theme.dart' as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.AppRouter>(registerModule.appRouter);
  await gh.factoryAsync<_i3.ApplicationService>(
    () => registerModule.appService,
    preResolve: true,
  );
  gh.factory<_i4.BookingListScreenViewModel>(() =>
      _i4.BookingListScreenViewModel(
          network: get<_i5.INetworkService<dynamic>>()));
  gh.factory<_i6.EditProfileScreenViewModel>(
      () => _i6.EditProfileScreenViewModel(
            navigation: get<_i7.INavigationService<dynamic>>(),
            network: get<_i7.INetworkService<dynamic>>(),
            storage: get<_i7.IStorageService>(),
            appService: get<_i7.ApplicationService>(),
          ));
  gh.lazySingleton<_i8.FieldRenderer>(
      () => _i8.FieldRenderer(fieldInputData: get<Map<String, dynamic>>()));
  gh.factory<_i9.FoodDetailScreenViewModel>(() => _i9.FoodDetailScreenViewModel(
        navigation: get<_i7.INavigationService<dynamic>>(),
        network: get<_i7.INetworkService<dynamic>>(),
        storage: get<_i7.IStorageService>(),
        appService: get<_i7.ApplicationService>(),
      ));
  gh.factory<_i10.FoodProductExperienceDetailsViewModel>(
      () => _i10.FoodProductExperienceDetailsViewModel(
            navigation: get<_i7.INavigationService<dynamic>>(),
            network: get<_i7.INetworkService<dynamic>>(),
            storage: get<_i7.IStorageService>(),
            appService: get<_i7.ApplicationService>(),
          ));
  gh.singleton<_i11.IAppThemeData>(registerModule.theme);
  gh.singleton<_i3.IDeviceService>(registerModule.deviceService);
  gh.singleton<_i3.INavigationService<dynamic>>(
      registerModule.navigationService);
  await gh.factoryAsync<_i3.INetworkService<dynamic>>(
    () => registerModule.network,
    preResolve: true,
  );
  gh.singleton<_i3.IRendererService<dynamic, dynamic>>(
      registerModule.fieldRendererService);
  await gh.factoryAsync<_i3.IStorageService>(
    () => registerModule.sharedPreferences,
    preResolve: true,
  );
  gh.factory<_i12.Key>(() => registerModule.key);
  gh.factory<_i13.ProfileInformationScreenViewModel>(
      () => _i13.ProfileInformationScreenViewModel(
            navigation: get<_i3.INavigationService<dynamic>>(),
            appService: get<_i3.ApplicationService>(),
          ));
  gh.factory<_i14.ScreenLayoutBaseViewModel>(
      () => _i14.ScreenLayoutBaseViewModel(
            appService: get<_i7.ApplicationService>(),
            storage: get<_i7.IStorageService>(),
            workspaceHelper: get<_i7.WorkspaceHelper>(),
          ));
  gh.factory<_i15.SignInScreenViewModel>(() => _i15.SignInScreenViewModel(
        navigation: get<_i7.INavigationService<dynamic>>(),
        network: get<_i7.INetworkService<dynamic>>(),
        storage: get<_i7.IStorageService>(),
        appService: get<_i7.ApplicationService>(),
      ));
  gh.factory<_i16.SignUpQuestionnaireScreenViewModel>(() =>
      _i16.SignUpQuestionnaireScreenViewModel(
          network: get<_i5.INetworkService<dynamic>>()));
  gh.factory<_i17.SignUpScreenViewModel>(() => _i17.SignUpScreenViewModel(
        navigation: get<_i7.INavigationService<dynamic>>(),
        network: get<_i7.INetworkService<dynamic>>(),
        storage: get<_i7.IStorageService>(),
        appService: get<_i7.ApplicationService>(),
      ));
  gh.factory<_i18.SplashScreenViewModel>(() => _i18.SplashScreenViewModel(
        navigationService: get<_i3.INavigationService<dynamic>>(),
        storage: get<_i3.IStorageService>(),
        appService: get<_i3.ApplicationService>(),
      ));
  gh.factory<_i19.WorkspaceHelper>(() => _i19.WorkspaceHelper(
        storage: get<_i20.IStorageService>(),
        appService: get<_i21.ApplicationService>(),
      ));
  gh.factory<_i22.AccountSettingsScreenViewModel>(
      () => _i22.AccountSettingsScreenViewModel(
            storage: get<_i3.IStorageService>(),
            navigation: get<_i3.INavigationService<dynamic>>(),
          ));
  gh.singleton<_i23.App>(_i23.App(
    appThemeData: get<_i11.IAppThemeData>(),
    appRouter: get<_i3.AppRouter>(),
    key: get<_i12.Key>(),
  ));
  gh.factory<_i24.ChangePasswordScreenViewModel>(() =>
      _i24.ChangePasswordScreenViewModel(
          navigation: get<_i3.INavigationService<dynamic>>()));
  gh.factory<_i25.ForgotPasswordScreenViewModel>(() =>
      _i25.ForgotPasswordScreenViewModel(
          navigation: get<_i3.INavigationService<dynamic>>()));
  gh.factory<_i26.HomeScreenViewModel>(() => _i26.HomeScreenViewModel(
        navigation: get<_i3.INavigationService<dynamic>>(),
        storage: get<_i3.IStorageService>(),
        appService: get<_i3.ApplicationService>(),
        network: get<_i3.INetworkService<dynamic>>(),
      ));
  return get;
}

class _$RegisterModule extends _i27.RegisterModule {
  @override
  _i12.UniqueKey get key => _i12.UniqueKey();
}
