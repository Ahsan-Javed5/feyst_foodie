import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/signup/profession_request.dart' as prorequest;
import 'package:chef/screens/sign_in/sign_in_screen_m.dart';
import 'package:http/http.dart';

// import '../../models/signup/profession_response.dart';
import 'dart:developer' as developer;

import '../../models/login/login_request.dart' as loginrequest;
import '../../models/signup/signup_response.dart';

import 'package:chef/screens/sign_in/sign_in_screen_m.dart';

import '../bottom_bar/bottom_bar.dart';
import '../home/home_screen_v.dart';

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
    required BuildContext context,
  }) async {
    final isInputValid = _validateInput(
      mobileNumber: mobileNumber,
    );
    if (isInputValid) {
      //loading(isBusy: true);
      try {
        final url = InfininURLHelpers.getRestApiURL(Api.baseURL + Api.loginAPI);

        loginrequest.T t = loginrequest.T(
          mobileNo: mobileNumber,
        );

        final loginCredentials = loginrequest.LoginRequest(
          t: t,
        ).toJson();

        final _header = <String, String>{
          Api.headerAcceptKey: Api.headerAcceptTypeValue
        };

        final response = await _network
            .post(
          path: url,
          data: loginCredentials,
          header: _header,
          //   accessToken: false,
        )
            .then((value) {
          developer.log(' Response code is ' + '${value.runtimeType}');
        }).whenComplete(() {
          developer.log(' Completed code is ');
        });
        developer.log(' response data is  ' + '${response.runtimeType}');

        // final response = await _network.get(
        //   //below one is working
        //   path: 'https://run.mocky.io/v3/80289cbe-aa47-491e-9eb2-56126289c8a4',
        //
        //   // path: 'https://run.mocky.io/v3/d1f71fed-862a-4e17-a57c-07e99818e42f',
        // );
        if (response != null) {
          developer.log(' Response of login body is ' + '${response.body}');

          SignupResponse signupResponse = signupResponseFromJson(response.body);

          Toaster.infoToast(context: context, message: 'Welcome back');

          await _cacheData(
            context: context,
            loginData: response.body,
            baseUrl: Api.baseURL,
          );

          developer.log(' Sign up Response is ' + signupResponse.message);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BottomBar()),
          );
        } else {
          Toaster.infoToast(
              context: context,
              message: 'Not found foodie [ ' +
                  '${'${mobileNumber}'}' +
                  '], Please enter registered number or SignUp');
        }

        //  loading(isBusy: false);
        //   _navigation.replace(route: CustomerRoute());
      } catch (error) {
        developer.log(' Here in Error ' + '${error.runtimeType}');
        developer.log(' Here Error by API is ' + '${error}');
        // Response _response = error;
        // emit(
        //   // state.copyWith(
        //   //   isBusy: false,
        //   //   errorMessage: error.toString().contains(Api.unauthorizedRequest)
        //   //       ? Strings.invalidUsernamePassword
        //   //       : error.toString(),
        //   // ),
        // );
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
