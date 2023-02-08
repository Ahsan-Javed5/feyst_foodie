import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/signup/profession_request.dart' as prorequest;

// import '../../base/screen_layout_base/screen_layout_base_m.dart';
import '../../models/signup/profession_response.dart';
import 'dart:developer' as developer;

import '../../models/signup/signup_request.dart' as signuprequest;
import '../../models/signup/signup_response.dart';
import 'package:chef/screens/sign_up/sign_up_screen_m.dart';

@injectable
class SignUpScreenViewModel extends BaseViewModel<SignUpScreenState> {
  SignUpScreenViewModel({
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
            fullName: '',
            mobileNumber: '',
            age: 18,
            gender: 'Male',
            isBusy: false,
            profession: '',
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

    final currentProfessionData = professionFromJson(response.body);
    List<ProfessionData> data = currentProfessionData.t;
    emit(Loaded(currentProfessionData.t));
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

  void onFormValuesChange({
    String? fullName,
    String? mobileNumber,
    int? age,
    String? gender,
    String? profession,
  }) =>
      emit(Initialized(
              fullName: fullName ?? '',
              mobileNumber: mobileNumber ?? '',
              age: age ?? 18,
              gender: gender ?? 'male',
              profession: profession ?? '',
              isBusy: false)
          .copyWith());

  bool _validateInput({
    required String name,
    required String mobileNumber,
    required int age,
    required String gender,
    required int professionId,
  }) =>
      name.trim().isNotEmpty &&
      mobileNumber.trim().isNotEmpty &&
      age > 5 &&
      gender.isNotEmpty &&
      professionId != 0;

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

  void saveFoodie({
    required String name,
    required String mobileNumber,
    required int age,
    required String gender,
    required int professionId,
    required BuildContext context,
    required String baseUrl,
  }) async {
    final isInputValid = _validateInput(
      name: name,
      mobileNumber: mobileNumber,
      age: age,
      gender: gender,
      professionId: professionId,
    );
    if (isInputValid) {
      loading(isBusy: true);
      try {
        final url =
            InfininURLHelpers.getRestApiURL(Api.baseURL + Api.foodieSignUp);
        signuprequest.T t = signuprequest.T(
          age: age.toString(),
          name: name,
          gender: gender,
          mobileNo: mobileNumber,
          professionalId: professionId,
          profileImageUrl: null,
        );

        final signUpCredentials = signuprequest.SignupRequest(
          t: t,
        ).toJson();
        final response = await _network
            .post(
              path: url,
              data: signUpCredentials,
              //   accessToken: false,
            )
            .whenComplete(() {});

        // final response = await _network.get(
        //   //below one is working
        //   path: 'https://run.mocky.io/v3/80289cbe-aa47-491e-9eb2-56126289c8a4',
        // );
        if (response != null) {
          developer.log(' Response of Signup body is ' + '${response.body}');

          SignupResponse signupResponse = signupResponseFromJson(response.body);

          Toaster.infoToast(context: context, message: signupResponse.message);

          await _cacheData(
            context: context,
            loginData: response.body,
            baseUrl: baseUrl,
          );

          developer.log(' Sign up Response is ' + signupResponse.message);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpQuestionireScreen()),
          );
        } else {
          Toaster.infoToast(
              context: context,
              message: 'Something is wrong please content vendor');
          developer.log(' Response of Signup is null ' + '$response');
        }

        //  loading(isBusy: false);
        //   _navigation.replace(route: CustomerRoute());
      } catch (error) {
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
        message: Strings.signUpFields,
      );
    }
  }

  void loading({required bool isBusy}) => emit(const Loading());
}
