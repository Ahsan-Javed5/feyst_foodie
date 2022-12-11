import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:chef/base/base.dart';
import 'package:chef/constants/constants.dart';
import 'package:chef/helpers/enum_helper.dart';
import 'package:chef/models/home_screen_model.dart';
import 'package:chef/services/services.dart';
import 'package:chef/screens/home/home_screen_m.dart';

@injectable
class HomeScreenViewModel extends BaseViewModel<HomeScreenState> {
  HomeScreenViewModel({
    required INavigationService navigation,
    required IStorageService storage,
    required ApplicationService appService,
  })  : _navigation = navigation,
        _storage = storage,
        _appService = appService,
        super(
          const Initialized(),
        );

  final INavigationService _navigation;
  final IStorageService _storage;
  final ApplicationService _appService;

  HomeScreenModel getUserInfo() {
    final projectName = _storage.readString(key: PreferencesKeys.projectName);
    final customerName = _storage.readString(key: PreferencesKeys.customerName);
    final customerLogo = _storage.readString(key: PreferencesKeys.customerLogo);
    final _bytesImage = const Base64Decoder().convert(
      _storage.readString(
        key: PreferencesKeys.customerLogo,
      ),
    );
    return HomeScreenModel(
      customerImage: _bytesImage,
      customerLogo: customerLogo,
      customerName: customerName,
      projectName: projectName,
    );
  }

  void logout() async {
    _appService.logout();
  }

  void navigateToProjectScreen() async {
    //_navigation.replace(route: ProjectsRoute());
  }

  void navigateToCustomerScreen() async {
    //_navigation.replace(route: CustomerRoute());
  }

  void navigateToDashboardScreen() async {
    // _navigation.replace(route: DashboardRoute());
  }

  void navigateToModulesScreen() async {
    _appService.updateSearchDisplay();
    _appService.updateSelectedNavId(id: NavigationDrawer.module);
    //  _navigation.replace(route: ModulesRoute());
  }

  Future<bool> logoutPopUp(BuildContext context) async =>
      _appService.logoutPopUp(context);
}
