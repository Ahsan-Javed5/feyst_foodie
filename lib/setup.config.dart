// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'app.dart' as _i18;
import 'base/screen_layout_base/screen_layout_base_vm.dart' as _i9;
import 'helpers/helpers.dart' as _i10;
import 'helpers/workspace_helper.dart' as _i14;
import 'screens/account_settings/account_settings_screen_vm.dart' as _i17;
import 'screens/change_password/change_password_screen_vm.dart' as _i19;
import 'screens/custom_form/widgets/custom_field_sidebar/custom_field_sidebar_vm.dart'
    as _i20;
import 'screens/forgot_password/forgot_password_screen_vm.dart' as _i21;
import 'screens/home/home_screen_vm.dart' as _i22;
import 'screens/login/login_screen_vm.dart' as _i7;
import 'screens/sign_up/get_started_screen_vm.dart' as _i11;
import 'screens/sign_up/sign_up_screen_vm.dart' as _i12;
import 'screens/splash/splash_screen_vm.dart' as _i13;
import 'screens/username_profile/profile_information_screen_vm.dart' as _i8;
import 'services/application_state.dart' as _i16;
import 'services/renderer/field_renderer.dart' as _i4;
import 'services/services.dart' as _i3;
import 'services/storage/storage_service.dart' as _i15;
import 'setup.dart' as _i23;
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
  gh.factory<_i7.LoginScreenViewModel>(() => _i7.LoginScreenViewModel(
        navigation: get<_i3.INavigationService<dynamic>>(),
        network: get<_i3.INetworkService<dynamic>>(),
        storage: get<_i3.IStorageService>(),
        appService: get<_i3.ApplicationService>(),
      ));
  gh.factory<_i8.ProfileInformationScreenViewModel>(
      () => _i8.ProfileInformationScreenViewModel(
            navigation: get<_i3.INavigationService<dynamic>>(),
            appService: get<_i3.ApplicationService>(),
          ));
  gh.factory<_i9.ScreenLayoutBaseViewModel>(() => _i9.ScreenLayoutBaseViewModel(
        appService: get<_i3.ApplicationService>(),
        storage: get<_i3.IStorageService>(),
        workspaceHelper: get<_i10.WorkspaceHelper>(),
      ));
  gh.factory<_i11.SignUpScreenViewModel>(() => _i11.SignUpScreenViewModel());
  gh.factory<_i12.SignUpScreenViewModel>(() => _i12.SignUpScreenViewModel(
        navigation: get<_i3.INavigationService<dynamic>>(),
        network: get<_i3.INetworkService<dynamic>>(),
        storage: get<_i3.IStorageService>(),
        appService: get<_i3.ApplicationService>(),
      ));
  gh.factory<_i13.SplashScreenViewModel>(() => _i13.SplashScreenViewModel(
        navigationService: get<_i3.INavigationService<dynamic>>(),
        storage: get<_i3.IStorageService>(),
        appService: get<_i3.ApplicationService>(),
      ));
  gh.factory<_i14.WorkspaceHelper>(() => _i14.WorkspaceHelper(
        storage: get<_i15.IStorageService>(),
        appService: get<_i16.ApplicationService>(),
      ));
  gh.factory<_i17.AccountSettingsScreenViewModel>(
      () => _i17.AccountSettingsScreenViewModel(
            storage: get<_i3.IStorageService>(),
            navigation: get<_i3.INavigationService<dynamic>>(),
          ));
  gh.singleton<_i18.App>(_i18.App(
    appThemeData: get<_i5.IAppThemeData>(),
    appRouter: get<_i3.AppRouter>(),
    key: get<_i6.Key>(),
  ));
  gh.factory<_i19.ChangePasswordScreenViewModel>(() =>
      _i19.ChangePasswordScreenViewModel(
          navigation: get<_i3.INavigationService<dynamic>>()));
  gh.factory<_i20.CustomFieldSideBarViewModel>(
      () => _i20.CustomFieldSideBarViewModel(
            appState: get<_i3.ApplicationService>(),
            network: get<_i3.INetworkService<dynamic>>(),
            storageService: get<_i3.IStorageService>(),
            renderer: get<_i3.IRendererService<dynamic, dynamic>>(),
          ));
  gh.factory<_i21.ForgotPasswordScreenViewModel>(() =>
      _i21.ForgotPasswordScreenViewModel(
          navigation: get<_i3.INavigationService<dynamic>>()));
  gh.factory<_i22.HomeScreenViewModel>(() => _i22.HomeScreenViewModel(
        navigation: get<_i3.INavigationService<dynamic>>(),
        storage: get<_i3.IStorageService>(),
        appService: get<_i3.ApplicationService>(),
      ));
  return get;
}

class _$RegisterModule extends _i23.RegisterModule {
  @override
  _i6.UniqueKey get key => _i6.UniqueKey();
}
