import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/signup/profession_request.dart' as prorequest;

import 'food_detail_screen_m.dart';
import 'food_details_menu_model.dart';

@injectable
class FoodDetailScreenViewModel extends BaseViewModel<FoodDetailScreenState> {
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

    emit(const Loading());
    final professionDataRequest = prorequest.ProfessionRequest(
      t: prorequest.T(),
    ).toJson();

    final response = await _network.post(
      path: url,
      data: professionDataRequest,
    );

    final foodMenuData = foodMenuModelFromJson(response.body);
    emit(Loaded(foodMenuData));

    // List<ProfessionData> data = currentProfessionData.t;
    // emit(Loaded(currentProfessionData));
  }



  Future<void> getScheduleData({
    required String baseUrl,
    required BuildContext context,
  }) async {
    final url = InfininURLHelpers.getRestApiURL(baseUrl + Api.getScheduleData);
    // emit(const Loading());

    // emit(const Loading());
    final professionDataRequest = prorequest.ProfessionRequest(
      t: prorequest.T(),
    ).toJson();

    final response = await _network.post(
      path: url,
      data: professionDataRequest,
    );

    // final foodMenuData = scheduleModelFromJson(response.body);
    // emit(Loaded(foodMenuData));

    // List<ProfessionData> data = currentProfessionData.t;
    // emit(Loaded(currentProfessionData));
  }
  void loading({required bool isBusy}) => emit(const Loading());
}
