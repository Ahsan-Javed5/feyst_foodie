// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i11;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'app.dart' as _i26;
import 'base/screen_layout_base/screen_layout_base_vm.dart' as _i18;
import 'helpers/helpers.dart' as _i19;
import 'helpers/workspace_helper.dart' as _i24;
import 'models/models.dart' as _i9;
import 'screens/account_settings/account_settings_screen_vm.dart' as _i25;
import 'screens/change_password/change_password_screen_vm.dart' as _i28;
import 'screens/custom_form/custom_form_screen_vm.dart' as _i32;
import 'screens/custom_form/fields/auto_complete/component/auto_complete_field_vm.dart'
    as _i27;
import 'screens/custom_form/fields/check_box/component/checkbox_list_vm.dart'
    as _i29;
import 'screens/custom_form/fields/check_list/attachments/check_list_attachments_vm.dart'
    as _i4;
import 'screens/custom_form/fields/check_list/component/check_list_vm.dart'
    as _i30;
import 'screens/custom_form/fields/check_list/widgets/check_list_item.dart'
    as _i8;
import 'screens/custom_form/fields/external_field/component/external_field_vm.dart'
    as _i34;
import 'screens/custom_form/fields/radio_button/radio_list_vm.dart' as _i17;
import 'screens/custom_form/fields/select/component/dropdown_vm.dart' as _i33;
import 'screens/custom_form/fields/table/attachments/table_attachments_vm.dart'
    as _i22;
import 'screens/custom_form/fields/table/component/table_vm.dart' as _i23;
import 'screens/custom_form/widgets/custom_field_sidebar/custom_field_sidebar_vm.dart'
    as _i31;
