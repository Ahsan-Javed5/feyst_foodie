import 'dart:ui';

import 'package:chef/helpers/helpers.dart';
import 'package:chef/screens/booking/booking_list/booking_list_screen_vm.dart'
    as booking_vm;
import 'package:chef/screens/bottom_bar/bottom_bar.dart' as bottom_bar;
import 'package:chef/ui_kit/general_ui_kit.dart';
import 'package:chef/ui_kit/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/resources.dart';
import '../../constants/strings.dart';
import '../../helpers/color_helper.dart';
import '../../models/booking/advance_pending_response.dart';
import '../../setup.dart';
import '../../theme/app_theme_data/app_theme_data.dart';
import '../../theme/app_theme_widget.dart';
import '../../ui_kit/helpers/dialog_helper.dart';
import '../../ui_kit/widgets/general_button.dart';
import '../../ui_kit/widgets/general_new_appbar.dart';
import '../../ui_kit/widgets/general_text.dart';
import '../booking/advance_payment/jazz_cash_webview.dart';
import '../booking/booking_confirmed/booking_in_process_screen_vm.dart';
import '../booking/booking_list/booking_list_screen_vm.dart';
import '../booking/food_item_booking.dart';
import '../custom_form/widgets/exto_field_option.dart';

import 'package:qr_flutter/qr_flutter.dart';

import '../google_map/google_map_screen.dart';

class FoodProductBookingConfirmedDetails extends StatefulWidget {
  // const FoodProductBookingConfirmedDetails({Key? key}) : super(key: key);

  const FoodProductBookingConfirmedDetails(
      {Key? key, required AdvancePendingResponse advancePendingDetails})
      : _advancePendingDetails = advancePendingDetails,
        super(key: key);

  final AdvancePendingResponse _advancePendingDetails;

  @override
  State<FoodProductBookingConfirmedDetails> createState() =>
      _FoodProductBookingConfirmedDetailsState();
}

