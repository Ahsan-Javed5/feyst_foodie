
import 'package:chef/base/base_viewmodel.dart';
import 'package:chef/helpers/url_helper.dart';
import 'package:chef/models/booking/booking_list_request.dart'as baserequest;
import 'package:chef/models/booking/booking_list_response_model.dart';
import 'package:chef/screens/booking/booking_list/booking_list_screen_m.dart';
import 'package:chef/services/network/network_service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../constants/api.dart';

@injectable
class  BookingListScreenViewModel extends BaseViewModel<BookingListState> {
  BookingListScreenViewModel({
    required INetworkService network,
  }) : _network = network, super(const Loading());


  final INetworkService _network;

  late BookingListModel bookingListModel;

  Future<void> getBookingListData({required String userId}) async {
    final url =
    InfininURLHelpers.getRestApiURL(Api.baseURL + Api.bookingListData);

    emit(const Loading());

    final bookingListRequest = baserequest.BookingListRequest(
      userId: int.parse(userId),
    ).toJson();

    final response = await _network.post(
      path: url,
      data: bookingListRequest,
    );

    bookingListModel = bookingListModelFromJson(response.body);

    response.body != "" || response.body != null ?  emit(Loaded(bookingListModel)) : emit(const Loading());
  }
}