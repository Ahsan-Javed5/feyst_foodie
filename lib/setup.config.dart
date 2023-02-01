// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'app.dart' as _i16;
import 'base/screen_layout_base/screen_layout_base_vm.dart' as _i8;
import 'helpers/helpers.dart' as _i9;
import 'helpers/workspace_helper.dart' as _i12;
import 'screens/account_settings/account_settings_screen_vm.dart' as _i15;
import 'screens/change_password/change_password_screen_vm.dart' as _i17;
import 'screens/forgot_password/forgot_password_screen_vm.dart' as _i18;
import 'screens/home/home_screen_vm.dart' as _i19;
import 'screens/sign_up/sign_up_screen_vm.dart' as _i10;
import 'screens/splash/splash_screen_vm.dart' as _i11;
import 'screens/username_profile/profile_information_screen_vm.dart' as _i7;
import 'services/application_state.dart' as _i14;
import 'services/renderer/field_renderer.dart' as _i4;
import 'services/services.dart' as _i3;
import 'services/storage/storage_service.dart' as _i13;
import 'setup.dart' as _i20;
import 'theme/theme.dart' as _i5; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i4.FieldRenderer>(
      () => _i4.FieldRenderer(fieldInputData: get<Map<String, dynamic>>()));
  gh.singleton<_i5.IAppThemeData>(registerModule.theme);
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
  gh.factory<_i6.Key>(() => registerModule.key);
  gh.factory<_i7.ProfileInformationScreenViewModel>(
      () => _i7.ProfileInformationScreenViewModel(
            navigation: get<_i3.INavigationService<dynamic>>(),
            appService: get<_i3.ApplicationService>(),
          ));
  gh.factory<_i8.ScreenLayoutBaseViewModel>(() => _i8.ScreenLayoutBaseViewModel(
        appService: get<_i9.ApplicationService>(),
        storage: get<_i9.IStorageService>(),
        workspaceHelper: get<_i9.WorkspaceHelper>(),
      ));
  gh.factory<_i10.SignUpScreenViewModel>(() => _i10.SignUpScreenViewModel(
        navigation: get<_i9.INavigationService<dynamic>>(),
        network: get<_i9.INetworkService<dynamic>>(),
        storage: get<_i9.IStorageService>(),
        appService: get<_i9.ApplicationService>(),
      ));
  gh.factory<_i11.SplashScreenViewModel>(() => _i11.SplashScreenViewModel(
        navigationService: get<_i3.INavigationService<dynamic>>(),
        storage: get<_i3.IStorageService>(),
        appService: get<_i3.ApplicationService>(),
      ));
  gh.factory<_i12.WorkspaceHelper>(() => _i12.WorkspaceHelper(
        storage: get<_i13.IStorageService>(),
        appService: get<_i14.ApplicationService>(),
      ));
  gh.factory<_i15.AccountSettingsScreenViewModel>(
      () => _i15.AccountSettingsScreenViewModel(
            storage: get<_i3.IStorageService>(),
            navigation: get<_i3.INavigationService<dynamic>>(),
          ));
  gh.singleton<_i16.App>(_i16.App(
    appThemeData: get<_i5.IAppThemeData>(),
    appRouter: get<_i3.AppRouter>(),
    key: get<_i6.Key>(),
  ));
  gh.factory<_i17.ChangePasswordScreenViewModel>(() =>
      _i17.ChangePasswordScreenViewModel(
          navigation: get<_i3.INavigationService<dynamic>>()));
  gh.factory<_i18.ForgotPasswordScreenViewModel>(() =>
      _i18.ForgotPasswordScreenViewModel(
          navigation: get<_i3.INavigationService<dynamic>>()));
  gh.factory<_i19.HomeScreenViewModel>(() => _i19.HomeScreenViewModel(
        navigation: get<_i3.INavigationService<dynamic>>(),
        storage: get<_i3.IStorageService>(),
        appService: get<_i3.ApplicationService>(),
      ));
  return get;
}

class _$RegisterModule extends _i20.RegisterModule {
  @override
  _i6.UniqueKey get key => _i6.UniqueKey();
}
