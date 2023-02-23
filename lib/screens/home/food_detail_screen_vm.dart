import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/signup/profession_request.dart' as prorequest;

// import '../../base/screen_layout_base/screen_layout_base_m.dart';
import '../../models/signup/profession_response.dart';
import 'dart:developer' as developer;

import '../../helpers/data_request.dart' as signuprequest;
// import '../../models/signup/signup_request.dart' as signuprequest;
import '../../models/signup/signup_request.dart';
import '../../models/signup/signup_response.dart';
import 'package:chef/screens/sign_up/sign_up_screen_m.dart';

import 'food_details_menu_model.dart';

@injectable
class FoodDetailScreenViewModel extends BaseViewModel<SignUpScreenState> {
  FoodDetailScreenViewModel({
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

  Future<void> getExperienceMenu({
    required String baseUrl,
    required BuildContext context,
  }) async {
    final url = InfininURLHelpers.getRestApiURL(baseUrl + Api.experienceMenu);
    // emit(const Loading());
    List<ProfessionData> _professionData = [];
    emit(Loaded(_professionData));
    final professionDataRequest = prorequest.ProfessionRequest(
      t: prorequest.T(),
    ).toJson();

    final response = await _network.post(
      path: url,
      data: professionDataRequest,
    );

    final foodMenuData = foodMenuModelFromJson(response.body);
    // List<ProfessionData> data = currentProfessionData.t;
    // emit(Loaded(currentProfessionData));
  }




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




  void loading({required bool isBusy}) => emit(const Loading());
}
