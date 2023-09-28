import 'dart:io';

import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/signup/profession_request.dart' as prorequest;
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../models/signup/profession_response.dart';
import 'dart:developer' as developer;

import '../../models/signup/signup_request.dart' as signuprequest;
import '../../models/signup/sign_up_update_request.dart';
import '../../models/signup/sign_up_update_request.dart' as signup_update_request;
import '../../models/signup/signup_request.dart';
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
        super(const Loading());

  final INavigationService _navigation;
  final INetworkService _network;
  final IStorageService _storage;
  final ApplicationService _appService;

   TextController nameController = TextController();
   TextController mobileNumberController = TextController();
   TextController ageController = TextController(text: "");
   TextController genderController = TextController(text: 'male');
  TextController idController = TextController(text: "");
  String countryCode = '+92';

  final dropdownItems = <String>[];
  Map<dynamic, dynamic> dropdownDetails = {};
  int professionID = 0;
  List<ProfessionData> _professionData = [];
  ValueNotifier<bool> buttonEnabled = ValueNotifier(false);
  ValueNotifier<bool> isProfile = ValueNotifier(true);
  bool? isProfileDetails;
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  //bool isLoading = false;

  void changeButton(bool? value) {
    buttonEnabled.value =  value??!buttonEnabled.value;
  }

  Future<void> loadProfessions({
    required String baseUrl,
    required BuildContext context,
  }) async {
    final url = InfininURLHelpers.getRestApiURL(baseUrl + Api.professionalList);

    emit(Loaded(_professionData));

    if (_professionData.isEmpty) {
      final professionDataRequest = prorequest.ProfessionRequest(
        t: prorequest.T(),
      ).toJson();
      final _header = <String, String>{
        //'Authorization': 'Bearer ${_appService.state.userInfo?.t.authToken}',
        'Content-Type': 'application/json'
      };
      final response = await _network.post(
        path: url,
        data: professionDataRequest,
        header: _header,
      );
      final currentProfessionData = professionFromJson(response.body);
      _professionData = currentProfessionData.t;

      emit(Loaded(_professionData));
    }
  }

  bool isValidUrl(String url) => Uri.tryParse(url)?.hasAbsolutePath ?? false;

  void onFormValuesChange({
    String? email,
  }) {
    emit(
    state
    );
  }
  String updateUrl(String url) {
    if (!url.endsWith('/')) {
      url += '/';
    }
    if (!url.endsWith(Api.client)) {
      url += Api.client;
    }
    return url;
  }

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

  bool _validateUpdatedData({
    required String name,
    required int age,
    required String gender,
    required int professionId,
  }) =>
      name.trim().isNotEmpty &&
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
      emit(Loaded(_professionData));
      try {
        final url =
            InfininURLHelpers.getRestApiURL(Api.baseURL + Api.foodieSignUp);
        signuprequest.T t = signuprequest.T(
          age: age.toString(),
          name: name,
          deviceType: Platform.isAndroid ? 'ANDROID' : 'IOS',
          fcmToken:   await FirebaseMessaging.instance.getToken(),
          gender: gender,
          mobileNo: countryCode + mobileNumber,
          professionalId: professionId,
          profileImageUrl: null,
        );

        final signUpCredentials = SignupRequest(
          t: t,
        ).toJson();
        final response = await _network
            .post(
              path: url,
              data: signUpCredentials,
              header: {
                Api.headerAcceptKey: Api.headerAcceptTypeValue,
                'Content-Type' : 'application/json'
              },
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

          await _storage.writeString(key: 'profile_image', data: signupResponse.t.profileImageUrl);
          await _storage.writeString(key: 'auth_token' , data: signupResponse.t.authToken);

          developer.log(' Sign up Response is ' + signupResponse.message);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpQuestionireScreen(false,)),
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
        developer.log(' Error in ' + '${error}');

        Toaster.errorToast(context: context, message: '$error');
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

  void updateFoodie({
    required String name,
    required int age,
    required String gender,
    required int professionId,
    required BuildContext context,
    required String baseUrl,
  }) async {
    isLoading.value = true;
    final isInputValid = _validateUpdatedData(
      name: name,
      age: age,
      gender: gender,
      professionId: professionId,
    );

    if (isInputValid) {
      //loading(isBusy: true);
      //emit(const Loading());
      emit(Loaded(_professionData));
      try {
        final url =
        InfininURLHelpers.getRestApiURL(Api.baseURL + Api.foodieProfileUpdate);
        signup_update_request.T t = signup_update_request.T(
          age: age.toString(),
          name: name,
          gender: gender,
          id: int.parse(idController.text),
          professionalId: professionId,
        );

        final signUpCredentials = SignupUpdateRequest(
          t: t,
        ).toJson();
        final _header = <String, String>{
          'Authorization': 'Bearer ${_storage.readString(key: 'auth_token')}',
          'Content-Type': 'application/json'
        };
        final response = await _network
            .post(
          path: url,
          data: signUpCredentials,
          header: _header,
          //   accessToken: false,
        )
            .whenComplete(() {});

        if (response != null) {
          developer.log(' Response of Signup body is ' + '${response.body}');

          SignupResponse signupResponse = signupResponseFromJson(response.body);

          Toaster.infoToast(context: context, message: signupResponse.message);

          await _cacheData(
            context: context,
            loginData: response.body,
            baseUrl: baseUrl,
          );
          //_appService.state.userInfo!.t.authToken = 'ghgfrdesaa';
        _appService.state.userInfo!.t.authToken = _storage.readString(key: 'auth_token');

          developer.log(' Sign up update Response is ' + signupResponse.message);
          Navigator.pop(context);
        } else {
          Toaster.infoToast(
              context: context,
              message: 'Something is wrong please content vendor');
          developer.log(' Response of Signup is null ' + '$response');
        }

      } catch (error) {
        developer.log(' Error in ' + '${error}');
        Toaster.errorToast(context: context, message: '$error');
      }
    } else {
      Toaster.errorToast(
        context: context,
        message: Strings.signUpFields,
      );
    }
    isLoading.value = false;
  }

  bool verifyInput({
    required String name,
    required String mobileNumber,
    required int age,
    required String gender,
    required int professionId,
    required BuildContext context,
    required String baseUrl,
  }) {
    final isInputValid = _validateInput(
      name: name,
      mobileNumber: mobileNumber,
      age: age,
      gender: gender,
      professionId: professionId,
    );
    if (!isInputValid) {
      Toaster.errorToast(
        context: context,
        message: Strings.signUpFields,
      );
      return false;
    }
    return true;
  }

  bool checkAllInputAdded() {
    var age = ageController.text;
    if(age.isEmpty){
      age="0";
    }
    final isInputValid = _validateInput(
      name: nameController.text,
      mobileNumber: mobileNumberController.text,
      age: int.parse(age),
      gender: genderController.text,
      professionId: professionID,
    );

    return isInputValid;
  }

  void loading({required bool isBusy}) => emit(const Loading());

  void loadFoodieData() {
    nameController.text = _appService.state.userInfo!.t.name;
    mobileNumberController.text = _appService.state.userInfo!.t.mobileNo;
    ageController.text = _appService.state.userInfo!.t.age;
    genderController.text = _appService.state.userInfo!.t.gender;
    idController.text = _appService.state.userInfo!.t.id.toString();
    professionID = _appService.state.userInfo!.t.professionalId;
    print(professionID);
  }

  // Future registerUser(String mobile, BuildContext context) async {
  //   FirebaseAuth _auth = FirebaseAuth.instance;
  //
  //   _auth.verifyPhoneNumber(
  //       phoneNumber: null,
  //       timeout: null,
  //       verificationCompleted: null,
  //       verificationFailed: null,
  //       codeSent: null,
  //       codeAutoRetrievalTimeout: null);
  // }

  // Future<bool> registerUser(String phone, BuildContext context) async {
  //   FirebaseAuth _auth = FirebaseAuth.instance;
  //
  //   _auth.verifyPhoneNumber(
  //       phoneNumber: phone,
  //       timeout: Duration(seconds: 60),
  //       verificationCompleted: (AuthCredential credential) async {
  //         Navigator.of(context).pop();
  //
  //         var result = await _auth.signInWithCredential(credential);
  //
  //         Users user = result.user;
  //
  //         if (user != null) {
  //           Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (context) => HomeScreen(
  //                         user: user,
  //                       )));
  //         } else {
  //           print("Error");
  //         }
  //
  //         //This callback would gets called when verification is done auto maticlly
  //       },
  //       verificationFailed: (AuthException exception) {
  //         print(exception);
  //       },
  //       codeSent: (String verificationId, [int forceResendingToken]) {
  //         showDialog(
  //             context: context,
  //             barrierDismissible: false,
  //             builder: (context) {
  //               return AlertDialog(
  //                 title: Text("Give the code?"),
  //                 content: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: <Widget>[
  //                     TextField(
  //                       controller: _codeController,
  //                     ),
  //                   ],
  //                 ),
  //                 actions: <Widget>[
  //                   FlatButton(
  //                     child: Text("Confirm"),
  //                     textColor: Colors.white,
  //                     color: Colors.blue,
  //                     onPressed: () async {
  //                       final code = _codeController.text.trim();
  //                       AuthCredential credential =
  //                           PhoneAuthProvider.getCredential(
  //                               verificationId: verificationId, smsCode: code);
  //
  //                       AuthResult result =
  //                           await _auth.signInWithCredential(credential);
  //
  //                       FirebaseUser user = result.user;
  //
  //                       if (user != null) {
  //                         Navigator.push(
  //                             context,
  //                             MaterialPageRoute(
  //                                 builder: (context) => HomeScreen(
  //                                       user: user,
  //                                     )));
  //                       } else {
  //                         print("Error");
  //                       }
  //                     },
  //                   )
  //                 ],
  //               );
  //             });
  //       },
  //       codeAutoRetrievalTimeout: null);
  // }
}
