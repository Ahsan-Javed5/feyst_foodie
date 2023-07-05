import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/booking/rating_request.dart' as rating_request;
import 'package:chef/models/booking/rating_resposne.dart';
import 'package:chef/screens/bottom_bar/bottom_bar.dart' as bottom_bar;
import '../../../models/booking/rating_request.dart';
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
  final ratingController = TextEditingController();

  // void initialize() {
  //   developer.log(' Initialized the data ');
  //   emit(Loaded());
  // }

  Future<void> getBookingDetails(int _orderId) async {
    final url = InfininURLHelpers.getRestApiURL(
        Api.baseURL + Api.bookingDetailsAdvancePaymentPending);
    final _appService = locateService<ApplicationService>();
    final _navigate = locateService<INavigationService>();

    // String _userId = (_appService.state.userInfo?.t.id.toString())! ?? '45';

    emit(const Loading());
    data.T dataRequest = data.T(id: _orderId);

    // signuprequest.T t = signuprequest.T(
    //   age: age.toString(),
    //   name: name,
    //   gender: gender,
    //   mobileNo: mobileNumber,
    //   professionalId: professionId,
    //   profileImageUrl: null,
    // );

    // final signUpCredentials = SignupRequest(
    //   t: t,
    // ).toJson();
    //SignupRequest
    // final bookingListRequest = request.SignupRequest(
    //   //  userId: int.parse(_userId),
    //
    //   t: dataRequest,
    // ).toJson();

    final response = await _network.post(
      path: url,
      data: {'t': _orderId},
      header: {
        'Authorization': 'Bearer ${_appService.state.userInfo?.t.authToken}',
        'Content-Type': 'application/json'
      },
    );

    advancePendingResponse = advancePendingResponseFromJson(response.body);

    // advancePendingResponse

    response.body != "" || response.body != null
        ? emit(Loaded(advancePendingResponse))
        : emit(const Loading());
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

    rating_request.T t = rating_request.T(
      bookingId: bookingId,
      comments: ratingController.text,
      experienceId: experienceId,
      foodieId: _appService.state.userInfo?.t.id,
      stars: stars.toString()
    );

    final ratingRequest = rating_request.RatingRequest(
      t: t,
    ).toJson();

    final response = await _network.post(
      path: url,
      data: ratingRequest,
      header: {
        'Authorization': 'Bearer ${_appService.state.userInfo?.t.authToken}',
        'Content-Type': 'application/json'
      },
    );

    if (response != null) {
      developer.log(' Response of Rating body is ' + '${response.body}');

      RatingResponse ratingResponse = ratingResponseFromJson(response.body);

      Toaster.infoToast(context: context, message: ratingResponse.message.toString());

      _navigate.navigateTo(
          route: BottomBar(bottomBarType: bottom_bar.BottomBarType.history));

    } else {
      Toaster.infoToast(
          context: context,
          message: 'Something is wrong please content vendor');
      developer.log(' Response of Signup is null ' + '$response');
    }
  }

}
