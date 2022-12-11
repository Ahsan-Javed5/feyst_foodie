import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:chef/base/base.dart';
import 'package:chef/constants/preferences.dart';
import 'package:chef/models/models.dart';
import 'package:chef/services/services.dart';
import 'package:chef/ui_kit/helpers/toaster_helper.dart';
import 'package:chef/screens/navdrawer/navdrawer_m.dart';

import 'package:chef/helpers/enum_helper.dart';

@injectable
class NavDrawerViewModel extends BaseViewModel<NavDrawerState> {
  NavDrawerViewModel({
    required INavigationService navigation,
    required IStorageService storage,
    required ApplicationService appService,
  })  : _navigation = navigation,
        _storage = storage,
        _appService = appService,
        super(
          Loaded(
            selectedCustomer: Customer.empty(),
            customersList: [],
            user: User.empty(),
            index: NavigationDrawer.home,
          ),
        );

  final INavigationService _navigation;
  final IStorageService _storage;
  final ApplicationService _appService;

  void updateSelectedNavId(NavigationDrawer id) {
    emit(state.copyWith(index: id));
  }

  User fetchUserDetails() {
    final userInfo = _storage.readString(key: PreferencesKeys.sLoginData);
    final authData = LoginResponse.fromJson(jsonDecode(userInfo));
    return authData.user;
  }

  void fetchData() {
    final selectedIndex =
        _appService.state.selectedNavId ?? NavigationDrawer.home;
    final user = fetchUserDetails();
    final customers = fetchCustomers();
    final customerInfo = _storage.readString(key: PreferencesKeys.sCustomerId);

    var customer =
        customers.firstWhere((customer) => customer.id == customerInfo);
    customers.remove(customer);
    emit(
      state.copyWith(
        user: user,
        selectedCustomer: customer,
        customersList: customers,
        index: selectedIndex,
      ),
    );
  }

  List<Customer> fetchCustomers() {
    final customerListStr =
        _storage.readString(key: PreferencesKeys.sCustomerList);
    return CustomerListResponse.customerListFromJson(customerListStr);
  }

  void navigateToProfile({required bool isMobile}) {
    if (isMobile) {
      //_navigation.navigateTo(route: MainProfileRoute());
    } else {
      //_navigation.navigateTo(route: ProfileSwitcherRoute());
    }
  }

  Future<void> updateCustomer({
    required BuildContext context,
    required Customer item,
  }) async {
    try {
      await _storage.writeString(
        key: PreferencesKeys.sTenantId,
        data: item.tenantId,
      );
      await _storage.writeString(
        key: PreferencesKeys.sCustomerId,
        data: item.id,
      );
      fetchData();
    } catch (error) {
      Toaster.errorToast(
        context: context,
        message: error.toString(),
      );
    }
  }

  void navigateToHome() {
    _appService.updateSelectedNavId(id: NavigationDrawer.home);
    _appService.updateSearchDisplay(isSearchVisible: false);
    _navigation.replace(route: HomeRoute());
  }

  void navigateToWorkspace() {
    _appService.updateSelectedNavId(id: NavigationDrawer.workspace);
    _appService.updateSearchDisplay();
    //   _navigation.replace(route: WorkspaceRoute());
  }

  void navigateToProjects() {
    _appService.updateSelectedNavId(id: NavigationDrawer.projects);
    _appService.updateSearchDisplay();
    //_navigation.replace(route: ProjectsRoute());
  }

  void navigateToCustomers() {
    // _navigation.replace(route: CustomerRoute());
  }

  void navigateToModules() {
    _appService.updateSelectedNavId(id: NavigationDrawer.module);
    _appService.updateSearchDisplay();
    //_navigation.replace(route: ModulesRoute());
  }
}