import 'screens/forgot_password/forgot_password_screen_vm.dart' as _i35;
import 'screens/home/home_screen_vm.dart' as _i36;
import 'screens/login/login_screen_vm.dart' as _i14;
import 'screens/navdrawer/navdrawer_vm.dart' as _i15;
import 'screens/sign_up/sign_up_screen_vm.dart' as _i20;
import 'screens/splash/splash_screen_vm.dart' as _i21;
import 'screens/username_profile/profile_information_screen_vm.dart' as _i16;
import 'services/application_state.dart' as _i6;
import 'services/network/network_service.dart' as _i5;
import 'services/renderer/field_renderer.dart' as _i12;
import 'services/services.dart' as _i3;
import 'services/storage/storage_service.dart' as _i7;
import 'setup.dart' as _i37;
import 'theme/theme.dart' as _i13;
import 'ui_kit/exto_ui_kit.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i4.CheckListAttachmentsViewModel>(
      () => _i4.CheckListAttachmentsViewModel(
            network: get<_i5.INetworkService<dynamic>>(),
            appService: get<_i6.ApplicationService>(),
            storageService: get<_i7.IStorageService>(),
          ));
  gh.factory<_i8.CheckListItem>(() => _i8.CheckListItem(
        title: get<String>(),
        id: get<String>(),
        onChange: get<_i3.FieldOnChange>(),
        isInnerItem: get<bool>(),
        items: get<List<_i9.Item>>(),
        subtitle: get<String>(),
        uiType: get<String>(),
        selectedIndex: get<int>(),
        options: get<List<_i9.Option>>(),
        actions: get<List<_i10.ContextMenuAction>>(),
        innerItem: get<_i9.Item>(),
        parentItem: get<_i9.CheckListItem>(),
        itemAttachmentOnTap: get<_i8.ItemAttachmentOnTap>(),
        key: get<_i11.Key>(),
      ));
  gh.lazySingleton<_i12.FieldRenderer>(
      () => _i12.FieldRenderer(fieldInputData: get<Map<String, dynamic>>()));
  gh.singleton<_i13.IAppThemeData>(registerModule.theme);
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
  gh.factory<_i11.Key>(() => registerModule.key);
  gh.factory<_i14.LoginScreenViewModel>(() => _i14.LoginScreenViewModel(
        navigation: get<_i3.INavigationService<dynamic>>(),
        network: get<_i3.INetworkService<dynamic>>(),
        storage: get<_i3.IStorageService>(),
        appService: get<_i3.ApplicationService>(),
      ));
  gh.factory<_i15.NavDrawerViewModel>(() => _i15.NavDrawerViewModel(
        navigation: get<_i3.INavigationService<dynamic>>(),
        storage: get<_i3.IStorageService>(),
        appService: get<_i3.ApplicationService>(),
      ));
  gh.factory<_i16.ProfileInformationScreenViewModel>(
      () => _i16.ProfileInformationScreenViewModel(
            navigation: get<_i3.INavigationService<dynamic>>(),
            appService: get<_i3.ApplicationService>(),
          ));
  gh.factory<_i17.RadioListViewModel>(() => _i17.RadioListViewModel(
        network: get<_i3.INetworkService<dynamic>>(),
        appService: get<_i3.ApplicationService>(),
      ));
  gh.factory<_i18.ScreenLayoutBaseViewModel>(
      () => _i18.ScreenLayoutBaseViewModel(
            appService: get<_i3.ApplicationService>(),
            storage: get<_i3.IStorageService>(),
            workspaceHelper: get<_i19.WorkspaceHelper>(),
          ));
  gh.factory<_i20.SignUpScreenViewModel>(() => _i20.SignUpScreenViewModel(
        navigation: get<_i3.INavigationService<dynamic>>(),
        network: get<_i3.INetworkService<dynamic>>(),
        storage: get<_i3.IStorageService>(),
        appService: get<_i3.ApplicationService>(),
      ));
  gh.factory<_i21.SplashScreenViewModel>(() => _i21.SplashScreenViewModel(
        navigationService: get<_i3.INavigationService<dynamic>>(),
        storage: get<_i3.IStorageService>(),
        appService: get<_i3.ApplicationService>(),
      ));
  gh.factory<_i22.TableAttachmentsViewModel>(
      () => _i22.TableAttachmentsViewModel(
            network: get<_i5.INetworkService<dynamic>>(),
            appService: get<_i6.ApplicationService>(),
            storageService: get<_i7.IStorageService>(),
          ));
  gh.factory<_i23.TableViewModel>(() => _i23.TableViewModel(
        network: get<_i3.INetworkService<dynamic>>(),
        renderer: get<_i3.IRendererService<dynamic, dynamic>>(),
        storage: get<_i3.IStorageService>(),
        appService: get<_i3.ApplicationService>(),
      ));
  gh.factory<_i24.WorkspaceHelper>(() => _i24.WorkspaceHelper(
        storage: get<_i7.IStorageService>(),
        appService: get<_i6.ApplicationService>(),
      ));
  gh.factory<_i25.AccountSettingsScreenViewModel>(
      () => _i25.AccountSettingsScreenViewModel(
            storage: get<_i3.IStorageService>(),
            navigation: get<_i3.INavigationService<dynamic>>(),
          ));
  gh.singleton<_i26.App>(_i26.App(
    appThemeData: get<_i13.IAppThemeData>(),
    appRouter: get<_i3.AppRouter>(),
    key: get<_i11.Key>(),
  ));
  gh.factory<_i27.AutoCompleteFieldViewModel>(
      () => _i27.AutoCompleteFieldViewModel(
            network: get<_i3.INetworkService<dynamic>>(),
            navigation: get<_i3.INavigationService<dynamic>>(),
            storage: get<_i3.IStorageService>(),
          ));
  gh.factory<_i28.ChangePasswordScreenViewModel>(() =>
      _i28.ChangePasswordScreenViewModel(
          navigation: get<_i3.INavigationService<dynamic>>()));
  gh.factory<_i29.CheckBoxListViewModel>(() => _i29.CheckBoxListViewModel(
        network: get<_i3.INetworkService<dynamic>>(),
        appService: get<_i3.ApplicationService>(),
      ));
  gh.factory<_i30.CheckListViewModel>(() => _i30.CheckListViewModel(
        network: get<_i3.INetworkService<dynamic>>(),
        renderer: get<_i3.IRendererService<dynamic, dynamic>>(),
        appService: get<_i3.ApplicationService>(),
      ));
  gh.factory<_i31.CustomFieldSideBarViewModel>(
      () => _i31.CustomFieldSideBarViewModel(
            appState: get<_i3.ApplicationService>(),
            network: get<_i3.INetworkService<dynamic>>(),
            storageService: get<_i3.IStorageService>(),
            renderer: get<_i3.IRendererService<dynamic, dynamic>>(),
          ));
  gh.factory<_i32.CustomFormScreenViewModel>(
      () => _i32.CustomFormScreenViewModel(
            network: get<_i3.INetworkService<dynamic>>(),
            navigationService: get<_i3.INavigationService<dynamic>>(),
            storage: get<_i3.IStorageService>(),
            renderer: get<_i3.IRendererService<dynamic, dynamic>>(),
            appService: get<_i3.ApplicationService>(),
          ));
  gh.factory<_i33.DropdownViewModel>(() => _i33.DropdownViewModel(
        network: get<_i3.INetworkService<dynamic>>(),
        appService: get<_i3.ApplicationService>(),
      ));
  gh.factory<_i34.ExternalFieldViewModel>(() => _i34.ExternalFieldViewModel(
        network: get<_i3.INetworkService<dynamic>>(),
        navigation: get<_i3.INavigationService<dynamic>>(),
      ));
  gh.factory<_i35.ForgotPasswordScreenViewModel>(() =>
      _i35.ForgotPasswordScreenViewModel(
          navigation: get<_i3.INavigationService<dynamic>>()));
  gh.factory<_i36.HomeScreenViewModel>(() => _i36.HomeScreenViewModel(
        navigation: get<_i3.INavigationService<dynamic>>(),
        storage: get<_i3.IStorageService>(),
        appService: get<_i3.ApplicationService>(),
      ));
  return get;
}

class _$RegisterModule extends _i37.RegisterModule {
  @override
  _i11.UniqueKey get key => _i11.UniqueKey();
}
