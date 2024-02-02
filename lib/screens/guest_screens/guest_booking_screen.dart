import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/resources.dart';
import '../../constants/strings.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/device_helper.dart';
import 'package:chef/screens/bottom_bar/bottom_bar.dart' as bottom_bar;

import '../../services/navigation/navigation_service.dart';
import '../../services/navigation/router.gr.dart';
import '../../setup.dart';
import '../../theme/app_theme_data/app_theme_data.dart';
import '../../theme/app_theme_widget.dart';
import '../../ui_kit/widgets/general_button.dart';
import '../../ui_kit/widgets/general_new_appbar.dart';
import '../../ui_kit/widgets/general_text.dart';

class GuestBookingScreen extends StatefulWidget {
  const GuestBookingScreen({
    Key? key,
    required this.isBookingScreen,
  }) : super(key: key);

  final bool isBookingScreen;

  @override
  State<GuestBookingScreen> createState() => _GuestBookingScreenState();
}

class _GuestBookingScreenState extends State<GuestBookingScreen> {
  final _navigation = locateService<INavigationService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return WillPopScope(
        onWillPop: () => onWillPop(),
        child: Scaffold(
          backgroundColor: HexColor.fromHex("#212129"),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: DeviceHelper.height * 0.065,
            ),
            Container(
              padding: EdgeInsets.only(
                left: DeviceHelper.height * 0.015,
                top: DeviceHelper.height * 0.0025,
                bottom: DeviceHelper.height * 0.025,
              ),
              child: GeneralNewAppBar(
                rightIcon: Resources.homeIconSvg,
                title: widget.isBookingScreen
                    ? Strings.labelBookings
                    : Strings.lableHistory,
                titleColor: Colors.white,
                callBack: () {
                  _navigation.navigateTo(
                      route: BottomBar(
                          bottomBarType: bottom_bar.BottomBarType.home));
                },
              ),
            ),
            Expanded(
                child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  SvgPicture.asset(
                    widget.isBookingScreen
                        ? 'assets/images/icons/smartphone.svg'
                        : 'assets/images/icons/list.svg',
                    fit: BoxFit.scaleDown,
                    height: 200,
                    width: 100,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GeneralText(
                    'Please login to proceed further',
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: appTheme.typographies.interFontFamily.headline4
                        .copyWith(
                            color: const Color(0xfffee4a4),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _loginButtonTitle(appTheme: appTheme),
                ],
              ),
            )),
          ]),
        ));
  }

  Future<bool> onWillPop() async {
    return false;
  }

  Widget _loginButtonTitle({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      width: 180,
      title: Strings.login.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        _navigation.navigateTo(route: SignInRoute());
      },
    );
  }
}
