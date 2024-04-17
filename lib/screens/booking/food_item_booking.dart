import 'package:chef/constants/api.dart';
import 'package:chef/models/booking/booking_list_response_model.dart';
import 'package:chef/theme/app_theme_data/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/resources.dart';
import '../../constants/strings.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/device_helper.dart';
import '../../services/navigation/app_router.dart';
import '../../services/navigation/app_router.dart' as nav;

import '../../services/navigation/navigation_service.dart';

import 'package:chef/screens/bottom_bar/bottom_bar.dart' as bottom_bar;
import '../../setup.dart';
import '../../theme/app_theme_widget.dart';
import '../../ui_kit/helpers/dialog_helper.dart';
import '../../ui_kit/widgets/general_button.dart';
import '../../ui_kit/widgets/general_new_appbar.dart';
import '../../ui_kit/widgets/general_text.dart';

import 'dart:developer' as developer;

class FoodItemBooking extends StatefulWidget {
  const FoodItemBooking(
      {Key? key, this.bookingListModel, required this.isBookingScreen})
      : super(key: key);

  final BookingListModel? bookingListModel;
  final bool isBookingScreen;

  @override
  State<FoodItemBooking> createState() => _FoodItemBookingState();
}

class _FoodItemBookingState extends State<FoodItemBooking> {
  List<BookingItem> bookingProgressStatus = [];
  List<BookingProgress> bookingProgres = [];

  final _navigation = locateService<INavigationService>();

