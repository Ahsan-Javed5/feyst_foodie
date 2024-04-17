import 'dart:convert';

import 'package:chef/models/home/home_response.dart';
import 'package:chef/screens/sign_up/questionire/sign_up_questionire_screen_vm.dart';
import 'package:chef/setup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:chef/base/base.dart';
import 'package:chef/constants/constants.dart';
import 'package:chef/helpers/enum_helper.dart';
import 'package:chef/models/home_screen_model.dart';
import 'package:chef/services/services.dart';
import 'package:chef/screens/home/home_screen_m.dart';

import '../../helpers/url_helper.dart';
import '../../ui_kit/helpers/toaster_helper.dart';
import 'dart:developer' as developer;
import '../../helpers/data_request.dart' as data_request;

@injectable
class HomeScreenViewModel extends BaseViewModel<HomeScreenState> {
  HomeScreenViewModel({
    required INavigationService navigation,
    required IStorageService storage,
    required ApplicationService appService,
    required INetworkService network,
  })  : _navigation = navigation,
        _storage = storage,
        _appService = appService,
        _network = network,
        super(
          const Initialized(),
        );

  final INavigationService _navigation;
  final IStorageService _storage;
  final ApplicationService _appService;
  final INetworkService _network;

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

  void loadData() {
    // emit(const Loaded());
  }

  void fetchData({
    required BuildContext context,
  }) async {
    //   loading(isBusy: true);
    emit(const Loading());
    try {
      final url = InfininURLHelpers.getRestApiURL(Api.baseURL + Api.homeApis);
      data_request.T t = data_request.T();

      final dataRequest = data_request.DataRequest(
        t: t,
      ).toJson();
      //await locateService<SignUpQuestionnaireScreenViewModel>().getFoodieAnswers();
      final _header = <String, String>{
        Api.headerAcceptKey: Api.headerAcceptTypeValue,
        'Authorization': 'Bearer ${_storage.readString(key: 'guest_token')}',
        'Content-Type': 'application/json'
      };
      final response = await _network
          .post(
            path: url,
            data: dataRequest,
            header: _header,
            //   accessToken: false,
          )
          .whenComplete(() {});

      if (response != null) {
        HomeResponse homeResponse = homeResponseFromJson(response.body);

        if (kDebugMode) {
          print(homeResponse);
        }

        emit(Loaded(homeResponse));
      } else {
        Toaster.infoToast(
            context: context,
            message: 'Something is wrong please content vendor');
        developer.log(' Response of Signup is null ' + '$response');
      }
    } catch (error) {
      print(error);
    }
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
    _appService.updateSelectedNavId(id: NavDrawerItem.module);
    //  _navigation.replace(route: ModulesRoute());
  }

  Future<bool> logoutPopUp(BuildContext context) async =>
      _appService.logoutPopUp(context);
}
