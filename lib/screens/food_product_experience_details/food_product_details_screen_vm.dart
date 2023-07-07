import 'dart:async';

import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/booking/booking_request.dart' as booking;
import 'package:chef/models/home/home_response.dart' as home_data;
import '../../helpers/order_helper.dart';
import '../../models/booking/booking_response.dart';
import '../../models/food_details_screen/food_details_screen_by_id_request.dart' as foodRequest;
import '../../setup.dart';
import '../bottom_bar/bottom_bar.dart' as bottom_bar;
import 'food_product_details_screen_m.dart';
import '../../../models/home/experience_list_response.dart' as experience_data;

@injectable
class FoodProductExperienceDetailsViewModel
    extends BaseViewModel<FoodProductDetailScreenState> {
  FoodProductExperienceDetailsViewModel({
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
  late BookingResponse bookingResponse;

  Future<void> defaultState() async {
    emit(Loaded());
  }
  //
  // late FoodDetailsResponse foodDetailsResponse;
  //
  // Future<void> getMenuDetailsById({required String experienceId}) async {
  //
  //   final _appService = locateService<ApplicationService>();
  //
  //   int _userId = (_appService.state.userInfo?.t.id)!;
  //
  //   final url =
  //   InfininURLHelpers.getRestApiURL(Api.baseURL + Api.experienceMenuById);
  //
  //   emit(const Loading());
  //
  //   final foodDetailsRequest = foodRequest.FoodDetailsDataRequest(
  //     t: int.parse(experienceId),
  //     userId: _userId,
  //   ).toJson();
  //
  //   final response = await _network.post(
  //     path: url,
  //     data: foodDetailsRequest,
  //   );
  //
  //   print("req resp ${response.body}");
  //   foodDetailsResponse = foodDataResponseFromJson(response.body);
  //
  //   emit(const Loaded());
  // }
  //

  Future<void> submitBooking(
      BuildContext context, home_data.Experiences experienceData) async {
    final url =
        InfininURLHelpers.getRestApiURL(Api.baseURL + Api.experienceBooking);
    // emit(const Loading());
    final _appService = locateService<ApplicationService>();

    OrderHelper orderHelper = (_appService.state.orderHelper)!;
    emit(const Loading());

    final bookingRequest = booking.BookingRequest(
      t: booking.T(
        comments: orderHelper.noteAdded,
        experienceId: orderHelper.selectedExperienceDetail.id!.toInt(),
        foodieId: (_appService.state.userInfo!.t.id),
        totalPrice: orderHelper.selectedExperienceDetail.price!.toInt(),
        scheduleId: int.parse(orderHelper.scheduleId),
        persons: orderHelper.numberOfPerson.toString(),
        // preferenceId: experienceData.preferenceId,
        preferenceId: 2,
      ),
    ).toJson();

    final response = await _network.post(
      path: url,
      data: bookingRequest,
      header: {
        'Authorization': 'Bearer ${_appService.state.userInfo?.t.authToken}',
        'Content-Type': 'application/json'
      }
    );

    bookingResponse = bookingResponseFromJson(response.body);
    Toaster.infoToast(context: context, message: bookingResponse.message);

    if (bookingResponse.code == 200) {
      emit(const Loaded());

      _navigation.navigateTo(route: BottomBar(bottomBarType: bottom_bar.BottomBarType.home));
      // Navigator.push(
      //   context,
      //   // MaterialPageRoute(builder: (context) => const FoodDetailScreen()),
      //   MaterialPageRoute(builder: (context) => const BottomBar()),
      // );
    } else {
      emit(const Loaded());
    }
  }
}