  @override
  void initState() {
    var list = widget.bookingListModel?.t?.reversed;
    bookingProgressStatus.addAll(list!);
    bookingProgres.addAll([
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
      BookingProgress(
          bookingStatusIcon: Resources.completedPNG,
          statusName: Strings.completeStatus),
      BookingProgress(
          bookingStatusIcon: Resources.declinedPNG,
          statusName: Strings.declined),
    ]);
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
                      route: BottomBarRoute(
                          bottomBarType: bottom_bar.BottomBarType.home));
                },
              ),
            ),
            Expanded(child: bookingDetails(appTheme)),
          ]),
        ));
  }

  Future<bool> onWillPop() async {
    return false;
  }

  String getMonthName(int month) {
    List<String> monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return monthNames[month - 1];
  }

  Widget bookingDetails(IAppThemeData appTheme) {
    return bookingProgressStatus.isEmpty
        ? Center(
            child: GeneralText(
              widget.isBookingScreen
                  ? Strings.noBookingsYet
                  : Strings.noHistoryYet,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: const Color(0xff8ea659),
                  fontSize: 27,
                  fontWeight: FontWeight.bold),
            ),
          )
        : Container(
            margin:
                EdgeInsets.symmetric(horizontal: DeviceHelper.height * 0.025),
            child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: bookingProgressStatus.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = bookingProgressStatus[index];
                  const noImage = Resources.bookingUserPNG;
                  final imageUrl = item.preferenceIconPath;
                  DateTime date =
                      DateTime.parse(item.scheduleScheduledDate ?? '');
                  String formattedDate =
                      "${date.day} ${getMonthName(date.month)}";

                  String timeString = item.scheduleStartTime ?? '';
                  DateFormat inputFormat = DateFormat('HH:mm:ss');
                  DateTime dateTime = inputFormat.parse(timeString);
                  DateFormat outputFormat = DateFormat('hh a');
                  String formattedTime = outputFormat.format(dateTime);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GeneralText(
                        item.scheduleScheduledDate.toString(),
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                                fontSize: 12,
                                color: HexColor.fromHex('#fee4a4'),
                                fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: DeviceHelper.height * 0.015,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: DeviceHelper.width * 0.04,
                            bottom: DeviceHelper.height * 0.05),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                DeviceHelper.width * 0.05),
                            color: HexColor.fromHex("#4b4b52")),
                        child: InkWell(
                          onTap: () {
                            //if (index == 1) {
                            if (item.bookingStatus.toString().toUpperCase() ==
                                    Strings.acceptData ||
                                item.bookingStatus.toString().toUpperCase() ==
                                    Strings.pendingValue ||
                                item.bookingStatus.toString().toUpperCase() ==
                                    'DECLINED' ||
                                item.bookingStatus.toString().toUpperCase() ==
                                    'MISSED') {
                              _navigation.navigateTo(
                                  route: nav.FoodItemAdvancePaymentRoute(
                                      bookingItem: item));
                            } else {
                              _navigation.navigateTo(
                                  route: nav.BookingInProcessRouteView(
                                      bookingItem: item));
                            }
                          },
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ///image, name, rating, price row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        ClipOval(
                                          child: item.chefProfileImageUrl !=
                                                  null
                                              ? Image.network(
                                                  Api.baseURLForImages +
                                                      item.chefProfileImageUrl
                                                          .toString(),
                                                  width:
                                                      DeviceHelper.width * 0.10,
                                                  height:
                                                      DeviceHelper.width * 0.10,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  noImage,
                                                  width:
                                                      DeviceHelper.width * 0.10,
                                                  height:
                                                      DeviceHelper.width * 0.10,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        SizedBox(
                                          width: DeviceHelper.width * 0.02,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              //color: Colors.green,
                                              width: DeviceHelper.width * 0.34,
                                              child: GeneralText(
                                                item.experienceName ?? "",
                                                maxLines: 2,
                                                style: appTheme.typographies
                                                    .interFontFamily.headline6
                                                    .copyWith(
                                                        //overflow: TextOverflow.ellipsis,
                                                        fontSize: 15,
                                                        color: HexColor.fromHex(
                                                            '#ffffff'),
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ),
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: DeviceHelper.width *
                                                      0.040,
                                                  child: Image.asset(
                                                      Resources.bookingStarPNG,
                                                      fit: BoxFit.fill),
                                                ),
                                                SizedBox(
                                                  width: DeviceHelper.width *
                                                      0.015,
                                                ),
                                                GeneralText(
                                                  item.experienceAverageRating
                                                          ?.toString() ??
                                                      Strings.noReviews,
                                                  style: appTheme.typographies
                                                      .interFontFamily.headline6
                                                      .copyWith(
                                                          fontSize: 14,
                                                          color:
                                                              HexColor.fromHex(
                                                                  '#b0c18b')),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(
                                          DeviceHelper.height * 0.025),
                                      decoration: BoxDecoration(
                                        color: HexColor.fromHex("#bb3127"),
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(50),
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: GeneralText(
                                        Strings.rsLabel +
                                            '' +
                                            item.totalPrice.toString(),
                                        style: appTheme.typographies
                                            .interFontFamily.headline1
                                            .copyWith(
                                                fontSize: 18,
                                                color:
                                                    HexColor.fromHex('#ffffff'),
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: DeviceHelper.height * 0.025,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(right: 22),
                                  child: Column(children: [
                                    ///brands name and persons row
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GeneralText(
                                          item.brandName ?? "",
                                          style: appTheme.typographies
                                              .interFontFamily.headline1
                                              .copyWith(
                                                  fontSize: 16,
                                                  color: HexColor.fromHex(
                                                      '#909094'),
                                                  fontWeight: FontWeight.w600),
                                        ),
                                        item != null && item.persons != null
                                            ? GeneralText(
                                                item.persons! +
                                                    Strings.personsLabel,
                                                style: appTheme.typographies
                                                    .interFontFamily.headline1
                                                    .copyWith(
                                                        fontSize: 14,
                                                        color: HexColor.fromHex(
                                                            '#fbeccb'),
                                                        fontWeight:
                                                            FontWeight.w400),
                                              )
                                            : Container(),
                                      ],
                                    ),

                                    ///date and preference row
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GeneralText(
                                          "${formattedDate ?? ""} @ ${formattedTime}",
                                          style: appTheme.typographies
                                              .interFontFamily.headline1
                                              .copyWith(
                                                  fontSize: 14,
                                                  color: HexColor.fromHex(
                                                      '#ffffff'),
                                                  fontWeight: FontWeight.w400),
                                        ),
                                        GeneralText(
                                          item.preferenceName ?? "",
                                          style: appTheme.typographies
                                              .interFontFamily.headline1
                                              .copyWith(
                                                  fontSize: 14,
                                                  color: HexColor.fromHex(
                                                      '#fee4a4'),
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: DeviceHelper.height * 0.032,
                                    ),
                                    progressBar(
                                        appTheme,
                                        getBookingIconData(item.bookingStatus),
                                        item.bookingStatus!),
                                    SizedBox(
                                      height: DeviceHelper.height * 0.0375,
                                    ),

                                    ///booking status
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GeneralText(
                                          //getStatus(item.bookingStatus.toString()),
                                          item.bookingStatus ?? "",
                                          style: appTheme.typographies
                                              .interFontFamily.headline1
                                              .copyWith(
                                                  fontSize: 16,
                                                  color: HexColor.fromHex(
                                                      '#f1c452'),
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    item.bookingStatus?.toUpperCase() ==
                                            Strings.acceptData
                                        ? GeneralText(
                                            Strings.pleasePayAdvanceDescription,
                                            //  item.bookingStatus ?? "",
                                            style: appTheme.typographies
                                                .interFontFamily.headline1
                                                .copyWith(
                                              fontSize: 13,
                                              color:
                                                  HexColor.fromHex('#909094'),
                                            ),
                                          )
                                        : Container(),
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

  String getStatus(String status) {
    switch (status.toUpperCase()) {
      case Strings.acceptData:
        return Strings.acceptData;
      case Strings.requestedOrder:
        return Strings.pendingValue;
      case Strings.confirmed:
        return Strings.confirmed;
      case Strings.inProgress:
        return Strings.inProgressValue;
      case Strings.billGenerated:
        return Strings.billGeneratedValue;
      case Strings.completeStatus:
        return Strings.completeStatus;
      default:
        return Strings.cancelled;
    }
  }

  Widget progressBar(IAppThemeData appTheme, int index, String bookingStatus) {
    var progressBar;
    developer.log(' Booking Status is ' + bookingStatus);

    if (bookingStatus.toUpperCase() == Strings.pendingValue) {
      progressBar = Row(children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.8),
            width: 36,
            decoration: BoxDecoration(
                color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
            child: Image.asset(
              bookingStatus == 'ACCEPTED'
                  ? Resources.hourglassPNG
                  : bookingProgres[index].bookingStatusIcon!,
              width: 18.5,
              height: 18.5,
            ),
          ),
        ),
        const SizedBox(
          width: 7.5,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 6,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#909094"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
            width: 64,
            // width: MediaQuery.of(context).size.width / 5,
            height: 1,
            color: HexColor.fromHex("#909094")),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#909094"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 5,
          height: 1,
          color: HexColor.fromHex("#909094"),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#909094"), shape: BoxShape.circle),
        ),
      ]);
    } else if (bookingStatus.toUpperCase() == Strings.acceptData) {
      progressBar = Row(children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 7.5,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 6,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        const SizedBox(
          width: 2,
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.8),
            width: 36,
            decoration: BoxDecoration(
                color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
            child: Image.asset(
              Resources
                  .hourglassPNG, //   bookingProgres[index].bookingStatusIcon!,
              width: 18.5,
              height: 18.5,
            ),
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
            width: 64,
            // width: MediaQuery.of(context).size.width / 5,
            height: 1,
            color: HexColor.fromHex("#909094")),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#909094"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 5,
          height: 1,
          color: HexColor.fromHex("#909094"),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#909094"), shape: BoxShape.circle),
        ),
      ]);
    } else if (bookingStatus.toUpperCase() == Strings.billGenerated) {
      progressBar = Row(children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 7.5,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 6,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 6,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 6,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        const SizedBox(
          width: 2,
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.8),
            width: 36,
            decoration: BoxDecoration(
                color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
            child: Image.asset(
              Resources
                  .billGeneratedPNG, //   bookingProgres[index].bookingStatusIcon!,
              width: 18.5,
              height: 18.5,
            ),
          ),
        ),
      ]);
    } else if (bookingStatus.toUpperCase() == Strings.inProgress) {
      progressBar = Row(children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 7.5,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 6,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 6,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 6,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        const SizedBox(
          width: 2,
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.8),
            width: 36,
            decoration: BoxDecoration(
                color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
            child: Image.asset(
              Resources
                  .paymentPNG, //   bookingProgres[index].bookingStatusIcon!,
              width: 18.5,
              height: 18.5,
            ),
          ),
        ),
      ]);
    } else if (bookingStatus.toUpperCase() == Strings.confirmed.toUpperCase()) {
      progressBar = Row(children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 7.5,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 6,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
            width: 64,
            // width: MediaQuery.of(context).size.width / 5,
            height: 1,
            color: HexColor.fromHex("#f1c452")),
        const SizedBox(
          width: 2,
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.8),
            width: 36,
            decoration: BoxDecoration(
                color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
            child: Image.asset(
              bookingProgres[index].bookingStatusIcon!,
              width: 18.5,
              height: 18.5,
            ),
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 5,
          height: 1,
          color: HexColor.fromHex("#909094"),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#909094"), shape: BoxShape.circle),
        ),
      ]);
    } else if (bookingStatus.toUpperCase() == Strings.completeStatus) {
      progressBar = Row(children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 7.5,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 6,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
            width: 64,
            // width: MediaQuery.of(context).size.width / 5,
            height: 1,
            color: HexColor.fromHex("#f1c452")),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 5,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        const SizedBox(
          width: 2,
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.8),
            width: 36,
            decoration: BoxDecoration(
                color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
            child: Image.asset(
              bookingProgres[index].bookingStatusIcon!,
              width: 18.5,
              height: 18.5,
            ),
          ),
        ),
      ]);
    } else if (bookingStatus.toUpperCase() == Strings.declined ||
        bookingStatus.toUpperCase() == 'MISSED') {
      progressBar = Row(children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 7.5,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 6,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
            width: 64,
            // width: MediaQuery.of(context).size.width / 5,
            height: 1,
            color: HexColor.fromHex("#f1c452")),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
              color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          width: 64,
          // width: MediaQuery.of(context).size.width / 5,
          height: 1,
          color: HexColor.fromHex("#f1c452"),
        ),
        const SizedBox(
          width: 2,
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.8),
            width: 36,
            decoration: BoxDecoration(
                color: HexColor.fromHex("#f1c452"), shape: BoxShape.circle),
            child: Image.asset(
              bookingProgres[index].bookingStatusIcon!,
              width: 18.5,
              height: 18.5,
            ),
          ),
        ),
      ]);
    } else {
      return Container();
    }

    return progressBar;
  }

  int getBookingIconData(String? bookingStatus) {
    var index = 0;
    for (int i = 0; i < bookingProgres.length; i++) {
      if (bookingStatus == bookingProgres[i].statusName) {
        index = i;
      }
    }
    return index;
  }
}

class BookingProgress {
  String? statusName;
  String? bookingStatusIcon;

  BookingProgress({this.statusName, this.bookingStatusIcon});
}
