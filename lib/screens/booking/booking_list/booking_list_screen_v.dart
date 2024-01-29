import 'package:chef/helpers/helpers.dart';
import 'package:chef/screens/booking/booking_list/booking_list_screen_m.dart';
import 'package:chef/screens/booking/booking_list/booking_list_screen_vm.dart';
import 'package:chef/screens/booking/food_item_booking.dart';
import 'package:chef/screens/guest_screens/guest_booking_screen.dart';
import 'package:chef/setup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingListScreen extends BaseView<BookingListScreenViewModel> {
  BookingListScreen({Key? key, required this.isBookingScreen})
      : super(key: key);
  bool isBookingScreen;

  @override
  Widget buildScreen(
      {required BuildContext context, required ScreenSizeData screenSizeData}) {
    final appTheme = AppTheme.of(context).theme;
    final _storage = locateService<IStorageService>();

    return BlocBuilder<BookingListScreenViewModel, BookingListState>(
        bloc: _storage.readString(key: 'auth_token').isEmpty
            ? viewModel
            : viewModel
          ..getBookingListData(isBookingScreen),
        builder: (context, state) {
          return Scaffold(
            backgroundColor: appTheme.colors.primaryBackground,
            body: _storage.readString(key: 'auth_token').isEmpty
                ? GuestBookingScreen(isBookingScreen: isBookingScreen)
                : state.when(
                    loading: _loading,
                    loaded: (bookingListModel) =>
                        displayLoaded(bookingListModel)),
          );
        });
  }

  Widget _loading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget displayLoaded(bookingListModel) {
    return FoodItemBooking(
        bookingListModel: bookingListModel, isBookingScreen: isBookingScreen);
  }
}
