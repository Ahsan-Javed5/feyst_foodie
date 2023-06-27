import 'package:chef/base/base_viewmodel.dart';
import 'package:chef/helpers/helpers.dart';
import 'package:chef/helpers/url_helper.dart';
import 'package:chef/screens/bottom_bar/bottom_bar.dart' as bottom_bar;
import 'package:chef/models/booking/booking_status_update_request.dart' as booking_udpate;
import 'package:chef/services/network/network_service.dart';
import 'package:injectable/injectable.dart';

import '../../../constants/api.dart';
import '../../../models/booking/advance_pending_response.dart';
import '../../../models/booking/confirmed_booking_response.dart';
import '../../../models/signup/signup_request.dart' as request;
import '../../../helpers/data_request.dart' as data;
import '../../../services/application_state.dart';
import '../../../setup.dart';
import 'food_item_advance_payment_m.dart';

import 'dart:developer' as developer;

@injectable
class FoodItemAdvancePaymentViewModel
    extends BaseViewModel<FoodItemAdvancePaymentState> {
  FoodItemAdvancePaymentViewModel({
    required INetworkService network,
  })  : _network = network,
        super(const Loading());

  final INetworkService _network;

  late AdvancePendingResponse advancePendingResponse;

  late ConfirmedBookingResponse confirmedBookingResponse;

  final _navigate = locateService<INavigationService>();


  Future<void> getBookingDetails(int _orderId) async {
    final url = InfininURLHelpers.getRestApiURL(
        Api.baseURL + Api.bookingDetailsAdvancePaymentPending);

    emit(const Loading());
    final response = await _network.post(
      path: url,
      data: {'t': _orderId},
    );

    advancePendingResponse = advancePendingResponseFromJson(response.body);

    response.body != "" || response.body != null
        ? emit(Loaded(advancePendingResponse))
        : emit(const Loading());
  }

  Future<void> requestConfirmBooking(int bookingId) async {
    final url =
        InfininURLHelpers.getRestApiURL(Api.baseURL + Api.confirmBooking);

    emit(const Loading());

    final response = await _network.post(
      path: url,
      data: {'t': bookingId},
    );

    developer.log(' Response of confirm is ' + '${response.body}');

    confirmedBookingResponse = confirmedBookingResponseFromJson(response.body);

    _navigate.navigateTo(route: BottomBar(bottomBarType: bottom_bar.BottomBarType.home));
  }

  Future<void> updateBookingStatus({required int bookingId}) async {
    final url =
    InfininURLHelpers.getRestApiURL(Api.baseURL + Api.experienceMenuById);
    //emit(const Loading());

    final bookingUpdateRequest = booking_udpate.BookingUpdateRequest(
      t: bookingId,
    ).toJson();

    final response = await _network.post(
      path: url,
      data: bookingUpdateRequest,
    );

   // var updatedBookingData = booking_udpate.bookingUpdateRequestFromJson(response.body);
    _navigate.navigateTo(route: BottomBar(bottomBarType: bottom_bar.BottomBarType.bookings));
  }

  Future<void> completeBookingStatus({required int bookingId}) async {
    final url =
    InfininURLHelpers.getRestApiURL(Api.baseURL + Api.experienceMenuById);
    //emit(const Loading());

    final bookingUpdateRequest = booking_udpate.BookingUpdateRequest(
      t: bookingId,
    ).toJson();

    final response = await _network.post(
      path: url,
      data: bookingUpdateRequest,
    );

    // var updatedBookingData = booking_udpate.bookingUpdateRequestFromJson(response.body);
    _navigate.navigateTo(route: BottomBar(bottomBarType: bottom_bar.BottomBarType.bookings));
  }

}
