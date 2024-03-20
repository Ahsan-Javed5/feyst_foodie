import 'dart:io';

import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/signup/profession_request.dart' as prorequest;
import 'package:chef/screens/bottom_bar/bottom_bar.dart' as bottom_bar;
import 'package:chef/screens/sign_in/sign_in_screen_m.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer' as developer;
import '/models/signup/signup_response.dart';

@injectable
class SignInScreenViewModel extends BaseViewModel<SignInScreenState> {
  SignInScreenViewModel({
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
            mobileNumber: '',
            isBusy: false,
          ),
        );

  final INavigationService _navigation;
  final INetworkService _network;
  final IStorageService _storage;
  final ApplicationService _appService;
  String countryCode = '+92';

  void test() {}

  Future<void> loadProfessions({
    required String baseUrl,
    required BuildContext context,
  }) async {
    final url = InfininURLHelpers.getRestApiURL(baseUrl + Api.professionalList);
    final professionDataRequest = prorequest.ProfessionRequest(
      builderId: 0,
      currentPage: 0,
      totalRecords: 0,
      userId: 0,
      userName: "",
      t: prorequest.T(),
    ).toJson();
    final response = await _network.post(
      path: url,
      data: professionDataRequest,
    );

    // final currentProfessionData = professionFromJson(response.body);
    // List<ProfessionData> data = currentProfessionData.t;
    // emit(Loaded(currentProfessionData.t));
  }

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

  // void onFormValuesChange({
  //   String? fullName,
  //   String? mobileNumber,
  //   int? age,
  //   String? gender,
  //   String? profession,
  // }) =>
  //     emit(Initialized(
  //             fullName: fullName ?? '',
  //             mobileNumber: mobileNumber ?? '',
  //             age: age ?? 18,
  //             gender: gender ?? 'male',
  //             profession: profession ?? '',
  //             isBusy: false)
  //         .copyWith());

  bool _validateInput({
    required String mobileNumber,
  }) =>
      mobileNumber.trim().isNotEmpty;

  Future<void> _cacheData({
    required BuildContext context,
    required loginData,
    required String baseUrl,
  }) async {
    // await _storage.writeBool(
    //   key: PreferencesKeys.sRememberUser,
    //   data:  state.rememberMe,
    //   // data: state.when(initialized: , loaded: loaded),
    // );
    await _storage.writeString(
      key: PreferencesKeys.sLoginData,
      data: loginData.toString(),
    );
    final loginDecodedData = jsonDecode(loginData.toString());
    //final currentUser = LoginResponse.fromJson(loginDecodedData);
    final currentUser = SignupResponse.fromJson(loginDecodedData);
    // await _storage.writeString(
    //   key: PreferencesKeys.sTenantId,
    //   data: currentUser.user.tenantId,
    // );
    await _storage.writeString(
      key: PreferencesKeys.sBaseUrl,
      data: baseUrl,
    );
    await _appService.loadPrefData();
  }

  void verifyUser({
    required String mobileNumber,
    required String password,
    required BuildContext context,
  }) async {
    final isInputValid = _validateInput(
      mobileNumber: mobileNumber,
    );
    if (isInputValid) {
      try {
        final url = InfininURLHelpers.getRestApiURL(Api.baseURL + Api.loginAPI);

        DataRequest t = DataRequest(
            mobileNo: countryCode + mobileNumber,
            fcmToken: await FirebaseMessaging.instance.getToken(),
            deviceType: Platform.isAndroid ? 'ANDROID' : 'IOS');

        final loginCredentials = LoginRequest(
          t: t,
        ).toJson();

        final _header = <String, String>{
          Api.headerAcceptKey: Api.headerAcceptTypeValue,
          'Content-Type': 'application/json'
        };

        final response = await _network.post(
          path: url,
          data: {
            "t": {
              "deviceType": Platform.isAndroid ? 'ANDROID' : 'IOS',
              "fcmToken": await FirebaseMessaging.instance.getToken(),
              "mobileNumber": countryCode + mobileNumber,
              "password": password
            }
          },
          header: _header,
        );
        if (response != null) {
          developer.log(' Response of login body is ' '${response.body}');

          SignupResponse signupResponse = signupResponseFromJson(response.body);
          print(signupResponse);
          Toaster.infoToast(context: context, message: 'Welcome back');

          await _cacheData(
            context: context,
            loginData: response.body,
            baseUrl: Api.baseURL,
          );
          if (signupResponse.t.profileImageUrl != null) {
            await _storage.writeString(
                key: 'profile_image',
                data: signupResponse.t.profileImageUrl ?? '');
          }

          await _storage.writeString(
              key: 'auth_token', data: signupResponse.t.authToken);

          developer.log(' Sign up Response is ' + signupResponse.message ?? '');

          //    Navigator.pushReplacementNamed(context, '/BottomBar');
          _navigation.replace(
              route:
                  BottomBarRoute(bottomBarType: bottom_bar.BottomBarType.home));
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const BottomBar()),
          // );
        } else {
          Toaster.infoToast(
              context: context,
              message: 'Not found foodie [ ' +
                  mobileNumber +
                  '], Please enter registered number or SignUp');
        }

        //  loading(isBusy: false);
        //   _navigation.replace(route: CustomerRoute());
      } catch (error) {
        Toaster.infoToast(
          context: context,
          message: error.toString(),
        );
      }
    } else {
      Toaster.errorToast(
        context: context,
        message: Strings.requiredFields,
      );
    }
  }

  // void loading({required bool isBusy}) => emit(const Loading());
}
