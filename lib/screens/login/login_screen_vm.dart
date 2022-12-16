import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:chef/base/base.dart';
import 'package:chef/constants/constants.dart';
import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/login/login_request.dart';
import 'package:chef/models/login/login_response.dart';
import 'package:chef/services/services.dart';
import 'package:chef/ui_kit/general_ui_kit.dart';
import 'package:chef/screens/login/login_screen_m.dart';
import 'package:package_info_plus/package_info_plus.dart';

@injectable
class LoginScreenViewModel extends BaseViewModel<LoginScreenState> {
  LoginScreenViewModel({
    required INavigationService navigation,
    required INetworkService network,
    required IStorageService storage,
    required ApplicationService appService,
  })  : _navigation = navigation,
        _network = network,
        _storage = storage,
        _appService = appService,
        super(
          const Initialized(
            appVersion: '',
            baseURL: '',
            email: '',
            password: '',
            baseUrlIndex: 0,
            isBusy: false,
          ),
        );

  final INavigationService _navigation;
  final INetworkService _network;
  final IStorageService _storage;
  final ApplicationService _appService;

  Future<void> loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    emit(state.copyWith(appVersion: packageInfo.version));
  }

  void updateBaseUrl({
    required int selectedUrlIndex,
    required String baseURL,
  }) =>
      emit(
        state.copyWith(
          baseUrlIndex: selectedUrlIndex,
          baseURL: baseURL,
        ),
      );

  void loading({required bool isBusy}) => emit(state.copyWith(isBusy: isBusy));

  bool isValidUrl(String url) => Uri.tryParse(url)?.hasAbsolutePath ?? false;

  String updateUrl(String url) {
    if (!url.endsWith('/')) {
      url += '/';
    }
    if (!url.endsWith(Api.client)) {
      url += Api.client;
    }
    return url;
  }

  void onFormValuesChange({
    String? email,
    String? password,
  }) =>
      emit(
        state.copyWith(
          email: email ?? state.email,
          password: password ?? state.password,
        ),
      );

  void onCheckRememberMe({required bool value}) =>
      emit(state.copyWith(rememberMe: value));

  void login({
    required String email,
    required String password,
    required String baseUrl,
    required BuildContext context,
  }) async {
    final isInputValid = _validateInput(
      email: email,
      password: password,
    );
    if (isInputValid) {
      loading(isBusy: true);
      try {
        final url = ExtoURLHelpers.getRestApiURL(baseUrl + Api.login);
        final loginCredentials = LoginRequest(
          username: email.trim(),
          password: password.trim(),
        ).toJson();
        final response = await _network.post(
          path: url,
          data: loginCredentials,
        );
        await _cacheData(
          context: context,
          loginData: response.body,
          baseUrl: baseUrl,
        );

        loading(isBusy: false);
        //   _navigation.replace(route: CustomerRoute());
      } catch (error) {
        emit(
          state.copyWith(
            isBusy: false,
            errorMessage: error.toString().contains(Api.unauthorizedRequest)
                ? Strings.invalidUsernamePassword
                : error.toString(),
          ),
        );
      }
    } else {
      Toaster.errorToast(
        context: context,
        message: Strings.requiredFields,
      );
    }
  }

  bool _validateInput({
    required String email,
    required String password,
  }) =>
      email.trim().isNotEmpty && password.trim().isNotEmpty;

  Future<void> _cacheData({
    required BuildContext context,
    required loginData,
    required String baseUrl,
  }) async {
    await _storage.writeBool(
      key: PreferencesKeys.sRememberUser,
      data: state.rememberMe,
    );
    await _storage.writeString(
      key: PreferencesKeys.sLoginData,
      data: loginData.toString(),
    );
    final loginDecodedData = jsonDecode(loginData.toString());
    final currentUser = LoginResponse.fromJson(loginDecodedData);
    await _storage.writeString(
      key: PreferencesKeys.sTenantId,
      data: currentUser.user.tenantId,
    );
    await _storage.writeString(
      key: PreferencesKeys.sBaseUrl,
      data: baseUrl,
    );
    await _appService.loadPrefData();
  }

  void goToForgotPasswordScreen() => _navigation.navigateTo(
        route: ForgotPasswordRoute(baseUrl: state.baseURL),
      );
}
