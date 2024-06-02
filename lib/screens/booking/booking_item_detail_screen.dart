import 'dart:async';
import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:chef/helpers/helpers.dart';
import 'package:chef/setup.dart';
import 'package:chef/screens/bottom_bar/bottom_bar.dart' as bottom_bar;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/function_helper.dart';
import '../../models/booking/advance_pending_response.dart';
import '../../ui_kit/widgets/custom_dialog.dart';
import '../../ui_kit/widgets/general_new_appbar.dart';

import 'dart:developer' as developer;

import 'advance_payment/jazz_cash_webview.dart';

@RoutePage()
class BookingItemDetailsScreen extends StatefulWidget {
  const BookingItemDetailsScreen(
      {super.key, required AdvancePendingResponse advancePendingDetails})
      : _bookingItemDetails = advancePendingDetails;

  final AdvancePendingResponse _bookingItemDetails;

  @override
  State<BookingItemDetailsScreen> createState() =>
      _BookingItemDetailsScreenState();
}

class _BookingItemDetailsScreenState extends State<BookingItemDetailsScreen> {
  List<CustomModel> wowFactorsList = [];
  List<CustomModel> preferencesList = [];

  List<CustomModel> menuListItems = [];
  bool checkValue = false;
  var darkMapStyle;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    loadMenu();
    loadWowFactor();
    loadPreferences();
    _loadMapStyles();
    widget._bookingItemDetails.t.bookingStatus.toString().toUpperCase() ==
            Strings.acceptData
        ? getAdvancePaymentDialog()
        : null;
    super.initState();
  }

  void loadMenu() {
    for (var i = 0;
        i < widget._bookingItemDetails.t.experienceMenu.length;
        i++) {
      menuListItems.addAll([
        CustomModel(
          name: widget._bookingItemDetails.t.experienceMenu[i].dish,
          icon: widget._bookingItemDetails.t.experienceMenu[i].pictureUrl,
          description:
              widget._bookingItemDetails.t.experienceMenu[i].description,
          price:
              widget._bookingItemDetails.t.experienceMenu[i].price.toString(),
          quantity: widget._bookingItemDetails.t.experienceMenu[i].quantity,
        ),
      ]);
    }
  }

  void loadWowFactor() {
    for (var i = 0;
        i < widget._bookingItemDetails.t.experience.experienceWowFactors.length;
        i++) {
      wowFactorsList.add(
        CustomModel(
          name: widget._bookingItemDetails.t.experience.experienceWowFactors[i]
              .wowFactorName,
          icon: widget._bookingItemDetails.t.experience.experienceWowFactors[i]
              .wowFactorIconPath,
        ),
      );
    }
  }

  void loadPreferences() {
    var experiencePreferences =
        widget._bookingItemDetails.t.experience.experiencePreferences;

    for (int i = 0; i < experiencePreferences.length; i++) {
      preferencesList.addAll([
        CustomModel(
            icon: experiencePreferences[i].preferenceIconPath,
            name: experiencePreferences[i].preferenceName),
      ]);
    }
  }

  getAdvancePaymentDialog() {
    return Future.delayed(const Duration(seconds: 1), () {
      return CustomDialog.getDialog(
        ctx: context,
        title: Strings.advancePaymentDue,
        //titleColor: Colors.white,
        //descColor: const Color(0xFFfee4a4),
        description: Strings.proceedToAdvancePaymentDescription,
        iconUrl: Resources.paymentIcon,
        onTap: () {
          setState(() {
            Navigator.pop(context);
          });
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return Scaffold(
      backgroundColor: HexColor.fromHex('#212129'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 50,
                ),
                child: const GeneralNewAppBar(
                  rightIcon: '',
                  titleColor: Colors.white,
                  title: 'Bookings',
                ),
              ),
              FunctionHelper().getDivider(),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        Resources.foodDetailsBg,
                        fit: BoxFit.cover,
                        height: 110,
                      ),
                    ),
                  )),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GeneralText(
                          widget._bookingItemDetails.t.experienceName ??
                              '', // Strings.labelSeaFood2Experience,
                          style: appTheme.typographies.interFontFamily.headline5
                              .copyWith(
                            fontSize: 21,
                            //ontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        GeneralText(
                          "${Strings.byText} ${widget._bookingItemDetails.t.brandName}", // Strings.labelSeaFood2Experience,
                          style: appTheme.typographies.interFontFamily.headline2
                              .copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff909094),
                          ),
                        ),
                        GeneralText(
                          'DHA, Karachi', // Strings.labelSeaFood2Experience,
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                            fontSize: 13,
                            //fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/star.svg',
                                  height: 13,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                GeneralText(
                                  widget._bookingItemDetails.t.experience
                                          .averageRating
                                          ?.toString() ??
                                      '4.8', // Strings.labelSeaFood2Experience,
                                  style: appTheme
                                      .typographies.interFontFamily.headline2
                                      .copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xfffbeccb),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 19.5, end: 19.5, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                  color: HexColor.fromHex("#b0c18b"),
                                  borderRadius: BorderRadius.circular(20)),
                              child: GeneralText(
                                widget._bookingItemDetails.t.bookingStatus
                                    .toUpperCase(),
                                style: appTheme
                                    .typographies.interFontFamily.headline6
                                    .copyWith(
                                  fontSize: 12,
                                  color: HexColor.fromHex('#212129'),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              FunctionHelper().getDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GeneralText(
                        'Your Experience', // Strings.labelSeaFood2Experience,
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                          fontSize: 17,
                          //fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      getBookingPart(
                          appTheme: appTheme,
                          title: 'Sat, Mar 16',
                          description: '07:00 PM - 09:00 PM'),
                    ],
                  ),
                  widget._bookingItemDetails.t.bookingStatus.toUpperCase() ==
                          Strings.confirmed
                      ? Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 1),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              //padding: const EdgeInsets.all(5),
                              child: SizedBox(
                                width: 70,
                                height: 70,
                                child: QrImageView(
                                  data: widget._bookingItemDetails.t.qrRequest!
                                      .toJson()
                                      .toString(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            GeneralText(
                              'Code: ${widget._bookingItemDetails.t.verificationCode}', // Strings.labelSeaFood2Experience,
                              style: appTheme
                                  .typographies.interFontFamily.headline6
                                  .copyWith(
                                fontSize: 13,
                                //fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                ],
              ),
              FunctionHelper().getDivider(),
              getBookingPart(
                  appTheme: appTheme,
                  title: 'Guests',
                  description:
                      '${widget._bookingItemDetails.t.persons} | ${widget._bookingItemDetails.t.preferenceName}'),
              widget._bookingItemDetails.t.comments != ''
                  ? getBookingPart(
                      appTheme: appTheme,
                      title: 'Optional Notes',
                      description: widget._bookingItemDetails.t.comments)
                  : const SizedBox(),
              getBookingPart(
                  appTheme: appTheme,
                  title: 'Experience',
                  description:
                      widget._bookingItemDetails.t.experience.description),
              getBookingPart(
                  appTheme: appTheme,
                  title: 'Hosted By',
                  description:
                      widget._bookingItemDetails.t.experience.chefName),
              widget._bookingItemDetails.t.bookingStatus.toUpperCase() ==
                      Strings.confirmed
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GeneralText('Sub Host',
                            style: appTheme
                                .typographies.interFontFamily.headline6
                                .copyWith(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GeneralText(
                              widget._bookingItemDetails.t.subHost,
                              style: appTheme
                                  .typographies.interFontFamily.headline6
                                  .copyWith(
                                fontSize: 16,
                                color: HexColor.fromHex('#f1c452'),
                              ),
                            ),
                            GeneralText(
                              // Strings.productDetailChefSubHostName,
                              widget._bookingItemDetails.t.subHostMobileNo,
                              //+
                              //     widget._advancePendingDetails.t.subHostMobileNo,
                              style: appTheme
                                  .typographies.interFontFamily.headline6
                                  .copyWith(
                                fontSize: 16,
                                color: HexColor.fromHex('#f1c452'),
                              ),
                            ),
                          ],
                        ),
                        FunctionHelper().getDivider(),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 11.6,
              ),
              GeneralText(Strings.productDetailWowFactorTitle,
                  style: appTheme.typographies.interFontFamily.headline6
                      .copyWith(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 10,
              ),
              getWowFactorsList(appTheme, wowFactorsList),
              const SizedBox(
                height: 11.6,
              ),
              GeneralText(Strings.foodDetailPreferences,
                  style: appTheme.typographies.interFontFamily.headline6
                      .copyWith(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 10,
              ),
              getWowFactorsList(appTheme, preferencesList),
              const SizedBox(
                height: 20,
              ),
              productMenuDetails(appTheme),
              const SizedBox(
                height: 20,
              ),
              GeneralText(
                'Your Experience', // Strings.labelSeaFood2Experience,
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 15,
                  //fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: DeviceHelper.height * 0.60,
                width: MediaQuery.of(context).size.width,
                transform: Matrix4.translationValues(-12.0, 0, 0.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: appTheme.colors.primary,
                      blurRadius: 400.0,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: GoogleMap(
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: false,
                  scrollGesturesEnabled: false,
                  rotateGesturesEnabled: false,
                  compassEnabled: false,
                  mapToolbarEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      widget._bookingItemDetails.t.experience.latitude ?? 0.0,
                      widget._bookingItemDetails.t.experience.longitude ?? 0.0,
                    ),
                    zoom: 14.4746,
                  ),
                  markers: <Marker>{
                    Marker(
                        markerId: const MarkerId('SomeId'),
                        position: LatLng(
                          widget._bookingItemDetails.t.experience.latitude ??
                              0.0,
                          widget._bookingItemDetails.t.experience.longitude ??
                              0.0,
                        ),
                        infoWindow: const InfoWindow(title: '')),
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    controller.setMapStyle(darkMapStyle);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              productPriceInfo(appTheme),
              const SizedBox(
                height: 30,
              ),
              widget._bookingItemDetails.t.bookingStatus.toUpperCase() ==
                      'ACCEPTED'
                  ? SizedBox(
                      width: double.infinity,
                      child: GeneralButton.button(
                        title: 'Confirm & Pay',
                        styleType: ButtonStyleType.fill,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JazzCashWebView(
                                    bookindData: widget._bookingItemDetails)),
                          );
                        },
                      ),
                    )
                  : const SizedBox(),
              widget._bookingItemDetails.t.bookingStatus.toUpperCase() ==
                      Strings.inProgress
                  ? getBillGeneratedButtons()
                  : const SizedBox(),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );

    //   Scaffold(
    //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    //   floatingActionButton: widget._bookingItemDetails.t.bookingStatus
    //               .toString()
    //               .toUpperCase() ==
    //           Strings.acceptData
    //       ? getStartedButtonTitle(appTheme: appTheme)
    //       : Container(),
    //   body: Container(
    //       color: HexColor.fromHex("#212129"),
    //       child: Column(
    //         children: [
    //           const SizedBox(
    //             height: 18,
    //           ),
    //           Container(
    //             height: 217,
    //             padding: const EdgeInsets.only(left: 33, bottom: 17),
    //             decoration: BoxDecoration(
    //               color: HexColor.fromHex("#4b4b52"),
    //               borderRadius: const BorderRadius.only(
    //                   bottomRight: Radius.circular(50),
    //                   bottomLeft: Radius.circular(50)),
    //             ),
    //             child: Stack(
    //               clipBehavior: Clip.none,
    //               children: [
    //                 Positioned(
    //                   right: -40,
    //                   top: -20,
    //                   child: Container(
    //                     width: 200,
    //                     padding: const EdgeInsetsDirectional.all(20),
    //                     decoration: const BoxDecoration(
    //                       image: DecorationImage(
    //                         image: AssetImage(
    //                             'assets/images/icons/food_product_ring.png'),
    //                         fit: BoxFit.fill,
    //                       ),
    //                       shape: BoxShape.circle,
    //                     ),
    //                     child: Image.asset(
    //                       'assets/images/icons/food_product_experience.png',
    //                     ),
    //                   ),
    //                 ),
    //                 Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     mainAxisAlignment: MainAxisAlignment.end,
    //                     children: [
    //                       GeneralText(
    //                         // Strings.productDetailTitle,
    //                         widget._bookingItemDetails.t.experienceName,
    //                         style: appTheme
    //                             .typographies.interFontFamily.headline6
    //                             .copyWith(
    //                           fontSize: 22,
    //                           color: HexColor.fromHex('#f1c452'),
    //                         ),
    //                       ),
    //                       const SizedBox(
    //                         height: 3,
    //                       ),
    //                       GeneralText(
    //                         Strings.byText +
    //                             ' ' +
    //                             widget._bookingItemDetails.t.brandName,
    //                         style: appTheme
    //                             .typographies.interFontFamily.headline6
    //                             .copyWith(
    //                           fontSize: 14,
    //                           color: HexColor.fromHex('#909094'),
    //                         ),
    //                       ),
    //                       const SizedBox(
    //                         height: 4,
    //                       ),
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         children: [
    //                           Container(
    //                             width: 13.9,
    //                             child: Image.asset(
    //                                 'assets/images/icons/star.png',
    //                                 fit: BoxFit.fill),
    //                           ),
    //                           const SizedBox(
    //                             width: 5,
    //                           ),
    //                           GeneralText(
    //                             widget._bookingItemDetails.t.experience
    //                                     .averageRating
    //                                     ?.toString() ??
    //                                 Strings.noReviews,
    //                             style: appTheme
    //                                 .typographies.interFontFamily.headline6
    //                                 .copyWith(
    //                                     fontSize: 12,
    //                                     color: HexColor.fromHex('#8ea659')),
    //                           ),
    //                         ],
    //                       ),
    //                     ]),
    //                 Positioned.fill(
    //                   bottom: -30,
    //                   child: Align(
    //                     alignment: Alignment.bottomCenter,
    //                     child: Container(
    //                       padding: const EdgeInsetsDirectional.only(
    //                           start: 19.5, end: 19.5, top: 7, bottom: 7),
    //                       decoration: BoxDecoration(
    //                           color: HexColor.fromHex("#b0c18b"),
    //                           borderRadius: BorderRadius.circular(20)),
    //                       child: GeneralText(
    //                         widget._bookingItemDetails.t.bookingStatus
    //                             .toUpperCase(),
    //                         style: appTheme
    //                             .typographies.interFontFamily.headline6
    //                             .copyWith(
    //                           fontSize: 12,
    //                           color: HexColor.fromHex('#212129'),
    //                           fontWeight: FontWeight.w700,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Positioned.fill(
    //                   top: 40,
    //                   child: Align(
    //                       alignment: Alignment.topLeft,
    //                       child: GeneralNewAppBar(
    //                         rightIcon: Resources.homeIconSvg,
    //                         callBack: () {
    //                           locateService<INavigationService>().navigateTo(
    //                               route: BottomBarRoute(
    //                                   bottomBarType:
    //                                       bottom_bar.BottomBarType.bookings));
    //                           Navigator.pop(context);
    //                         },
    //                       )),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           const SizedBox(
    //             height: 33.9,
    //           ),
    //           Expanded(
    //             child: SingleChildScrollView(
    //               child: Column(
    //                 children: [
    //                   Container(
    //                     padding: const EdgeInsetsDirectional.only(
    //                         start: 25, end: 25),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Row(
    //                           children: [
    //                             Container(
    //                               color: HexColor.fromHex('#f1c452'),
    //                               width: 16,
    //                               height: 1,
    //                             ),
    //                             const SizedBox(
    //                               width: 7.2,
    //                             ),
    //                             GeneralText(
    //                               Strings.productDetailAboutTitle,
    //                               style: appTheme
    //                                   .typographies.interFontFamily.headline6
    //                                   .copyWith(
    //                                 fontSize: 20,
    //                                 color: HexColor.fromHex('#f1c452'),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                         const SizedBox(
    //                           height: 5,
    //                         ),
    //                         Padding(
    //                           padding: const EdgeInsets.only(left: 23),
    //                           child: GeneralText(
    //                             //   widget.bookingListModel.t[]
    //                             // widget._bookingItem.
    //                             //   Strings.productDetailAboutSubTitle,
    //                             widget._bookingItemDetails.t.experience
    //                                 .description,
    //                             maxLines: 4,
    //                             style: appTheme
    //                                 .typographies.interFontFamily.headline6
    //                                 .copyWith(
    //                                     fontSize: 14,
    //                                     color: HexColor.fromHex('#ffffff'),
    //                                     fontWeight: FontWeight.w400),
    //                           ),
    //                         ),
    //                         const SizedBox(
    //                           height: 27,
    //                         ),
    //                         Row(
    //                           children: [
    //                             Container(
    //                               color: HexColor.fromHex('#f1c452'),
    //                               width: 16,
    //                               height: 1,
    //                             ),
    //                             const SizedBox(
    //                               width: 7.2,
    //                             ),
    //                             GeneralText(
    //                               Strings.productDetailWowFactorTitle,
    //                               style: appTheme
    //                                   .typographies.interFontFamily.headline6
    //                                   .copyWith(
    //                                 fontSize: 20,
    //                                 color: HexColor.fromHex('#f1c452'),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                         const SizedBox(
    //                           height: 11.6,
    //                         ),
    //                         wowFactors(appTheme),
    //                       ],
    //                     ),
    //                   ),
    //                   const SizedBox(
    //                     height: 16,
    //                   ),
    //                   foodProductDetails(appTheme),
    //                   const SizedBox(
    //                     height: 28,
    //                   ),
    //                   chefInformation(appTheme),
    //                   const SizedBox(
    //                     height: 47.9,
    //                   ),
    //                   productPriceInformation(appTheme),
    //                   const SizedBox(
    //                     height: 32.9,
    //                   ),
    //                   widget._bookingItemDetails.t.bookingStatus
    //                                   .toUpperCase() ==
    //                               'MISSED' ||
    //                           widget._bookingItemDetails.t.bookingStatus
    //                                   .toUpperCase() ==
    //                               'DECLINED'
    //                       ? const SizedBox()
    //                       : extraPaymentNotes(appTheme),
    //                   const SizedBox(
    //                     height: 70,
    //                   ),
    //                   //checkTermsConditions(appTheme),
    //                   // const SizedBox(
    //                   //   height: 209.1,
    //                   // ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ],
    //       )),
    // );
  }

  Widget getBookingPart({
    required appTheme,
    String? title,
    String? description,
  }) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GeneralText(title ?? '',
                    style: appTheme.typographies.interFontFamily.headline6
                        .copyWith(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700)),
                GeneralText(description ?? '',
                    maxLines: 5,
                    style: const TextStyle(
                        color: Color(0xff909094), fontSize: 16.0)),
                title == 'Hosted By'
                    ? widget._bookingItemDetails.t.bookingStatus ==
                                Strings.confirmed ||
                            widget._bookingItemDetails.t.bookingStatus ==
                                Strings.inProgress ||
                            widget._bookingItemDetails.t.bookingStatus ==
                                Strings.completeStatus
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  navigateToMap(
                                    context,
                                    widget._bookingItemDetails.t.experience
                                        .latitude,
                                    widget._bookingItemDetails.t.experience
                                        .longitude,
                                  );
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        //width: 10.8,
                                        child: Image.asset(
                                      "assets/images/icons/location_pin.png",
                                      width: 14,
                                    )),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    SizedBox(
                                        width: 190,
                                        child: GeneralText(
                                          widget._bookingItemDetails.t
                                                  .experience.address +
                                              ', ' +
                                              (widget._bookingItemDetails.t
                                                      .experience.townName ??
                                                  'null') +
                                              ', ' +
                                              (widget._bookingItemDetails.t
                                                      .experience.cityName ??
                                                  'null'),
                                          maxLines: 3,
                                          style: appTheme.typographies
                                              .interFontFamily.headline6
                                              .copyWith(
                                                  fontSize: 14.0,
                                                  color: Colors.white,
                                                  decoration:
                                                      TextDecoration.underline),
                                        )),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Column(
                                children: [
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                            width: 14,
                                            height: 18.8,
                                            child: Image.asset(
                                                "assets/images/mobile_icon.png")),
                                        const SizedBox(
                                          width: 13.5,
                                        ),
                                        GeneralText(
                                          // Strings.foodieInfoProfessionValue,
                                          widget._bookingItemDetails.t
                                              .chefMobileNo
                                              .toString(),
                                          style: appTheme.typographies
                                              .interFontFamily.headline6
                                              .copyWith(
                                            fontSize: 14.0,
                                            color: HexColor.fromHex('#ffffff'),
                                          ),
                                        )
                                      ]),
                                ],
                              ),
                            ],
                          )
                        : const SizedBox()
                    : const SizedBox(),
              ],
            ),
            title == 'Hosted By'
                ? GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => UserProfile(
                      //           chefData: widget._chefData,
                      //         )));
                    },
                    child: Container(
                        width: 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            shape: BoxShape.circle),

                        ///chef image
                        child:
                            widget._bookingItemDetails.t.chefProfileImageUrl ==
                                    null
                                ? Image.asset(Resources.userProfileImageIcon)
                                : CircleAvatar(
                                    radius: 60, // Image radius
                                    backgroundImage: NetworkImage(
                                        Api.baseURLForImages +
                                            widget._bookingItemDetails.t
                                                .chefProfileImageUrl
                                                .toString()),
                                  )),
                  )
                : const SizedBox(),
          ],
        ),
        FunctionHelper().getDivider(),
      ],
    );
  }

  Widget productPriceInfo(IAppThemeData appTheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.only(
          top: 22, bottom: 22, start: 23, end: 23),
      decoration: BoxDecoration(
          color: const Color(0xff34343e),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GeneralText(
            Strings.priceDetails, // Strings.labelSeaFood2Experience,
            style: appTheme.typographies.interFontFamily.headline6.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xffeee0c1),
            ),
          ),
          const SizedBox(
            height: 13.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GeneralText(
                Strings.totalAmount,
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: HexColor.fromHex('#ffffff'),
                ),
              ),
              GeneralText(
                // Strings.productDetailPriceTaxValue,
                '${Strings.rupeesLabel} ${widget._bookingItemDetails.t.totalPrice}',
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: HexColor.fromHex('#ffffff'),
                ),
              ),
            ],
          ),
          getHorizontalLine(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GeneralText(
                Strings.productDetailPriceTotal,
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 15,
                  color: HexColor.fromHex('#b9b7ba'),
                ),
              ),
              GeneralText(
                // Strings.productDetailPriceTaxValue,
                '${Strings.rupeesLabel} ${widget._bookingItemDetails.t.totalPrice}',
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 15,
                  color: HexColor.fromHex('#b9b7ba'),
                ),
              ),
            ],
          ),
          getHorizontalLine(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GeneralText(
                Strings.productDetailPriceTax,
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 15,
                  color: HexColor.fromHex('#b9b7ba'),
                ),
              ),
              GeneralText(
                // Strings.productDetailPriceTaxValue,
                '${Strings.rupeesLabel} ${(widget._bookingItemDetails.t.totalPrice).toStringAsFixed(0)}',
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 15,
                  color: HexColor.fromHex('#b9b7ba'),
                ),
              ),
            ],
          ),
          getHorizontalLine(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GeneralText(
                Strings.productDetailAdvancePayment,
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 15,
                  color: HexColor.fromHex('#b9b7ba'),
                ),
              ),
              GeneralText(
                // Strings.productDetailAdvancePaymentValue,
                '${Strings.rupeesLabel} ${(widget._bookingItemDetails.t.totalPrice).toStringAsFixed(0)}',
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 15,
                  color: HexColor.fromHex('#b9b7ba'),
                ),
              ),
            ],
          ),
          getHorizontalLine(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GeneralText(
                Strings.amountDue,
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: HexColor.fromHex('#f1c452'),
                ),
              ),
              GeneralText(
                // Strings.productDetailPriceTaxValue,
                '${Strings.rupeesLabel} ${widget._bookingItemDetails.t.totalPrice}',
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: HexColor.fromHex('#f1c452'),
                ),
              ),
            ],
          ),
          // widget._advancePendingDetails.t.bookingStatus ==
          //     Strings.billGenerated
          //     ? Column(
          //   children: [
          //     const SizedBox(
          //       height: 15,
          //     ),
          //     Container(
          //       color: HexColor.fromHex("#ffffff").withOpacity(0.3),
          //       width: double.infinity,
          //       height: 1,
          //     ),
          //     const SizedBox(
          //       height: 15,
          //     ),
          //     Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         GeneralText(
          //           Strings.amountDue,
          //           style: appTheme
          //               .typographies.interFontFamily.headline6
          //               .copyWith(
          //             fontSize: 18,
          //             color: HexColor.fromHex('#f1c452'),
          //           ),
          //         ),
          //         GeneralText(
          //           //     Strings.productDetailPriceTaxValue,
          //           "${Strings.rupeesLabel} ${(widget._advancePendingDetails.t.totalAmount - widget._advancePendingDetails.t.advancePayment).toStringAsFixed(0)}",
          //           style: appTheme
          //               .typographies.interFontFamily.headline6
          //               .copyWith(
          //             fontSize: 22,
          //             fontWeight: FontWeight.bold,
          //             color: HexColor.fromHex('#f1c452'),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // )
          //     : const SizedBox(),
        ],
      ),
    );
  }

  Widget getWowFactorsList(IAppThemeData appTheme, List<CustomModel> items) {
    return SizedBox(
      height: DeviceHelper.height * 0.13,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (int i = 0; i < items.length; i++)
            Container(
              width: DeviceHelper.width * 0.22,
              padding: const EdgeInsets.only(
                left: 7,
                top: 7,
              ),
              margin: const EdgeInsets.only(
                right: 10,
              ),
              decoration: BoxDecoration(
                color: HexColor.fromHex('#34343e'),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.network(
                    items[i].name != null
                        ? Api.baseURLForImages + items[i].icon.toString()
                        : '',
                    fit: BoxFit.cover,
                    width: 35,
                    color: const Color(0xfff1c452),
                  ),
                  SizedBox(height: DeviceHelper.height * 0.02),
                  GeneralText(
                    items[i].name ?? "",
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 12,
                      color: HexColor.fromHex('#d9d9d9'),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // Widget wowFactors(IAppThemeData appTheme) {
  //   return Container(
  //     width: double.infinity,
  //     padding: const EdgeInsetsDirectional.only(
  //         top: 20, bottom: 20, start: 11.8, end: 11.8),
  //     decoration: BoxDecoration(
  //         color: HexColor.fromHex("#4b4b52"),
  //         borderRadius: BorderRadius.circular(15)),
  //     child: Wrap(
  //       children: [
  //         for (int i = 0; i < wowFactorsList.length; i++)
  //           Padding(
  //             padding: const EdgeInsets.only(right: 17, bottom: 7.7),
  //             child: Column(
  //               children: [
  //                 Container(
  //                   width: 58,
  //                   height: 63.3,
  //                   padding: const EdgeInsetsDirectional.all(10),
  //                   decoration: const BoxDecoration(
  //                     image: DecorationImage(
  //                       image: AssetImage(
  //                           'assets/images/icons/food_item_circle.png'),
  //                       fit: BoxFit.fill,
  //                     ),
  //                     shape: BoxShape.circle,
  //                   ),
  //                   child: Container(
  //                     padding: const EdgeInsetsDirectional.all(10),
  //                     decoration: BoxDecoration(
  //                       color: HexColor.fromHex("#f1c452"),
  //                       shape: BoxShape.circle,
  //                     ),
  //                     // child: Image.asset(wowFactorsList[i].icon != null
  //                     //     ? wowFactorsList[i].icon ?? ""
  //                     //     : ''),
  //
  //                     child: SvgPicture.network(wowFactorsList[i].icon != null
  //                         ? Api.baseURLForImages +
  //                                 wowFactorsList[i].icon.toString() ??
  //                             ""
  //                         : ''),
  //                   ),
  //                 ),
  //                 GeneralText(
  //                   wowFactorsList[i].name ?? "",
  //                   style: appTheme.typographies.interFontFamily.headline6
  //                       .copyWith(
  //                     fontSize: 14,
  //                     color: HexColor.fromHex('#ffffff'),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //       ],
  //     ),
  //   );
  // }

  // Widget foodProductDetails(IAppThemeData appTheme) {
  //   DateTime dateTime =
  //       widget._bookingItemDetails.t.scheduleScheduledDate ?? DateTime.now();
  //   // DateTime dateTime = DateTime.parse(dateValue);
  //   String monthAbbreviation =
  //       FunctionHelper().getMonthAbbreviation(dateTime.month);
  //   String dayAbbreviation =
  //       FunctionHelper().getDayAbbreviation(dateTime.weekday);
  //
  //   var _hourSelected = widget._bookingItemDetails.t.scheduleStartTime ?? "";
  //
  //   var _productDetailSelectionDate = dayAbbreviation +
  //       ',  ' +
  //       (dateTime.day.toString()) +
  //       " " +
  //       monthAbbreviation;
  //
  //   var _productDetailSelectionTime = InfininURLHelpers.getAmPm(
  //       widget._bookingItemDetails.t.scheduleStartTime ?? "");
  //   var _productDetailSelectionType =
  //       widget._bookingItemDetails.t.preferenceName ?? "";
  //   var _numberOfPerson = widget._bookingItemDetails.t.persons ?? '';
  //
  //   return Padding(
  //     padding: const EdgeInsetsDirectional.only(start: 25, end: 25),
  //     child: Container(
  //         width: double.infinity,
  //         padding: const EdgeInsetsDirectional.only(
  //             top: 22, bottom: 29, start: 10, end: 10),
  //         decoration: BoxDecoration(
  //             color: HexColor.fromHex("#4b4b52"),
  //             borderRadius: BorderRadius.circular(15)),
  //         child: Column(
  //           children: [
  //             Container(
  //               padding: const EdgeInsetsDirectional.only(
  //                   top: 17, bottom: 17, start: 26, end: 48),
  //               decoration: BoxDecoration(
  //                   color: HexColor.fromHex("#212129"),
  //                   borderRadius: BorderRadius.circular(11)),
  //               child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Column(
  //                       children: [
  //                         GeneralText(
  //                           // Strings.productDetailSelectionDate,
  //                           _productDetailSelectionDate,
  //                           style: appTheme
  //                               .typographies.interFontFamily.headline2
  //                               .copyWith(
  //                             fontSize: 14,
  //                             color: HexColor.fromHex('#ea7458'),
  //                           ),
  //                         ),
  //                         GeneralText(
  //                           //  Strings.productDetailSelectionTime,
  //                           _productDetailSelectionTime,
  //                           style: appTheme
  //                               .typographies.interFontFamily.headline2
  //                               .copyWith(
  //                             fontSize: 30,
  //                             color: HexColor.fromHex('#b0c18b'),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Container(
  //                       color: HexColor.fromHex('#707070'),
  //                       width: 1,
  //                       height: 69,
  //                     ),
  //                     Column(
  //                       children: [
  //                         GeneralText(
  //                           // Strings.productDetailSelectionType,
  //                           _productDetailSelectionType,
  //                           style: appTheme
  //                               .typographies.interFontFamily.headline2
  //                               .copyWith(
  //                             fontSize: 14,
  //                             color: HexColor.fromHex('#8ea659'),
  //                           ),
  //                         ),
  //                         GeneralText(
  //                           //    Strings.productDetailSelectionTotalPersons,
  //                           _numberOfPerson,
  //                           style: appTheme
  //                               .typographies.interFontFamily.headline2
  //                               .copyWith(
  //                             fontSize: 30,
  //                             color: HexColor.fromHex('#8ea659'),
  //                           ),
  //                         ),
  //                         GeneralText(
  //                           Strings.productDetailSelectionPersons,
  //                           style: appTheme
  //                               .typographies.interFontFamily.headline6
  //                               .copyWith(
  //                                   fontSize: 12,
  //                                   color: HexColor.fromHex('#909094'),
  //                                   fontWeight: FontWeight.w400),
  //                         ),
  //                       ],
  //                     ),
  //                   ]),
  //             ),
  //             const SizedBox(
  //               height: 29,
  //             ),
  //             productRelatedNotes(appTheme),
  //             const SizedBox(
  //               height: 29,
  //             ),
  //             productMenuDetails(appTheme),
  //           ],
  //         )),
  //   );
  // }

  Future _loadMapStyles() async {
    darkMapStyle =
        await rootBundle.loadString('assets/json/dark_mode_style.json');
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
            // Strings.productDetailSelectionNotes,
            widget._bookingItemDetails.t.comments,
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
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
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
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          //scrollDirection: Axis.horizontal,
          children: [
            for (int index = 0; index < menuListItems.length; index++)
              getMenuItem(appTheme, index, menuListItems[index]),
          ],
        )
      ],
    );
  }

  getMenuItem(IAppThemeData appTheme, int index, menuItem) {
    return Container(
      //height: 150,
      decoration: BoxDecoration(
          color: const Color(0xff34343e),
          borderRadius: BorderRadius.circular(
            15,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(
                10,
              ),
            ),
            child: Image.network(
              Api.baseURLForImages + menuItem.icon,
              height: DeviceHelper.height * 0.20,
              width: DeviceHelper.width,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: DeviceHelper.height * 0.02,
              horizontal: DeviceHelper.width * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                getFoodItemTitle(
                    appTheme: appTheme, foodItemTitle: menuItem.name),
                // getFoodItemSubTitle(
                //     appTheme: appTheme, subTitle: menuItem.baseDishName),
                getFoodItemDescription(
                    appTheme: appTheme,
                    foodItemDescription: menuItem.description),
              ],
            ),
          ),
          widget._bookingItemDetails.t.priceTypeId == 2
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: DeviceHelper.width * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            Resources.userIconMenu,
                            height: DeviceHelper.height * 0.02,
                            color: HexColor.fromHex('#d9d9d9'),
                          ),
                          SizedBox(
                            width: DeviceHelper.width * 0.02,
                          ),
                          // Container(
                          //     child: getFoodItemUsers(
                          //         appTheme: appTheme,
                          //         index: index,
                          //         menuItem: menuItem)),
                        ],
                      ),
                      SizedBox(
                        height: DeviceHelper.height * 0.01,
                      ),
                      //displayQuantityData(filteredList[k].price, k, menuItem),
                    ],
                  ),
                )
              : Container(),
          SizedBox(
            height: DeviceHelper.height * 0.03,
          ),
        ],
      ),
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
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          shape: BoxShape.circle),
                      child: GestureDetector(
                        child: CircleAvatar(
                          radius: 27,
                          backgroundImage: NetworkImage(Api.baseURLForImages +
                              widget._bookingItemDetails.t.chefProfileImageUrl
                                  .toString()),
                        ),
                        onTap: () {},
                      )),
                  const SizedBox(
                    width: 11.5,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GeneralText(
                          // Strings.productDetailChefName,
                          widget._bookingItemDetails.t.experience.chefBrandName,
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                            fontSize: 18,
                            color: HexColor.fromHex('#f1c452'),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                                width: 10.8,
                                child: Image.asset(
                                    "assets/images/icons/location_pin.png")),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: GeneralText(
                                // Strings.productDetailChefLocation,
                                (widget._bookingItemDetails.t.experience
                                            .townName ??
                                        'null') +
                                    ', ' +
                                    (widget._bookingItemDetails.t.experience
                                            .cityName ??
                                        'null'),
                                style: appTheme
                                    .typographies.interFontFamily.headline6
                                    .copyWith(
                                        fontSize: 14,
                                        color: Colors.white,
                                        decoration: TextDecoration.underline),
                                maxLines: 3,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
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
                  //Strings.productDetailChefSubHostName,
                  widget._bookingItemDetails.t.experience.subHostName,
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
                        '${Strings.rupeesLabel} ${(widget._bookingItemDetails.t.totalAmount).toStringAsFixed(0)}',
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                                fontSize: 36,
                                color: HexColor.fromHex('#f89f84'),
                                fontWeight: FontWeight.w300),
                      ),
                      GeneralText(
                        Strings.totalAmount,
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
                      '${Strings.rupeesLabel} ${widget._bookingItemDetails.t.totalPrice}',
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
                      '${Strings.rupeesLabel} ${(widget._bookingItemDetails.t.tax).toStringAsFixed(0)}',
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
                      Strings.productDetailAdvancePayment,
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                        fontSize: 15,
                        color: HexColor.fromHex('#ffffff'),
                      ),
                    ),
                    GeneralText(
                      // Strings.productDetailAdvancePaymentValue,
                      '${Strings.rupeesLabel} ${(widget._bookingItemDetails.t.advancePayment).toStringAsFixed(0)}',
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                        fontSize: 15,
                        color: HexColor.fromHex('#ffffff'),
                      ),
                    ),
                  ],
                ),
                widget._bookingItemDetails.t.bookingStatus.toUpperCase() ==
                            'MISSED' ||
                        widget._bookingItemDetails.t.bookingStatus
                                .toUpperCase() ==
                            'DECLINED'
                    ? const SizedBox()
                    : Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            color: HexColor.fromHex("#ffffff").withOpacity(0.3),
                            width: double.infinity,
                            height: 1,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GeneralText(
                                Strings.amountDue,
                                style: appTheme
                                    .typographies.interFontFamily.headline6
                                    .copyWith(
                                  fontSize: 18,
                                  color: HexColor.fromHex('#f1c452'),
                                ),
                              ),
                              GeneralText(
                                //     Strings.productDetailPriceTaxValue,
                                "${Strings.rupeesLabel} ${(widget._bookingItemDetails.t.advancePayment).toStringAsFixed(0)}",
                                style: appTheme
                                    .typographies.interFontFamily.headline6
                                    .copyWith(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor.fromHex('#f1c452'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget extraPaymentNotes(IAppThemeData appTheme) {
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
                Strings.productDetailExtraNote,
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
                color: HexColor.fromHex("#bb3127"),
                borderRadius: BorderRadius.circular(15)),
            child: GeneralText(
              widget._bookingItemDetails.t.bookingStatus
                          .toString()
                          .toUpperCase() ==
                      Strings.acceptData
                  ? Strings.productDetailExtraNoteValue
                  : Strings.bistroApprovalRequired,
              style: appTheme.typographies.interFontFamily.headline6.copyWith(
                fontSize: 14,
                color: HexColor.fromHex('#ffffff'),
              ),
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }

  Widget checkTermsConditions(IAppThemeData appTheme) {
    return Container(
      // padding: EdgeInsetsDirectional.only(start: 25, end: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor: HexColor.fromHex('#f1c452'),
            ),
            child: Checkbox(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              checkColor: HexColor.fromHex('#f1c452'),
              activeColor: Colors.red,
              value: checkValue,
              onChanged: (bool? value) {
                setState(() {
                  checkValue = value!;
                });
              },
            ),
          ),
          GeneralText(
            Strings.foodItemAdvancePendingTermsCondition,
            style: appTheme.typographies.interFontFamily.headline6.copyWith(
              decoration: TextDecoration.underline,
              fontSize: 18,
              color: HexColor.fromHex('#f1c452'),
            ),
          ),
          // GeneralCheckbox(
          //   controlAffinity: ControlAffinity.trailing,
          //
          //   decoration: InputDecoration(iconColor: Colors.red,).copyWith(iconColor: Colors.red,),
          //     title: Icon(Icons.check_box_outline_blank,),
          //     name: "Terms & Conditions")
          // Row(
          //   children: [
          //     Container(
          //       color: HexColor.fromHex('#f1c452'),
          //       width: 16,
          //       height: 1,
          //     ),
          //     const SizedBox(
          //       width: 2,
          //     ),
          //     GeneralText(
          //       Strings.productDetailExtraNote,
          //       style: appTheme.typographies.interFontFamily.headline6.copyWith(
          //         fontSize: 20,
          //         color: HexColor.fromHex('#f1c452'),
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 13.1,
          // ),
          // Container(
          //   width: double.infinity,
          //   padding: EdgeInsetsDirectional.only(
          //       top: 22, bottom: 22, start: 23, end: 23),
          //   decoration: BoxDecoration(
          //       color: HexColor.fromHex("#bb3127"),
          //       borderRadius: BorderRadius.circular(20)),
          //   child: GeneralText(
          //     Strings.productDetailExtraNoteValue,
          //     style: appTheme.typographies.interFontFamily.headline6.copyWith(
          //       fontSize: 14,
          //       color: HexColor.fromHex('#ffffff'),
          //     ),
          //     maxLines: 2,
          //   ),
          // )
        ],
      ),
    );
  }

  Widget getStartedButtonTitle({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      title: Strings.foodItemBookingAdvancePendingButton.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        // CustomDialog.getDialog(ctx: context, title: 'Booking Confirmed', description: 'Advance have been received by Zee Lounge', iconUrl: 'assets/images/tick_icon.png');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  JazzCashWebView(bookindData: widget._bookingItemDetails)),
        );
      },
    );
  }

  getHorizontalLine() {
    return Column(
      children: [
        const SizedBox(
          height: 7,
        ),
        Container(
          color: HexColor.fromHex("#4e4e5d").withOpacity(0.3),
          width: double.infinity,
          height: 1.3,
        ),
        const SizedBox(
          height: 7,
        ),
      ],
    );
  }

  Widget getFoodItemTitle(
      {required IAppThemeData appTheme, required String foodItemTitle}) {
    return GeneralText(
      //  Strings.foodProductTitle,
      foodItemTitle,
      maxLines: 2,
      style: appTheme.typographies.interFontFamily.headline6.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: HexColor.fromHex('#f1c452')),
    );
  }

  Widget getFoodItemDescription(
      {required IAppThemeData appTheme, required String foodItemDescription}) {
    return GeneralText(
      foodItemDescription,
      maxLines: 3,
      textAlign: TextAlign.start,
      style: appTheme.typographies.interFontFamily.headline6
          .copyWith(fontSize: 14, color: HexColor.fromHex('#909094')),
    );
  }

  Future<void> navigateToMap(
      BuildContext context, double lat, double lng) async {
    String url = '';
    String urlAppleMaps = '';
    if (Platform.isAndroid) {
      url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw '${Strings.couldNotLaunch} $url';
      }
    } else {
      urlAppleMaps = 'https://maps.apple.com/?q=$lat,$lng';
      url = 'comgooglemaps://?saddr=&daddr=$lat,$lng&directionsmode=driving';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else if (await canLaunchUrl(Uri.parse(urlAppleMaps))) {
        await launchUrl(Uri.parse(urlAppleMaps));
      } else {
        throw '${Strings.couldNotLaunch} $url';
      }
    }
  }

  getBillGeneratedButtons() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
      ),
      child: Row(
        children: [
          GeneralButton.button(
            title: Strings.payDigital,
            styleType: ButtonStyleType.fill,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => JazzCashWebView(
                        bookindData: widget._bookingItemDetails)),
              );
              // _showGeneralPopup(context, title: Strings.confirmationTitle, description: Strings.confirmCancelMessage);
            },
          ),
          const SizedBox(width: 10),
          GeneralButton.button(
            title: Strings.payCash,
            styleType: ButtonStyleType.fill,
            onTap: () {
              CustomDialog.getDialog(
                ctx: context,
                title: Strings.pleaseWait,
                //titleColor: Colors.white,
                //descColor: const Color(0xFFfee4a4),
                description: Strings.waitBistroApprovalDescription,
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
}

class CustomModel {
  String? name;
  String? icon;
  String? price;
  String? description;
  int? quantity;

  CustomModel(
      {this.name, this.icon, this.price, this.quantity, this.description});
}
