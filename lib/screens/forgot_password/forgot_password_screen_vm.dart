import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:chef/base/base.dart';
import 'package:chef/screens/forgot_password/forgot_password_screen_m.dart';
import 'package:chef/services/services.dart';
import 'package:chef/constants/constants.dart';

import '../../helpers/url_helper.dart';
import '../../setup.dart';
import '../../ui_kit/helpers/toaster_helper.dart';
import '../../ui_kit/widgets/general_text_input.dart';
import '../sign_in/sign_in_screen_v.dart';

@injectable
class ForgotPasswordScreenViewModel
    extends BaseViewModel<ForgotPasswordScreenState> {
  ForgotPasswordScreenViewModel({
    required INavigationService navigation,
  })  : _navigation = navigation,
        super(
          const Initialized(
            email: '',
            isBusy: false,
          ),
        );

  final INavigationService _navigation;
  TextController mobileNumberController = TextController();
  String countryCode = '+92';
  final INetworkService _network = locateService<INetworkService>();
  final ValueNotifier<bool> isVerifyingOtp = ValueNotifier<bool>(false);

  Future<bool?> checkUserExist(context) async {
    try {
      final url =
      InfininURLHelpers.getRestApiURL(Api.baseURL + Api.checkUserExist);

      final _header = <String, String>{
        //'Authorization': 'Bearer ${_storage.readString(key: 'auth_token')}',
        'Content-Type': 'application/json'
      };
      final response = await _network
          .post(
        path: url,
        data: {
          "t": countryCode + mobileNumberController.text
        },
        header: _header,
        //   accessToken: false,
      )
          .whenComplete(() {});

      if (response.statusCode == 400) {
        // Toaster.errorToast(
        //     context: context,
        //     message: 'User Already Exists.');
        return false;
      } else {
        return true;
      }
    } catch (error) {
      //Toaster.errorToast(context: context, message: '$error');
    }
    return null;
  }

  Future<void> resetPassword(context, password, phone, tokenId) async {
    try {
      final url =
      InfininURLHelpers.getRestApiURL(Api.baseURL + Api.resetPassword);

      final _header = <String, String>{
        //'Authorization': 'Bearer ${_storage.readString(key: 'auth_token')}',
        'Content-Type': 'application/json'
      };
      final response = await _network
          .post(
        path: url,
        data: {
          "t": {
            "idToken": tokenId,
            "mobileNo": countryCode + phone,
            "newPassword": password
          }
        },
        header: _header,
        //   accessToken: false,
      )
          .whenComplete(() {});

      if (response != null) {
        Toaster.successToast(
            context: context,
            message: 'Password Updated');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      } else {
      }
    } catch (error) {
      Toaster.errorToast(context: context, message: '$error');
    }
  }

}
