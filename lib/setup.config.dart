// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'app.dart' as _i19;
import 'base/screen_layout_base/screen_layout_base_vm.dart' as _i11;
import 'helpers/helpers.dart' as _i5;
import 'helpers/workspace_helper.dart' as _i15;
import 'screens/account_settings/account_settings_screen_vm.dart' as _i18;
import 'screens/change_password/change_password_screen_vm.dart' as _i20;
import 'screens/forgot_password/forgot_password_screen_vm.dart' as _i21;
import 'screens/home/component/food_detail_screen_vm.dart' as _i7;
import 'screens/home/home_screen_vm.dart' as _i22;
import 'screens/sign_in/sign_in_screen_vm.dart' as _i12;
import 'screens/sign_up/sign_up_screen_vm.dart' as _i13;
import 'screens/splash/splash_screen_vm.dart' as _i14;
import 'screens/user_account/edit_profie/edit_profile_screen_vm.dart' as _i4;
import 'screens/username_profile/profile_information_screen_vm.dart' as _i10;
import 'services/application_state.dart' as _i17;
import 'services/renderer/field_renderer.dart' as _i6;
import 'services/services.dart' as _i3;
import 'services/storage/storage_service.dart' as _i16;
import 'setup.dart' as _i23;
import 'theme/theme.dart' as _i8; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i4.EditProfileScreenViewModel>(
      () => _i4.EditProfileScreenViewModel(
            navigation: get<_i5.INavigationService<dynamic>>(),
            network: get<_i5.INetworkService<dynamic>>(),
            storage: get<_i5.IStorageService>(),
            appService: get<_i5.ApplicationService>(),
          ));
  gh.lazySingleton<_i6.FieldRenderer>(
      () => _i6.FieldRenderer(fieldInputData: get<Map<String, dynamic>>()));
  gh.factory<_i7.FoodDetailScreenViewModel>(() => _i7.FoodDetailScreenViewModel(
        navigation: get<_i5.INavigationService<dynamic>>(),
        network: get<_i5.INetworkService<dynamic>>(),
        storage: get<_i5.IStorageService>(),
        appService: get<_i5.ApplicationService>(),
      ));
  gh.singleton<_i8.IAppThemeData>(registerModule.theme);
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
  gh.factory<_i9.Key>(() => registerModule.key);
  gh.factory<_i10.ProfileInformationScreenViewModel>(
      () => _i10.ProfileInformationScreenViewModel(
            navigation: get<_i3.INavigationService<dynamic>>(),
            appService: get<_i3.ApplicationService>(),
          ));
  gh.factory<_i11.ScreenLayoutBaseViewModel>(
      () => _i11.ScreenLayoutBaseViewModel(
            appService: get<_i5.ApplicationService>(),
            storage: get<_i5.IStorageService>(),
            workspaceHelper: get<_i5.WorkspaceHelper>(),
          ));
  gh.factory<_i12.SignInScreenViewModel>(() => _i12.SignInScreenViewModel(
        navigation: get<_i5.INavigationService<dynamic>>(),
        network: get<_i5.INetworkService<dynamic>>(),
        storage: get<_i5.IStorageService>(),
        appService: get<_i5.ApplicationService>(),
      ));
  gh.factory<_i13.SignUpScreenViewModel>(() => _i13.SignUpScreenViewModel(
        navigation: get<_i5.INavigationService<dynamic>>(),
        network: get<_i5.INetworkService<dynamic>>(),
        storage: get<_i5.IStorageService>(),
        appService: get<_i5.ApplicationService>(),
      ));
  gh.factory<_i14.SplashScreenViewModel>(() => _i14.SplashScreenViewModel(
        navigationService: get<_i3.INavigationService<dynamic>>(),
        storage: get<_i3.IStorageService>(),
        appService: get<_i3.ApplicationService>(),
      ));
  gh.factory<_i15.WorkspaceHelper>(() => _i15.WorkspaceHelper(
        storage: get<_i16.IStorageService>(),
        appService: get<_i17.ApplicationService>(),
      ));
  gh.factory<_i18.AccountSettingsScreenViewModel>(
      () => _i18.AccountSettingsScreenViewModel(
            storage: get<_i3.IStorageService>(),
            navigation: get<_i3.INavigationService<dynamic>>(),
          ));
  gh.singleton<_i19.App>(_i19.App(
    appThemeData: get<_i8.IAppThemeData>(),
    appRouter: get<_i3.AppRouter>(),
    key: get<_i9.Key>(),
  ));
  gh.factory<_i20.ChangePasswordScreenViewModel>(() =>
      _i20.ChangePasswordScreenViewModel(
          navigation: get<_i3.INavigationService<dynamic>>()));
  gh.factory<_i21.ForgotPasswordScreenViewModel>(() =>
      _i21.ForgotPasswordScreenViewModel(
          navigation: get<_i3.INavigationService<dynamic>>()));
  gh.factory<_i22.HomeScreenViewModel>(() => _i22.HomeScreenViewModel(
        navigation: get<_i3.INavigationService<dynamic>>(),
        storage: get<_i3.IStorageService>(),
        appService: get<_i3.ApplicationService>(),
        network: get<_i3.INetworkService<dynamic>>(),
      ));
  return get;
}

class _$RegisterModule extends _i23.RegisterModule {
  @override
  _i9.UniqueKey get key => _i9.UniqueKey();
}
