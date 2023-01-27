import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/signup/profession_request.dart' as prorequest;

import '../../models/signup/profession_response.dart';
import 'dart:developer' as developer;

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

  Future<void> loadProfessions({
    required String baseUrl,
    required BuildContext context,
  }) async {
    final url = ExtoURLHelpers.getRestApiURL(baseUrl + Api.professionalList);
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
    developer.log(' Current Data is ' + '${currentProfessionData.t[0].name}');
    emit(Loaded(currentProfessionData.t));
  }

  // void updateBaseUrl({
  //   required int selectedUrlIndex,
  //   required String baseURL,
  // }) =>
  //     emit(
  //       state.copyWith(
  //         baseUrlIndex: selectedUrlIndex,
  //         baseURL: baseURL,
  //       ),
  //     );

  // void loading({required bool isBusy}) => emit(state.copyWith(isBusy: isBusy));

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
    // await _storage.writeBool(
    //   key: PreferencesKeys.sRememberUser,
    //   // data:  state.rememberMe,
    //   data: state.when(initialized: , loaded: loaded),
    // );
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
}
