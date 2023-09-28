import 'dart:async';

import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/food_details_screen/slider_images_response.dart';
import 'package:chef/models/home/chef_data_response.dart';
import 'package:chef/models/home/food_menu_request.dart' as menurequest;
import 'package:chef/screens/home/schedule_model.dart';
import '../../../models/home/home_response.dart' as home_data;
import '../food_details_menu_model.dart';
import 'food_detail_screen_m.dart';

import '/models/home/experience_list_response.dart' as experience_data;

import 'dart:developer' as developer;

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
  //late final SliderImagesResponse sliderImages;
  late FoodMenuModel foodMenuData;
  late String expId;

  Future<void> getExperienceMenu({required String experienceId,required chefId}) async {
    final url =
        InfininURLHelpers.getRestApiURL(Api.baseURL + Api.experienceMenu);
    // emit(const Loading());
    expId = experienceId;
    emit(const Loading());

    developer.log(' Experience Id to fetch menu is ' + '${experienceId}');
    final foodMenuRequest = menurequest.FoodMenuRequest(
      t: int.parse(experienceId),
    ).toJson();

    final response = await _network.post(
      path: url,
      data: foodMenuRequest,
      header: {
        'Authorization': 'Bearer ${_storage.readString(key: 'auth_token')}',
        'Content-Type': 'application/json'
      }
    );

    foodMenuData = foodMenuModelFromJson(response.body);
    //getSliderImages(experienceId: experienceId);
    getScheduleData(experienceId: experienceId, foodMenuModel: foodMenuData,chefId: chefId);
    //  emit(Loaded(foodMenuData));

    // List<ProfessionData> data = currentProfessionData.t;
    // emit(Loaded(currentProfessionData));
  }

  Future<void> getScheduleData({
    required String experienceId,
    required FoodMenuModel foodMenuModel,
    required int chefId
  }) async {
    final url = InfininURLHelpers.getRestApiURL(Api.baseURL + Api.scheduleData);

    final scheduleRequest = menurequest.FoodMenuRequest(
      t: int.parse(experienceId),
    ).toJson();

    final response = await _network.post(path: url, data: scheduleRequest, header: {
      'Authorization': 'Bearer ${_storage.readString(key: 'auth_token')}',
      'Content-Type': 'application/json'
    });

    final scheduleData = scheduleModelFromJson(response.body);

    getChefData(foodMenuModel, scheduleData , chefId);

  }

  Future<ChefDataResponse> getChefData(FoodMenuModel foodData, ScheduleModel scheduleData, chefId) async {
    final url = InfininURLHelpers.getRestApiURL(Api.baseURL + Api.chefData);
    // emit(const Loading());

    final scheduleRequest = menurequest.FoodMenuRequest(
      t: chefId,
    ).toJson();

    final response = await _network.post(path: url, data: scheduleRequest, header: {
      'Authorization': 'Bearer ${_storage.readString(key: 'auth_token')}',
      'Content-Type': 'application/json'
    });

    final chefData = chefModelFromJson(response.body);
    emit(Loaded(foodData, scheduleData, chefData));
    return chefData;

  }


  Future<SliderImagesResponse?> getSliderImages({required experienceId}) async {
    final url =
    InfininURLHelpers.getRestApiURL(Api.baseURL + Api.sliderImages);

    try {
      final response = await _network.post(
          path: url,
          data: {
            "t": {
              "experienceId" : experienceId
            }
          },
          header: {
            'Authorization': 'Bearer ${_storage.readString(key: 'auth_token')}',
            'Content-Type': 'application/json'
          }
      );
    final sliderImages = sliderImagesFromJson(response.body);
    // print(sliderImages);
      return sliderImages;
    } catch (e) {
      print(e);
    }
    return null;
  }

  void loading({required bool isBusy}) => emit(const Loading());


  String getValidUrlForImages(String imagePath) {
    String baseUrl = Api.baseURL;
    baseUrl = baseUrl
        .replaceAll("feyst-service", "feyst-media")
        .replaceAll(":8080", '');
    baseUrl = baseUrl + imagePath;
    return baseUrl;
  }
}
