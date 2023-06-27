import 'package:chef/base/base_viewmodel.dart';
import 'package:chef/helpers/url_helper.dart';
import 'package:chef/models/booking/booking_list_request.dart' as baserequest;
import 'package:chef/models/booking/booking_status_update_request.dart' as booking_udpate;
import 'package:chef/models/booking/booking_list_response_model.dart';
import 'package:chef/screens/booking/booking_list/booking_list_screen_m.dart';
import 'package:chef/services/network/network_service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../constants/api.dart';
import '../../../services/application_state.dart';
import '../../../setup.dart';

import 'dart:developer' as developer;

@injectable
class BookingListScreenViewModel extends BaseViewModel<BookingListState> {
  BookingListScreenViewModel({
    required INetworkService network,
  })  : _network = network,
        super(const Loading());

  final INetworkService _network;

  late BookingListModel bookingListModel;

  Future<void> getBookingListData(isBookingScreen) async {
    // final url =
    //     InfininURLHelpers.getRestApiURL(Api.baseURL + Api.bookingListData);
    final type = isBookingScreen ? 'UPCOMING' : 'HISTORY';
    final url = InfininURLHelpers.getRestApiURL(Api.baseURL + Api.bookingListData + '?type=$type');
    //final url = 'http://18.202.117.137:8080/feyst-service/experience-booking/find-by-foodie-id?type=UPCOMING';
    // final url = InfininURLHelpers.getRestApiURL(
    //     baseUrl + "foodie/profile-image/${_appService.state.userInfo!.t.id}");


    final _appService = locateService<ApplicationService>();

    String _userId = (_appService.state.userInfo?.t.id.toString()) ?? '45';

    developer.log(' User Id is ' + '${_appService.state.userInfo?.t.id}');

    emit(const Loading());

    final bookingListRequest = baserequest.BookingListRequest(
      t: int.parse(_userId),
    ).toJson();

    final response = await _network.post(
      path: url,
      data: bookingListRequest,
    );

    bookingListModel = bookingListModelFromJson(response.body);

    response.body != "" || response.body != null
        ? emit(Loaded(bookingListModel))
        : emit(const Loading());
  }

  Future<void> cancelBooking({required int bookingId}) async {
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
   // _navigate.navigateTo(route: BottomBar(bottomBarType: bottom_bar.BottomBarType.bookings));
  }


}
