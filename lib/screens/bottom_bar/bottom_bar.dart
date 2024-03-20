import 'package:auto_route/annotations.dart';
import 'package:chef/screens/booking/booking_list/booking_list_screen_v.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/resources.dart';
import '../../constants/strings.dart';
import '../../helpers/device_helper.dart';
import '../../theme/app_theme_widget.dart';
import '../../ui_kit/widgets/general_text.dart';
import '../home/home_screen_v.dart';
import '../user_account/edit_profie/edit_profile_screen_v.dart';

@RoutePage()
class BottomBarScreen extends StatefulWidget {
  BottomBarScreen({Key? key, this.bottomBarType = BottomBarType.home})
      : super(key: key);
  BottomBarType bottomBarType;
  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState>? drawerKey = GlobalKey();
  // BottomBarType selectedType = widget.bottomBarType;
  List<Widget> screens = [
    HomeScreen(),
    // UserProfile(),
    // FoodItemBooking(),
    BookingListScreen(
      isBookingScreen: true,
    ),
    // FoodDetailScreen(),
    BookingListScreen(
      isBookingScreen: false,
    ),
    EditProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[widget.bottomBarType.index],
        bottomNavigationBar: _bottomNavigationContainer(context));
  }

  Widget _bottomNavigationContainer(BuildContext context) {
    return Container(
      // color: Color(0xff212129),
      color: Colors.black,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: DeviceHelper.width * 0.040,
      ),
      height: DeviceHelper.height * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _itemBar(context, Resources.homeIconSvg, Strings.homeTitle,
              BottomBarType.home),
          // SizedBox(
          //   width: DynamicSize.exactWidth(37, context),
          // ),
          _itemBar(context, Resources.calenderIconSvg, Strings.bookingTitle,
              BottomBarType.bookings),
          // SizedBox(
          //   width: DynamicSize.exactWidth(37, context),
          // ),
          _itemBar(context, Resources.historyRecentIconSvg,
              Strings.historyTitle, BottomBarType.history),
          // SizedBox(
          //   width: DynamicSize.exactWidth(37, context),
          // ),
          _itemBar(context, Resources.peopleIconSvg, Strings.profileTitle,
              BottomBarType.profile),
        ],
      ),
    );
  }

  Widget _itemBar(BuildContext context, String imagePath, String title,
      BottomBarType type) {
    final appTheme = AppTheme.of(context).theme;
    return InkWell(
      onTap: () {
        setState(() {
          widget.bottomBarType = type;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(
            imagePath,
            height: DeviceHelper.height * 0.025,
          ),
          SizedBox(
            height: DeviceHelper.height * 0.005,
          ),
          GeneralText(
            title,
            style: appTheme.typographies.interFontFamily.headline2.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: DeviceHelper.height * 0.010,
          ),
          AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInToLinear,
              height: DeviceHelper.height * 0.005,
              width: DeviceHelper.width * 0.050,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), // radius of 10
                  color: widget.bottomBarType == type
                      ? const Color(0xffb0c18b)
                      : Colors.transparent

                  // green as background color
                  )),
        ],
      ),
    );
  }
}

enum BottomBarType {
  home,
  bookings,
  history,
  profile,
}
