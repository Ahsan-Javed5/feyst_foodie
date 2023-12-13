import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/booking/rating_request.dart' as rating_request;
import 'package:chef/models/booking/rating_resposne.dart';
import 'package:chef/screens/bottom_bar/bottom_bar.dart' as bottom_bar;
import '../../../models/booking/rating_request.dart';
import '../../../models/home/chef_data_response.dart';
import '/models/booking/advance_pending_response.dart';
import '/models/signup/signup_request.dart' as request;
import '/helpers/data_request.dart' as data;
import '../../../setup.dart';
import 'booking_in_process_screen_m.dart';
import 'dart:developer' as developer;

@injectable
class BookingInProcessScreenViewModel
    extends BaseViewModel<BookingInProcessScreenState> {
  BookingInProcessScreenViewModel({
    required INetworkService network,
  })  : _network = network,
        super(const Loading());

  final INetworkService _network;

  late AdvancePendingResponse advancePendingResponse;
  late ChefDataResponse chefData;
  final ratingController = TextEditingController();
  final _storage = locateService<IStorageService>();

  // void initialize() {
  //   developer.log(' Initialized the data ');
  //   emit(Loaded());
  // }

  Future<void> getBookingDetails(int _orderId) async {
    developer.log('order id is: $_orderId');
    final url = InfininURLHelpers.getRestApiURL(
        Api.baseURL + Api.bookingDetailsAdvancePaymentPending);

    emit(const Loading());

    try {
      final response = await _network.post(
        path: url,
        data: {'t': _orderId},
        header: {
          'Authorization': 'Bearer ${_storage.readString(key: 'auth_token')}',
          'Content-Type': 'application/json'
        },
      );

      advancePendingResponse = advancePendingResponseFromJson(response.body);

      response.body != "" || response.body != null
          ? getChefData(advancePendingResponse)
          : emit(const Loading());
    } catch (e) {
      print(e);
      // TODO
    }
  }

  Future<ChefDataResponse?> getChefData(AdvancePendingResponse advancePendingResponse) async {
    final url = InfininURLHelpers.getRestApiURL(Api.baseURL + Api.chefData);

    final response = await _network.post(
        path: url,
        data: {
          "t": int.parse(advancePendingResponse.t.chefId.toString())
        },
        header: {
      'Authorization': 'Bearer ${_storage.readString(key: 'auth_token')}',
      'Content-Type': 'application/json'
    });

    chefData = chefModelFromJson(response.body);
    response.body != "" || response.body != null
        ? emit(Loaded(advancePendingResponse, chefData))
        : emit(const Loading());
    return null;
   // emit(Loaded(foodData, scheduleData, chefData));
    //return chefData;
  }

  Future<void> requestConfirmBooking(int bookingId) async {
    final url =
        InfininURLHelpers.getRestApiURL(Api.baseURL + Api.confirmBooking);
    final _appService = locateService<ApplicationService>();
    final _navigate = locateService<INavigationService>();

    emit(const Loading());

    final response = await _network.post(
      path: url,
      data: {'t': bookingId},
    );

    //  advancePendingResponse = advancePendingResponseFromJson(response.body);

    // advancePendingResponse

    // response.body != "" || response.body != null
    //     ? emit(Loaded(advancePendingResponse))
    //     : emit(const Loading());
  }

  Future<void> saveRating({required bookingId, required experienceId, required stars, required context}) async {
    final url =
    InfininURLHelpers.getRestApiURL(Api.baseURL + Api.saveRating);
    final _appService = locateService<ApplicationService>();
    final _navigate = locateService<INavigationService>();

    emit(const Loading());

    try {
      final response = await _network.post(
        path: url,
        data: {
          "t": {
            "bookingId": bookingId,
            "comments": ratingController.text,
            "experienceId": experienceId,
            "foodieId": _appService.state.userInfo?.t.id,
            "stars": stars
          }
        },

        header: {
          'Authorization': 'Bearer ${_storage.readString(key: 'auth_token')}',
          'Content-Type': 'application/json'
        },
      );

      if (response != null) {
        developer.log(' Response of Rating body is ' + '${response.body}');

        RatingResponse ratingResponse = ratingResponseFromJson(response.body);

        Toaster.successToast(context: context, message: ratingResponse.message.toString());

        _navigate.navigateTo(
            route: BottomBar(bottomBarType: bottom_bar.BottomBarType.history));

      } else {
        Toaster.infoToast(
            context: context,
            message: 'Something is wrong please content vendor');
        developer.log(' Response of Signup is null ' + '$response');
      }
    } catch (e) {
      print(e);
    }
  }

}