class _FoodProductBookingConfirmedDetailsState
    extends State<FoodProductBookingConfirmedDetails> {
  late final _ratingController;
  late double _rating;
  double _initialRating = 3;
  IconData? _selectedIcon;
  List<CustomModel> wowFactorsList = [];
  List<CustomModel> menuListItems = [];
  late List<ExperienceMenu> menu;
  late List<ExperienceWowFactor> wowFactorsItems;
  final _navigate = locateService<INavigationService>();
  bool checkValue = false;
  bool qr_code_scanned = false;
  bool showDetailsView = false;
  dynamic group1Value;
  double _sigmaX = 5; // from 0-10
  double _sigmaY = 5;
  final viewModel = locateService<BookingInProcessScreenViewModel>();
  final bookingsListViewModel = locateService<BookingListScreenViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
    menu = widget._advancePendingDetails.t.experienceMenu;
    menuListItems.addAll([
      CustomModel(name: "Sindhi Biryani"),
      CustomModel(name: "Buritto"),
      CustomModel(name: "Vegetable Salad"),
      CustomModel(name: "Hyderabadi Rice"),
      CustomModel(name: "Soft Drinks"),
    ]);
    wowFactorsItems =
        widget._advancePendingDetails.t.experience.experienceWowFactors;
    wowFactorsList.addAll([
      CustomModel(
          name: Strings.productDetailWowFactorGarden,
          icon: "assets/images/icons/garden.png"),
      CustomModel(
          name: Strings.productDetailWowFactorFireworks,
          icon: "assets/images/icons/fireworks.png"),
      CustomModel(
          name: Strings.productDetailWowFactorPetFriendly,
          icon: "assets/images/icons/pet_friendly.png"),
      CustomModel(
          name: Strings.productDetailWowFactorWifi,
          icon: "assets/images/icons/wifi_2.png"),
      CustomModel(
          name: Strings.productDetailWowFactorMusic,
          icon: "assets/images/icons/music.png"),
      CustomModel(
          name: Strings.productDetailWowFactorParking,
          icon: "assets/images/icons/parking.png")
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    final _navigation = locateService<INavigationService>();
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: getStartedButtonTitle(appTheme: appTheme),
        body: Container(
            color: HexColor.fromHex("#212129"),
            child: Column(
              children: [
                const SizedBox(
                  height: 18,
                ),
                Container(
                  height: 217,
                  padding: const EdgeInsets.only(bottom: 17),
                  decoration: BoxDecoration(
                    color: HexColor.fromHex("#4b4b52"),
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50)),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        right: -40,
                        top: -20,
                        child: Container(
                          width: 200,
                          padding: const EdgeInsetsDirectional.all(20),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/icons/food_product_ring.png'),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/images/icons/food_product_experience.png',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 33),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GeneralText(
                                // Strings.productDetailTitle,
                                widget._advancePendingDetails.t.experienceName,
                                style: appTheme
                                    .typographies.interFontFamily.headline6
                                    .copyWith(
                                  fontSize: 22,
                                  color: HexColor.fromHex('#f1c452'),
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              GeneralText(
                                // Strings.productDetailSubTitle,
                                widget._advancePendingDetails.t.brandName,
                                style: appTheme
                                    .typographies.interFontFamily.headline6
                                    .copyWith(
                                  fontSize: 14,
                                  color: HexColor.fromHex('#909094'),
                                ),
                              ),
                              const SizedBox(
                                height: 5.8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 13.9,
                                    child: Image.asset(
                                        'assets/images/icons/star.png',
                                        fit: BoxFit.fill),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  GeneralText(
                                    Strings.productDetailReview,
                                    style: appTheme
                                        .typographies.interFontFamily.headline6
                                        .copyWith(
                                            fontSize: 12,
                                            color: HexColor.fromHex('#8ea659')),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                      Positioned.fill(
                        bottom: -30,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: const EdgeInsetsDirectional.only(
                                start: 19.5, end: 19.5, top: 7, bottom: 7),
                            decoration: BoxDecoration(
                                color: HexColor.fromHex("#b0c18b"),
                                borderRadius: BorderRadius.circular(20)),
                            child: GeneralText(widget._advancePendingDetails.t.bookingStatus.toUpperCase(),
                              // (
                              //     widget._advancePendingDetails.t.bookingStatus
                              //             .toUpperCase() ==
                              //         Strings.confirmed
                              //     ? Strings.foodItemBookingConfirmedStatus
                              //     : widget._advancePendingDetails.t
                              //                 .bookingStatus
                              //                 .toUpperCase() ==
                              //             Strings.inProgress
                              //         ? Strings.inProgressValue
                              //         : widget._advancePendingDetails.t
                              //                     .bookingStatus
                              //                     .toUpperCase() ==
                              //                 Strings.billGenerated
                              //             ? Strings.billGeneratedValue
                              //             : widget._advancePendingDetails.t
                              //                         .bookingStatus
                              //                         .toUpperCase() ==
                              //                     Strings.completeStatus
                              //                         .toUpperCase()
                              //                 ? Strings.completeStatus
                              //                 : Strings.pendingValue
                              // ),
                              style: appTheme
                                  .typographies.interFontFamily.headline6
                                  .copyWith(
                                fontSize: 12,
                                color: HexColor.fromHex('#212129'),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        top: 40,
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.only(left: 29),
                              child: GeneralNewAppBar(
                                rightIcon: Resources.homeIconSvg,
                                callBack: () {
                                  _navigation.navigateTo(
                                      route: BottomBar(
                                          bottomBarType: bottom_bar
                                              .BottomBarType.bookings));
                                },
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        widget._advancePendingDetails.t.bookingStatus
                                    .toUpperCase() ==
                                Strings.confirmed
                            ? Column(
                                children: [
                                  GeneralText(
                                    Strings.foodItemBookingConfirmedOrderNo +
                                            widget._advancePendingDetails.t
                                                .verificationCode
                                                .toString() ??
                                        '',
                                    style: appTheme
                                        .typographies.interFontFamily.headline2
                                        .copyWith(
                                      fontSize: 17,
                                      color: HexColor.fromHex('#f1c452'),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (qr_code_scanned) {
                                            qr_code_scanned = false;
                                          } else {
                                            qr_code_scanned = true;
                                          }
                                        });
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                border: qr_code_scanned
                                                    ? Border.all(
                                                        color: HexColor.fromHex(
                                                            "#8ea659"),
                                                        width: 10)
                                                    : Border.all(
                                                        color: Colors.white,
                                                        width: 10),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                              ),
                                              padding: const EdgeInsets.all(5),
                                              child: Stack(
                                                children: [
                                                  SizedBox(
                                                    width: 181,
                                                    height: 185,
                                                    child:
                                                        //Container(),
                                                        QrImage(
                                                      data: widget
                                                          ._advancePendingDetails
                                                          .t
                                                          .qrRequest!
                                                          .toJson()
                                                          .toString(),
                                                    ),
                                                  ),

                                                  // Image.asset(
                                                  //   "assets/images/icons/qr_code_sample.jpeg",
                                                  //
                                                  // ),

                                                  // Positioned.fill(
                                                  //     top: 10,
                                                  //     right: 20,
                                                  //     child: Container(
                                                  //         width: 24,
                                                  //         height: 24,
                                                  //         decoration: BoxDecoration(
                                                  //           shape: BoxShape.circle,
                                                  //           color: HexColor.fromHex("#8ea659"),
                                                  //         ),
                                                  //         child: Icon(
                                                  //           Icons.check,
                                                  //           color: Colors.white,
                                                  //           size: 23,
                                                  //         ))),
                                                ],
                                              )),
                                          if (qr_code_scanned)
                                            Positioned.fill(
                                              child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Image.asset(
                                                    Resources
                                                        .bookingCheckboxPNG,
                                                    height: 24,
                                                  )),
                                            ),
                                        ],
                                      )),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  GeneralText(
                                    widget._advancePendingDetails.t.comments,
                                    style: appTheme
                                        .typographies.interFontFamily.headline6
                                        .copyWith(
                                      fontSize: 16,
                                      color: HexColor.fromHex('#ffffff'),
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 28,
                        ),
                        chefInformation(appTheme),
                        const SizedBox(
                          height: 33.9,
                        ),
                        Container(
                          padding: const EdgeInsetsDirectional.only(
                              start: 25, end: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GeneralText(
                                Strings.bookingConfirmedDetailsLabel,
                                style: appTheme
                                    .typographies.interFontFamily.headline2
                                    .copyWith(
                                  fontSize: 20,
                                  color: HexColor.fromHex('#f1c452'),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (showDetailsView) {
                                      showDetailsView = false;
                                    } else {
                                      showDetailsView = true;
                                    }
                                  });
                                },
                                child: showDetailsView
                                    ? Container(
                                        width: 26,
                                        child: Image.asset(
                                          "assets/images/icons/showData.png",
                                        ),
                                      )
                                    : Container(
                                        width: 26,
                                        child: Image.asset(
                                          "assets/images/icons/hideData.png",
                                        ),
                                      ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 32.3,
                        ),
                        showDetails(appTheme),
                      ],
                    ),
                  ),
                ),

                ///rating button for completed status
                widget._advancePendingDetails.t.bookingStatus.toUpperCase() ==
                        Strings.completeStatus
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 35,
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFbb3127),
                                ),
                                child: const Text(
                                  'Rate Your Experience',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                onPressed: () {
                                  getDialog(
                                    ctx: context,
                                    title: 'Booking Completed!',
                                    //titleColor: Colors.white,
                                    //descColor: const Color(0xFFfee4a4),
                                    description:
                                        'Kindly review your experience with ${widget._advancePendingDetails.t.brandName}',
                                    iconUrl: 'assets/images/tick_icon.png',
                                    onTap: () async {
                                      var item =
                                          widget._advancePendingDetails.t;
                                      await viewModel.saveRating(
                                          bookingId: item.id,
                                          experienceId: item.experience.id,
                                          stars: int.parse(
                                                  _rating.toStringAsFixed(0))
                                              .toString(),
                                          context: context);
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            )),
      ),
    );
  }

  getDialog(
      {required BuildContext ctx,
      required String title,
      required String description,
      Color? titleColor,
      Color? descColor,
      required String iconUrl,
      required void Function()? onTap}) {
    final appTheme = AppTheme.of(context).theme;
    return showDialog(
        context: ctx,
        barrierColor: const Color(0xFF212129).withOpacity(0.1),
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: AlertDialog(
              backgroundColor: const Color(0xFF212129),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Image.asset(
                    iconUrl,
                    height: 50,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GeneralText(
                    title,
                    style: appTheme.typographies.interFontFamily.headline6
                        .copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: titleColor ?? const Color(0xFF8ea659),
                    ),
                  ),
                  // Text(
                  //   title,
                  //   style: TextStyle(
                  //       color: titleColor ?? const Color(0xFF8ea659),
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.w500),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: descColor ?? Colors.white,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    unratedColor: Colors.amber.withAlpha(50),
                    itemCount: 5,
                    itemSize: 42.0,
                    wrapAlignment: WrapAlignment.spaceEvenly,
                    //itemPadding: const EdgeInsets.symmetric(horizontal: 2.5),
                    itemBuilder: (context, _) => Icon(
                      _selectedIcon ?? Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                    //updateOnDrag: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildTextField(),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 110,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffbb3127),
                      ),
                      child: const Text('Submit'),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildTextField() {
    const maxLines = 5;
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 5,
      ),
      height: maxLines * 24.0,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        border: Border.all(color: const Color(0xfff1c452), width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: viewModel.ratingController,
        maxLines: maxLines,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
            filled: true,
            hintText: 'Write Something',
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.3),
            )),
      ),
    );
  }

  Widget wowFactors(IAppThemeData appTheme) {
    return Container(
      margin: const EdgeInsets.only(left: 12),
      child: Wrap(
        children: [
          for (int i = 0; i < wowFactorsItems.length; i++)
            Padding(
              padding: const EdgeInsets.only(right: 17, bottom: 7.7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 58,
                    height: 52,
                    padding: const EdgeInsetsDirectional.all(10),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/icons/food_item_circle.png'),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      padding: const EdgeInsetsDirectional.all(10),
                      decoration: BoxDecoration(
                        color: HexColor.fromHex("#f1c452"),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.network(
                          wowFactorsItems[i].wowFactorIconPath != null
                              ? Api.baseURLForImages +
                                      wowFactorsItems[i]
                                          .wowFactorIconPath
                                          .toString() ??
                                  ""
                              : ''),
                    ),
                  ),
                  const SizedBox(
                    height: 2.5,
                  ),
                  GeneralText(
                    wowFactorsItems[i].wowFactorName ?? "",
                    style: appTheme.typographies.interFontFamily.headline6
                        .copyWith(
                      fontSize: 14,
                      color: HexColor.fromHex('#ffffff'),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );

    Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.only(
          top: 20, bottom: 20, start: 11.8, end: 11.8),
      decoration: BoxDecoration(
          color: HexColor.fromHex("#4b4b52"),
          borderRadius: BorderRadius.circular(15)),
      child: Wrap(
        children: [
          for (int i = 0; i < wowFactorsList.length; i++)
            Padding(
              padding: const EdgeInsets.only(right: 17, bottom: 7.7),
              child: Column(
                children: [
                  Container(
                    width: 58,
                    padding: const EdgeInsetsDirectional.all(10),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/icons/food_item_circle.png'),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      padding: const EdgeInsetsDirectional.all(10),
                      decoration: BoxDecoration(
                        color: HexColor.fromHex("#f1c452"),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(wowFactorsList[i].icon != null
                          ? wowFactorsList[i].icon ?? ""
                          : ''),
                    ),
                  ),
                  const SizedBox(
                    height: 2.5,
                  ),
                  GeneralText(
                    wowFactorsList[i].name ?? "",
                    style: appTheme.typographies.interFontFamily.headline6
                        .copyWith(
                      fontSize: 14,
                      color: HexColor.fromHex('#ffffff'),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget foodProductDetails(IAppThemeData appTheme) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 25, end: 25),
      child: Container(
          width: double.infinity,
          padding: const EdgeInsetsDirectional.only(
              top: 22, bottom: 29, start: 10, end: 10),
          decoration: BoxDecoration(
              color: HexColor.fromHex("#4b4b52"),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsetsDirectional.only(
                    top: 17, bottom: 17, start: 26, end: 48),
                decoration: BoxDecoration(
                    color: HexColor.fromHex("#212129"),
                    borderRadius: BorderRadius.circular(11)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          GeneralText(
                            InfininURLHelpers.dayOfMonth(
                                  widget._advancePendingDetails.t
                                      .scheduleScheduledDate,
                                ).toUpperCase() +
                                ', ' +
                                widget._advancePendingDetails.t
                                    .scheduleScheduledDate.day
                                    .toString() +
                                ' ' +
                                InfininURLHelpers.months[widget
                                        ._advancePendingDetails
                                        .t
                                        .scheduleScheduledDate
                                        .month]
                                    .toString()
                                    .toUpperCase(),
                            // Strings.productDetailSelectionDate,
                            style: appTheme
                                .typographies.interFontFamily.headline2
                                .copyWith(
                              fontSize: 14,
                              color: HexColor.fromHex('#ea7458'),
                            ),
                          ),
                          GeneralText(
                            InfininURLHelpers.getAmPm(widget
                                ._advancePendingDetails.t.scheduleStartTime),
                            style: appTheme
                                .typographies.interFontFamily.headline2
                                .copyWith(
                              fontSize: 30,
                              color: HexColor.fromHex('#b0c18b'),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: HexColor.fromHex('#707070'),
                        width: 1,
                        height: 69,
                      ),
                      Column(
                        children: [
                          GeneralText(
                            widget._advancePendingDetails.t.preferenceName,
                            style: appTheme
                                .typographies.interFontFamily.headline2
                                .copyWith(
                              fontSize: 14,
                              color: HexColor.fromHex('#8ea659'),
                            ),
                          ),
                          GeneralText(
                            widget._advancePendingDetails.t.persons,
                            style: appTheme
                                .typographies.interFontFamily.headline2
                                .copyWith(
                              fontSize: 30,
                              color: HexColor.fromHex('#8ea659'),
                            ),
                          ),
                          GeneralText(
                            Strings.productDetailSelectionPersons,
                            style: appTheme
                                .typographies.interFontFamily.headline6
                                .copyWith(
                                    fontSize: 12,
                                    color: HexColor.fromHex('#909094'),
                                    fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ]),
              ),
              const SizedBox(
                height: 29,
              ),
              productRelatedNotes(appTheme),
              const SizedBox(
                height: 29,
              ),
              productMenuDetails(appTheme),
            ],
          )),
    );
  }

  Widget productPriceInfo(IAppThemeData appTheme) {
    return Container(
      padding: const EdgeInsetsDirectional.only(start: 25, end: 25),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                color: HexColor.fromHex('#f1c452'),
                width: 16,
                height: 1,
              ),
              const SizedBox(
                width: 2,
              ),
              GeneralText(
                Strings.productDetailPriceLabel,
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 20,
                  color: HexColor.fromHex('#f1c452'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 13.1,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.only(
                top: 22, bottom: 22, start: 23, end: 23),
            decoration: BoxDecoration(
                color: HexColor.fromHex("#4b4b52"),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GeneralText(
                        // Strings.productDetailPriceValue,
                        'Rs. ' +
                            (widget._advancePendingDetails.t.totalAmount)
                                .toStringAsFixed(0),
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                                fontSize: 36,
                                color: HexColor.fromHex('#f89f84'),
                                fontWeight: FontWeight.w300),
                      ),
                      GeneralText(
                        'Total Amount',
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                          fontSize: 15,
                          color: HexColor.fromHex('#ffffff'),
                        ),
                      ),
                    ]),
                const SizedBox(
                  height: 18.1,
                ),
                Container(
                  color: HexColor.fromHex("#ffffff").withOpacity(0.3),
                  width: double.infinity,
                  height: 1,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GeneralText(
                      Strings.productDetailPriceTotal,
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                        fontSize: 15,
                        color: HexColor.fromHex('#ffffff'),
                      ),
                    ),
                    GeneralText(
                      // Strings.productDetailPriceTaxValue,
                      'Rs. ' +
                          widget._advancePendingDetails.t.totalPrice.toString(),
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                        fontSize: 15,
                        color: HexColor.fromHex('#ffffff'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GeneralText(
                      Strings.productDetailPriceTax,
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                        fontSize: 15,
                        color: HexColor.fromHex('#ffffff'),
                      ),
                    ),
                    GeneralText(
                      // Strings.productDetailPriceTaxValue,
                      'Rs. ' +
                          (widget._advancePendingDetails.t.tax)
                              .toStringAsFixed(0),
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                        fontSize: 15,
                        color: HexColor.fromHex('#ffffff'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GeneralText(
                          Strings.productDetailAdvancePayment,
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                            fontSize: 15,
                            color: HexColor.fromHex(widget
                                        ._advancePendingDetails.t.bookingStatus
                                        .toUpperCase() !=
                                    Strings.pendingValue
                                ? '#8ea659'
                                : '#ffffff'),
                          ),
                        ),
                        const SizedBox(width: 2),
                        widget._advancePendingDetails.t.bookingStatus
                                    .toUpperCase() !=
                                Strings.pendingValue
                            ? const Icon(
                                Icons.check_circle,
                                size: 15,
                                color: Color(0xff8ea659),
                              )
                            : SizedBox(),
                      ],
                    ),
                    GeneralText(
                      // Strings.productDetailAdvancePaymentValue,
                      'Rs. ' +
                          (widget._advancePendingDetails.t.advancePayment)
                              .toStringAsFixed(0),
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                        fontSize: 15,
                        color: HexColor.fromHex(widget
                                    ._advancePendingDetails.t.bookingStatus
                                    .toUpperCase() !=
                                Strings.pendingValue
                            ? '#8ea659'
                            : '#ffffff'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget productRelatedNotes(IAppThemeData appTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralText(
          Strings.productDetailSelectionNotesLabel,
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
            fontSize: 16,
            color: HexColor.fromHex('#f1c452'),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsetsDirectional.only(
              top: 15, bottom: 15, start: 14, end: 14),
          decoration: BoxDecoration(
              color: HexColor.fromHex("#212129"),
              borderRadius: BorderRadius.circular(11)),
          child: GeneralText(
            widget._advancePendingDetails.t?.comments ?? 'No Notes',
            style: appTheme.typographies.interFontFamily.headline6.copyWith(
                fontSize: 14,
                color: HexColor.fromHex('#ffffff'),
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }

  Widget productMenuDetails(IAppThemeData appTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralText(
          Strings.productDetailSelectionMenuLabel,
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
            fontSize: 16,
            color: HexColor.fromHex('#f1c452'),
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Wrap(
          children: [
            for (int index = 0; index < menu.length; index++)
              Container(
                width: 140,
                // height: 67,
                padding: const EdgeInsetsDirectional.only(
                    top: 10, bottom: 10, start: 14, end: 14),
                margin: const EdgeInsets.only(right: 5, bottom: 7),
                decoration: BoxDecoration(
                    color: HexColor.fromHex("#212129"),
                    borderRadius: BorderRadius.circular(11)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget._advancePendingDetails.t.priceTypeId == 2
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GeneralText(
                                Strings.productDetailSelectionMenuQuantity,
                                style: appTheme
                                    .typographies.interFontFamily.headline2
                                    .copyWith(
                                  fontSize: 16,
                                  color: HexColor.fromHex('#f89f84'),
                                ),
                              ),
                              GeneralText(
                                menu[index].price.toString(),
                                style: appTheme
                                    .typographies.interFontFamily.headline2
                                    .copyWith(
                                  fontSize: 16,
                                  color: HexColor.fromHex('#909094'),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: widget._advancePendingDetails.t.priceTypeId == 2
                          ? 5
                          : 0,
                    ),
                    GeneralText(
                      menu[index].baseDishName ?? "",
                      style: appTheme.typographies.interFontFamily.headline2
                          .copyWith(
                              fontSize: 14,
                              color: HexColor.fromHex('#ffffff'),
                              fontWeight: FontWeight.w400),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
          ],
        ),
        /*GridView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.8,
              mainAxisSpacing: 7,
              crossAxisSpacing: 5,
              // mainAxisExtent: 67,
            ),
            itemCount: menuListItems.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsetsDirectional.only(
                    top: 10, bottom: 10, start: 14, end: 14),
                decoration: BoxDecoration(
                    color: HexColor.fromHex("#212129"),
                    borderRadius: BorderRadius.circular(11)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GeneralText(
                          Strings.productDetailSelectionMenuQuantity,
                          style: appTheme.typographies.interFontFamily.headline2
                              .copyWith(
                            fontSize: 16,
                            color: HexColor.fromHex('#f89f84'),
                          ),
                        ),
                        GeneralText(
                          Strings.productDetailSelectionMenuAmount,
                          style: appTheme.typographies.interFontFamily.headline2
                              .copyWith(
                            fontSize: 16,
                            color: HexColor.fromHex('#909094'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: GeneralText(
                        menuListItems[index].name ?? "",
                        style: appTheme.typographies.interFontFamily.headline2
                            .copyWith(
                                fontSize: 14,
                                color: HexColor.fromHex('#ffffff'),
                                fontWeight: FontWeight.w400),
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              );
            }),*/
      ],
    );
  }

  Widget chefInformation(IAppThemeData appTheme) {
    return Container(
      padding: const EdgeInsetsDirectional.only(start: 25, end: 25),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                color: HexColor.fromHex('#f1c452'),
                width: 16,
                height: 1,
              ),
              const SizedBox(
                width: 7.2,
              ),
              GeneralText(
                Strings.productDetailChefLabel,
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 20,
                  color: HexColor.fromHex('#f1c452'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 13.1,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.only(
                top: 22, bottom: 22, start: 23, end: 23),
            decoration: BoxDecoration(
                color: HexColor.fromHex("#4b4b52"),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          shape: BoxShape.circle),

                      ///chef image
                      child:
                          widget._advancePendingDetails.t.chefProfileImageUrl ==
                                  null
                              ? Image.asset(Resources.userProfileImageIcon)
                              : CircleAvatar(
                                  radius: 40, // Image radius
                                  backgroundImage: NetworkImage(
                                      Api.baseURLForImages +
                                          widget._advancePendingDetails.t
                                              .chefProfileImageUrl
                                              .toString()),
                                )),
                  // Image.network(Api.baseURLForImages+widget._advancePendingDetails.t.chefProfileImageUrl.toString())),
                  const SizedBox(
                    width: 11.5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GeneralText(
                        // Strings.productDetailChefName,
                        widget._advancePendingDetails.t.brandName,
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                          fontSize: 18,
                          color: HexColor.fromHex('#f1c452'),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          navigateToGoogleMap(widget._advancePendingDetails.t
                              .experience.latitude, widget._advancePendingDetails.t
                              .experience.longitude);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => GoogleMapScreen(
                          //       longitude: widget._advancePendingDetails.t
                          //           .experience.longitude,
                          //       latitude: widget._advancePendingDetails.t
                          //           .experience.latitude,
                          //     ),
                          //   ),
                          // );
                        },
                        child: Row(
                          children: [
                            SizedBox(
                                width: 10.8,
                                child: Image.asset(
                                    "assets/images/icons/location_pin.png")),
                            const SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                                width: 150,
                                child: GeneralText(
                                  // Strings.productDetailChefLocation,
                                  widget._advancePendingDetails.t.address,
                                  maxLines: 2,
                                  style: appTheme
                                      .typographies.interFontFamily.headline6
                                      .copyWith(
                                          fontSize: 14,
                                          color: Colors.white,
                                          decoration: TextDecoration.underline),
                                )),
                          ],
                        ),
                      )
                    ],
                  )
                ]),
                const SizedBox(
                  height: 18.1,
                ),
                Container(
                  color: HexColor.fromHex("#ffffff").withOpacity(0.3),
                  width: double.infinity,
                  height: 1,
                ),
                const SizedBox(
                  height: 10,
                ),
                GeneralText(
                  Strings.productDetailChefSubHost,
                  style:
                      appTheme.typographies.interFontFamily.headline6.copyWith(
                    fontSize: 14,
                    color: HexColor.fromHex('#909094'),
                  ),
                ),
                GeneralText(
                  // Strings.productDetailChefSubHostName,
                  widget._advancePendingDetails.t.subHost,
                  //+
                  //     widget._advancePendingDetails.t.subHostMobileNo,
                  style:
                      appTheme.typographies.interFontFamily.headline6.copyWith(
                    fontSize: 18,
                    color: HexColor.fromHex('#f1c452'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget productPriceInformation(IAppThemeData appTheme) {
    return Container(
      padding: const EdgeInsetsDirectional.only(start: 25, end: 25),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                color: HexColor.fromHex('#f1c452'),
                width: 16,
                height: 1,
              ),
              const SizedBox(
                width: 7.5,
              ),
              GeneralText(
                Strings.productDetailPriceLabel,
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 20,
                  color: HexColor.fromHex('#f1c452'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 13.1,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsetsDirectional.only(
                top: 22, bottom: 22, start: 23, end: 23),
            decoration: BoxDecoration(
                color: HexColor.fromHex("#4b4b52"),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GeneralText(
                        Strings.productDetailPriceValue,
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                                fontSize: 36,
                                color: HexColor.fromHex('#f89f84'),
                                fontWeight: FontWeight.w300),
                      ),
                      GeneralText(
                        Strings.productDetailPriceTotal,
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                          fontSize: 15,
                          color: HexColor.fromHex('#ffffff'),
                        ),
                      ),
                    ]),
                const SizedBox(
                  height: 18.1,
                ),
                Container(
                  color: HexColor.fromHex("#ffffff").withOpacity(0.3),
                  width: double.infinity,
                  height: 1,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GeneralText(
                      Strings.productDetailPriceTax,
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                        fontSize: 15,
                        color: HexColor.fromHex('#ffffff'),
                      ),
                    ),
                    GeneralText(
                      Strings.productDetailPriceTaxValue,
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: HexColor.fromHex('#ffffff'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GeneralText(
                          Strings.productDetailAdvancePayment,
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                            fontSize: 15,
                            color: HexColor.fromHex('#8ea659'),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          // padding: const EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: HexColor.fromHex('#8ea659'),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.check,
                              size: 10,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    GeneralText(
                      Strings.foodItemAdvancePaymentValue,
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                        fontSize: 15,
                        color: HexColor.fromHex('#8ea659'),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getStartedButtonTitle({required IAppThemeData appTheme}) {
    return widget._advancePendingDetails.t.bookingStatus.toUpperCase() ==
            Strings.requestedOrder
        ? GeneralButton.button(
            title:
                Strings.foodItemBookingConfirmedCancelOrderButton.toUpperCase(),
            styleType: ButtonStyleType.fill,
            onTap: () {
              _showGeneralPopup(context,
                  title: Strings.confirmationTitle,
                  description: Strings.confirmCancelMessage);
            },
          )
        : widget._advancePendingDetails.t.bookingStatus.toUpperCase() ==
                Strings.billGenerated
            ? getBillGeneratedButtons()
            : const SizedBox();
    // ExtoText(
    //   Strings.getStartedButtonTitle,
    //   style: appTheme.typographies.interFontFamily.headline2,
    // );
  }

  getBillGeneratedButtons() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
      ),
      child: Row(
        children: [
          GeneralButton.button(
            title: 'PAY DIGITAL',
            styleType: ButtonStyleType.fill,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => JazzCashWebView(
                        bookindData: widget._advancePendingDetails)),
              );
              // _showGeneralPopup(context, title: Strings.confirmationTitle, description: Strings.confirmCancelMessage);
            },
          ),
          const SizedBox(width: 10),
          GeneralButton.button(
            title: 'PAY CASH',
            styleType: ButtonStyleType.fill,
            onTap: () {
              CustomDialog.getDialog(
                ctx: context,
                title: 'Please Wait',
                //titleColor: Colors.white,
                //descColor: const Color(0xFFfee4a4),
                description: 'Awaiting bistro approval of cash received',
                iconUrl: Resources.cashWaitingIcon,
                onTap: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              );
              //_showGeneralPopup(context, title: Strings.confirmationTitle, description: Strings.confirmCancelMessage);
            },
          )
        ],
      ),
    );
  }

  Widget showDetails(IAppThemeData appTheme) {
    return showDetailsView
        ? Column(
            children: [
              Container(
                padding: const EdgeInsetsDirectional.only(start: 25, end: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          color: HexColor.fromHex('#f1c452'),
                          width: 16,
                          height: 1,
                        ),
                        const SizedBox(
                          width: 7.2,
                        ),
                        GeneralText(
                          Strings.productDetailAboutTitle,
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                            fontSize: 20,
                            color: HexColor.fromHex('#f1c452'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 23),
                      child: GeneralText(
                        widget._advancePendingDetails.t.experience.description,
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                                fontSize: 14,
                                color: HexColor.fromHex('#ffffff'),
                                fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 27,
                    ),
                    Row(
                      children: [
                        Container(
                          color: HexColor.fromHex('#f1c452'),
                          width: 16,
                          height: 1,
                        ),
                        const SizedBox(
                          width: 7.2,
                        ),
                        GeneralText(
                          Strings.productDetailWowFactorTitle,
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                            fontSize: 20,
                            color: HexColor.fromHex('#f1c452'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 11.6,
                    ),
                    wowFactors(appTheme),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              foodProductDetails(appTheme),
              const SizedBox(
                height: 28,
              ),
              // productPriceInformation(appTheme),
              productPriceInfo(
                appTheme,
              ),
              const SizedBox(
                height: 70,
              ),
            ],
          )
        : Container();
  }

  List<ExtoFieldOption> listOfRadio = [
    ExtoFieldOption(
        optionData: FieldOptionModel(
            id: "1",
            label: "Lorem ipsum dolor sit amet, consectetur",
            value: "1")),
    ExtoFieldOption(
        optionData: FieldOptionModel(
            id: "2",
            label: "Lorem ipsum dolor sit amet, consectetur",
            value: "2")),
    ExtoFieldOption(
        optionData: FieldOptionModel(
            id: "3",
            label: "Lorem ipsum dolor sit amet, consectetur",
            value: "3")),
    ExtoFieldOption(
        optionData: FieldOptionModel(
            id: "4",
            label: "Lorem ipsum dolor sit amet, consectetur",
            value: "4")),
  ];

  showGeneralPopup(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;

    return DialogHelper.showBottomSheetDialog(
      borderRadius: 20,
      context: context,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
        child: Container(
          padding: const EdgeInsetsDirectional.only(
            start: 25,
            end: 28,
            top: 41,
          ),
          decoration: BoxDecoration(
              color: HexColor.fromHex("#212129"),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: Column(
            children: [
              GeneralText(
                Strings.bottomSheetTellUsWhyTitle,
                maxLines: 2,
                style: appTheme.typographies.interFontFamily.headline4.copyWith(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 17,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Column(children: [
                  Row(
                    children: [
                      Radio(
                        visualDensity: VisualDensity.compact,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return HexColor.fromHex("#fbeccb");
                        }),
                        activeColor: HexColor.fromHex("#fbeccb"),
                        value: 0,
                        groupValue: group1Value,
                        onChanged: (value) {
                          setState(() {
                            group1Value = value;
                          });
                        },
                      ),
                      Expanded(
                        child: GeneralText(
                          Strings.bottomSheetTellUsWhyRadioHint,
                          maxLines: 2,
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                                  color: HexColor.fromHex("#fbeccb"),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        visualDensity: VisualDensity.compact,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return HexColor.fromHex("#fbeccb");
                        }),
                        activeColor: HexColor.fromHex("#fbeccb"),
                        value: 1,
                        groupValue: group1Value,
                        onChanged: (value) {
                          setState(() {
                            group1Value = value;
                          });
                        },
                      ),
                      Expanded(
                        child: GeneralText(
                          Strings.bottomSheetTellUsWhyRadioHint,
                          maxLines: 2,
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                                  color: HexColor.fromHex("#fbeccb"),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        visualDensity: VisualDensity.compact,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return HexColor.fromHex("#fbeccb");
                        }),
                        activeColor: HexColor.fromHex("#fbeccb"),
                        value: 2,
                        groupValue: group1Value,
                        onChanged: (value) {
                          setState(() {
                            group1Value = value;
                          });
                        },
                      ),
                      Expanded(
                        child: GeneralText(
                          Strings.bottomSheetTellUsWhyRadioHint,
                          maxLines: 2,
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                                  color: HexColor.fromHex("#fbeccb"),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Radio(
                        visualDensity: VisualDensity.compact,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return HexColor.fromHex("#fbeccb");
                        }),
                        activeColor: HexColor.fromHex("#fbeccb"),
                        value: 3,
                        groupValue: group1Value,
                        onChanged: (value) {
                          setState(() {
                            group1Value = value;
                          });
                        },
                      ),
                      Expanded(
                        child: GeneralText(
                          Strings.bottomSheetTellUsWhyRadioHint,
                          maxLines: 2,
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                            color: HexColor.fromHex("#fbeccb"),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              const SizedBox(
                height: 42,
              ),
              GeneralButton.button(
                title: Strings.generalButtonTitle.toUpperCase(),
                styleType: ButtonStyleType.fill,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showGeneralPopup(BuildContext context,
      {required String title, required String description}) async {
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
              title,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: appTheme.colors.secondaryBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 19,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GeneralText(
                description,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: appTheme.typographies.interFontFamily.headline4.copyWith(
                    color: const Color(0xfffee4a4),
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 31,
            ),
            GeneralButton.button(
              title: Strings.generalButtonTitle.toUpperCase(),
              styleType: ButtonStyleType.fill,
              onTap: () {
                bookingsListViewModel.cancelBooking(
                    bookingId: widget._advancePendingDetails.t.id);
                Toaster.infoToast(
                    context: context,
                    message: 'Your Experience has been Cancelled');
                Navigator.pop(context);
                _navigate.navigateTo(
                    route: BottomBar(
                        bottomBarType: bottom_bar.BottomBarType.history));

                ///Here need to call cancel api
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SignUpScreen()),
                // );
                //    viewModel.goToForgotPasswordScreen();
              },
            ),
            const SizedBox(
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
  static void navigateToGoogleMap(double lat, double lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }
  Future<bool> onWillPop() async {
    return false;
  }
}

class CustomModel {
  String? name;
  String? icon;

  CustomModel({this.name, this.icon});
}
