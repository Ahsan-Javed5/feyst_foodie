import 'package:chef/helpers/helpers.dart';

import 'package:chef/models/booking/booking_list_request.dart' as baserequest;
import 'package:chef/models/booking/booking_status_update_request.dart'
    as booking_udpate;
import '../../bottom_bar/bottom_bar.dart' as bottom_bar;

import 'package:chef/models/booking/booking_list_response_model.dart';
import 'package:chef/screens/booking/booking_list/booking_list_screen_m.dart';
import '/setup.dart';

import 'dart:developer' as developer;

@injectable
class BookingListScreenViewModel extends BaseViewModel<BookingListState> {
  BookingListScreenViewModel({
    required INetworkService network,
  })  : _network = network,
        super(const Loading());

  final INetworkService _network;

  late BookingListModel bookingListModel;
  final _navigate = locateService<INavigationService>();
  final _appService = locateService<ApplicationService>();
  final _storage = locateService<IStorageService>();

  Future<void> getBookingListData(isBookingScreen) async {
    final type = isBookingScreen ? 'UPCOMING' : 'HISTORY';
    final url = InfininURLHelpers.getRestApiURL(
        Api.baseURL + Api.bookingListData + '?type=$type');

    String _userId = (_appService.state.userInfo?.t.id.toString()) ?? '45';

    emit(const Loading());

    final bookingListRequest = baserequest.BookingListRequest(
      t: int.parse(_userId),
    ).toJson();

    final _header = <String, String>{
      'Authorization': 'Bearer ${_storage.readString(key: 'auth_token')}',
      'Content-Type': 'application/json'
    };

    final response = await _network.post(
      path: url,
      data: bookingListRequest,
      header: _header,
    );

    bookingListModel = bookingListModelFromJson(response.body);
    //developer.log('booking id: ' + bookingListModel.t![0].id.toString());
    response.body != "" || response.body != null
        ? emit(Loaded(bookingListModel))
        : emit(const Loading());
  }

  Future<void> cancelBooking({required int bookingId}) async {
    final url =
        InfininURLHelpers.getRestApiURL(Api.baseURL + Api.cancelBooking);
    //emit(const Loading());

    final bookingUpdateRequest = booking_udpate.BookingUpdateRequest(
      t: bookingId,
    ).toJson();

    final response = await _network.post(
      path: url,
      data: bookingUpdateRequest,
      header: {
        'Authorization': 'Bearer ${_storage.readString(key: 'auth_token')}',
        'Content-Type': 'application/json'
      },
    );
    print(response);
    // var updatedBookingData = booking_udpate.bookingUpdateRequestFromJson(response.body);
    // if(response != null) {
    //   _navigate.navigateTo(
    //       route: BottomBar(bottomBarType: bottom_bar.BottomBarType.history));
    // }
  }
}
