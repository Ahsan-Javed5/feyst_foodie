import 'package:chef/theme/app_theme_data/app_theme_data.dart';
import 'package:flutter/material.dart';

import '../../constants/resources.dart';
import '../../constants/strings.dart';
import '../../helpers/color_helper.dart';
import '../../theme/app_theme_widget.dart';
import '../../ui_kit/helpers/dialog_helper.dart';
import '../../ui_kit/widgets/general_button.dart';
import '../../ui_kit/widgets/general_new_appbar.dart';
import '../../ui_kit/widgets/general_text.dart';
import '../home/food_item_booking_confirmed.dart';
import 'booking_in_process_screen.dart';
import 'food_item_advance_booking.dart';

class FoodItemBooking extends StatefulWidget {
  const FoodItemBooking({Key? key}) : super(key: key);

  @override
  State<FoodItemBooking> createState() => _FoodItemBookingState();
}

class _FoodItemBookingState extends State<FoodItemBooking> {
  List<BookingProgress> bookingProgressStatus = [];

  @override
  void initState() {
    // TODO: implement initState
    bookingProgressStatus.addAll([
      BookingProgress(
          bookingStatusIcon: Resources.timeLapsePNG,
          statusName: Strings.foodItemBookingApprovalPending),
      BookingProgress(
          bookingStatusIcon: Resources.hourglassPNG,
          statusName: Strings.foodItemBookingAdvancePending),
      BookingProgress(
          bookingStatusIcon: Resources.confirmUserPNG,
          statusName: Strings.foodItemBookingInProgress),
      BookingProgress(
          bookingStatusIcon: Resources.paymentPNG,
          statusName: Strings.foodItemBookingBookingConfirmed),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return Scaffold(
      backgroundColor: HexColor.fromHex("#212129"),
      body: Container(
        // padding: const EdgeInsets.only(left: 22, right: 22),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.only(left: 12, top: 20, bottom: 20),
                child: const GeneralNewAppBar(
                  rightIcon: Resources.homeIconSvg,
                  title: Strings.labelBookings,
                  titleColor: Colors.white,
                ),
              ),
              Expanded(child: bookingDetails(appTheme)),
            ]),
      ),
    );
  }

  Widget bookingDetails(IAppThemeData appTheme) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: bookingProgressStatus.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GeneralText(
                  Strings.foodItemBookingDate,
                  style: appTheme.typographies.interFontFamily.headline6
                      .copyWith(
                          fontSize: 12,
                          color: HexColor.fromHex('#fee4a4'),
                          fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  padding: EdgeInsets.only(left: 22, bottom: 40),
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: HexColor.fromHex("#4b4b52")),
                  child: InkWell(
                    onTap: () {
                      if (index == 1) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return FoodProductAdvancePendingDetails();
                        }));
                      } else if (index == 2) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return FoodItemInProcessBooking();
                        }));
                      } else if (index == 3) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return FoodProductBookingConfirmedDetails();
                        }));
                      }
                      // else{
                      //   _showGeneralPopup(context);
                      // }
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    Resources.bookingUserPNG,
                                    width: 35,
                                  ),
                                  SizedBox(
                                    width: 7.2,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GeneralText(
                                        Strings.foodItemBookingUserName,
                                        style: appTheme.typographies
                                            .interFontFamily.headline6
                                            .copyWith(
                                                fontSize: 15,
                                                color:
                                                    HexColor.fromHex('#ffffff'),
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 13.9,
                                            child: Image.asset(
                                                Resources.bookingStarPNG,
                                                fit: BoxFit.fill),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          GeneralText(
                                            Strings.foodItemBookingReviews,
                                            style: appTheme.typographies
                                                .interFontFamily.headline6
                                                .copyWith(
                                                    fontSize: 14,
                                                    color: HexColor.fromHex(
                                                        '#b0c18b')),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                  color: HexColor.fromHex("#bb3127"),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: GeneralText(
                                  Strings.foodItemBookingAmount,
                                  style: appTheme
                                      .typographies.interFontFamily.headline1
                                      .copyWith(
                                          fontSize: 19,
                                          color: HexColor.fromHex('#ffffff'),
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 22),
                            child: Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GeneralText(
                                    Strings.foodItemBookingName,
                                    style: appTheme
                                        .typographies.interFontFamily.headline1
                                        .copyWith(
                                            fontSize: 16,
                                            color: HexColor.fromHex('#909094'),
                                            fontWeight: FontWeight.w600),
                                  ),
                                  GeneralText(
                                    Strings.foodItemBookingNoPersons,
                                    style: appTheme
                                        .typographies.interFontFamily.headline1
                                        .copyWith(
                                            fontSize: 14,
                                            color: HexColor.fromHex('#fbeccb'),
                                            fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GeneralText(
                                    Strings.foodItemBookingDateTime,
                                    style: appTheme
                                        .typographies.interFontFamily.headline1
                                        .copyWith(
                                            fontSize: 14,
                                            color: HexColor.fromHex('#ffffff'),
                                            fontWeight: FontWeight.w400),
                                  ),
                                  GeneralText(
                                    Strings.foodItemBookingType,
                                    style: appTheme
                                        .typographies.interFontFamily.headline1
                                        .copyWith(
                                            fontSize: 14,
                                            color: HexColor.fromHex('#fee4a4'),
                                            fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              progressBar(appTheme, index),
                              SizedBox(
                                height: 23,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GeneralText(
                                    bookingProgressStatus[index].statusName ??
                                        "",
                                    style: appTheme
                                        .typographies.interFontFamily.headline1
                                        .copyWith(
                                            fontSize: 16,
                                            color: HexColor.fromHex('#f1c452'),
                                            fontWeight: FontWeight.w600),
                                  ),
                                ],
                              )
                            ]),
                          )
                        ]),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget progressBar(IAppThemeData appTheme, int index) {
    var progressBar;
    if (index == 0) {
      progressBar = Row(children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.8),
            width: 36,
            decoration: BoxDecoration(
                color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
            child: Image.asset(
              bookingProgressStatus[index].bookingStatusIcon!,
              width: 18.5,
              height: 18.5,
            ),
          ),
        ),
        SizedBox(
          width: 7.5,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 6,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#909094"), shape: BoxShape.circle),
        ),
        SizedBox(
          width: 2,
        ),
        Container(
            width: 64,
            // width: MediaQuery.of(context).size.width / 5,
            height: 1,
            color: HexColor.fromHex("#909094")),
        SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#909094"), shape: BoxShape.circle),
        ),
        SizedBox(
          width: 2,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 5,
          height: 1,
          color: HexColor.fromHex("#909094"),
        ),
        SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#909094"), shape: BoxShape.circle),
        ),
      ]);
    } else if (index == 1) {
      progressBar = Row(children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        SizedBox(
          width: 7.5,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 6,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        SizedBox(
          width: 2,
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.8),
            width: 36,
            decoration: BoxDecoration(
                color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
            child: Image.asset(
              bookingProgressStatus[index].bookingStatusIcon!,
              width: 18.5,
              height: 18.5,
            ),
          ),
        ),
        SizedBox(
          width: 2,
        ),
        Container(
            width: 64,
            // width: MediaQuery.of(context).size.width / 5,
            height: 1,
            color: HexColor.fromHex("#909094")),
        SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#909094"), shape: BoxShape.circle),
        ),
        SizedBox(
          width: 2,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 5,
          height: 1,
          color: HexColor.fromHex("#909094"),
        ),
        SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#909094"), shape: BoxShape.circle),
        ),
      ]);
    } else if (index == 2) {
      progressBar = Row(children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        SizedBox(
          width: 7.5,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 6,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        SizedBox(
          width: 2,
        ),
        Container(
            width: 64,
            // width: MediaQuery.of(context).size.width / 5,
            height: 1,
            color: HexColor.fromHex("#f1c452")),
        SizedBox(
          width: 2,
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.8),
            width: 36,
            decoration: BoxDecoration(
                color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
            child: Image.asset(
              bookingProgressStatus[index].bookingStatusIcon!,
              width: 18.5,
              height: 18.5,
            ),
          ),
        ),
        SizedBox(
          width: 2,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 5,
          height: 1,
          color: HexColor.fromHex("#909094"),
        ),
        SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#909094"), shape: BoxShape.circle),
        ),
      ]);
    } else if (index == 3) {
      progressBar = Row(children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        SizedBox(
          width: 7.5,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 6,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        SizedBox(
          width: 2,
        ),
        Container(
            width: 64,
            // width: MediaQuery.of(context).size.width / 5,
            height: 1,
            color: HexColor.fromHex("#f1c452")),
        SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        SizedBox(
          width: 2,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 5,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        SizedBox(
          width: 2,
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.8),
            width: 36,
            decoration: BoxDecoration(
                color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
            child: Image.asset(
              bookingProgressStatus[index].bookingStatusIcon!,
              width: 18.5,
              height: 18.5,
            ),
          ),
        ),
      ]);
    }

    return progressBar;
  }

  Future<dynamic> _showGeneralPopup(BuildContext context) async {
    final appTheme = AppTheme.of(context).theme;

    return DialogHelper.show(
      context: context,
      // dialogType: GeneralComponentStyle.success,
      isDismissible: true,
      barrierLabel: '',
      // title: 'Verification\nCode',
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outlined,
              color: appTheme.colors.secondaryBackground,
              size: 45,
            ),
            GeneralText(
              Strings.generalPopupTitle,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: appTheme.colors.secondaryBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 19,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GeneralText(
                Strings.generalSubTitle,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: appTheme.typographies.interFontFamily.headline4.copyWith(
                    color: Color(0xfffee4a4),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 31,
            ),
            GeneralButton.button(
              title: Strings.generalButtonTitle.toUpperCase(),
              styleType: ButtonStyleType.fill,
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SignUpScreen()),
                // );
                //    viewModel.goToForgotPasswordScreen();
              },
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
      // body: GBottomSheet<String>(
      //   bottomSheetTitle: Strings.chooseDateFormat,
      //   list: ['7878,87,876'],
      //   selectedItem: viewModel.getSelectedFormat(),
      //   bottomSheetType: BottomSheetType.dateFormat,
      // ),
    );
  }
}

class BookingProgress {
  String? statusName;
  String? bookingStatusIcon;

  BookingProgress({this.statusName, this.bookingStatusIcon});
}
