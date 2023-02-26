import 'dart:async';

import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/home/food_menu_request.dart' as menurequest;
import 'package:chef/screens/home/schedule_model.dart';

import '../food_details_menu_model.dart';
import 'food_detail_screen_m.dart';

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

  // Future<void> getExperienceMenu({
  // }) async {
  //   final url = InfininURLHelpers.getRestApiURL(Api.baseURL + Api.experienceMenu);
  //   // emit(const Loading());
  //
  //   emit(const Loading());
  //   final professionDataRequest = prorequest.ProfessionRequest(
  //     t: prorequest.T(),
  //   ).toJson();
  //
  //   final response = await _network.post(
  //     path: url,
  //     data: professionDataRequest,
  //   );
  //
  //   final foodMenuData = foodMenuModelFromJson(response.body);
  //   emit(Loaded(foodMenuData));
  //
  //   // List<ProfessionData> data = currentProfessionData.t;
  //   // emit(Loaded(currentProfessionData));
  // }

  Future<void> getExperienceMenu({required String experienceId}) async {
    final url =
        InfininURLHelpers.getRestApiURL(Api.baseURL + Api.experienceMenu);
    // emit(const Loading());

      emit(const Loading());

    final foodMenuRequest = menurequest.FoodMenuRequest(
      t: int.parse(experienceId),
    ).toJson();

    final response = await _network.post(
      path: url,
      data: foodMenuRequest,
    );

    final foodMenuData = foodMenuModelFromJson(response.body);


    getScheduleData(experienceId: experienceId,foodMenuModel: foodMenuData);
  //  emit(Loaded(foodMenuData));

    // List<ProfessionData> data = currentProfessionData.t;
    // emit(Loaded(currentProfessionData));
  }

  Future<void> getScheduleData({
  required String experienceId,
  required FoodMenuModel foodMenuModel,
  }) async {
    final url = InfininURLHelpers.getRestApiURL(Api.baseURL + Api.scheduleData);
    // emit(const Loading());

    final scheduleRequest = menurequest.FoodMenuRequest(
      t: int.parse(experienceId),
    ).toJson();


    final response = await _network.post(
      path: url,
      data: scheduleRequest
    );


    debugPrint("schedule response\n" +response.body.toString());

      final scheduleData = scheduleModelFromJson(response.body);

  emit(Loaded(foodMenuModel,scheduleData));


  }

  void loading({required bool isBusy}) => emit(const Loading());
}
