import 'package:chef/constants/api.dart';
import 'package:chef/models/home/chef_data_response.dart';
import 'package:chef/models/home/home_response.dart' as home_data;
import 'package:chef/screens/home/food_details_menu_model.dart';
import 'package:flutter/material.dart';

import '../../../constants/resources.dart';
import '../../../constants/strings.dart';
import '../../../helpers/color_helper.dart';
import '../../../helpers/order_helper.dart';
import '../../../helpers/url_helper.dart';
import '../../../models/booking/booking_request.dart';
import '../../../services/application_state.dart';
import '../../../setup.dart';
import '../../../theme/app_theme_data/app_theme_data.dart';
import '../../../theme/app_theme_widget.dart';
import '../../../ui_kit/widgets/general_new_appbar.dart';
import '../../../ui_kit/widgets/general_text.dart';
import '../../bottom_bar/bottom_bar.dart';

import 'dart:developer' as developer;

class FoodProductDetailsSummary extends StatefulWidget {

  const FoodProductDetailsSummary({
    Key? key,

    required this.experienceData,
    required this.foodMenuDetail,
    required this.selectedExperienceId,
    required this.chefData,
    required this.appService,
  }) : super(key: key);

  final home_data.Experiences? experienceData;
  final FoodMenuModel foodMenuDetail;
  final ChefDataResponse chefData;
  final String selectedExperienceId;
  final appService;

  @override
  State<FoodProductDetailsSummary> createState() =>
      _FoodProductDetailsSummaryState();
}

class _FoodProductDetailsSummaryState extends State<FoodProductDetailsSummary> {
  List<CustomModel> wowFactorsList = [];
  List<CustomModel> menuListItems = [];
  bool isLoading = true;

  @override
  void initState() {
    loadMenuSelected();
    loadWowFactors();
    super.initState();
    isLoading = false;
  }

  void loadMenuSelected() {
    for (var i = 0; i < widget.foodMenuDetail.t.length; i++) {
      developer.log(
          ' Widget  Food Menu Detail ' + widget.foodMenuDetail.t[i].dish);
      menuListItems.add(CustomModel(name: widget.foodMenuDetail.t[i].dish, price: widget.foodMenuDetail.t[i].price, id: widget.foodMenuDetail.t[i].id));
    }
  }

  void loadWowFactors() {
    for (int i = 0;
    i < widget.experienceData!.experienceWowFactors!.length;
    i++) {
      wowFactorsList.add(CustomModel(
          name: widget.experienceData!.experienceWowFactors![i]
              .wowFactorName, //   Strings.productDetailWowFactorGarden,
          icon: "assets/images/icons/garden.png"));
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return isLoading ? const CircularProgressIndicator() : Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Container(
            color: HexColor.fromHex("#212129"),
            child: Column(
              children: [
                const SizedBox(
                  height: 18,
                ),
                ///top container which have image, title, home icon etc
                Container(
                  height: 217,
                  padding: const EdgeInsets.only(left: 33, bottom: 17),
                  decoration: BoxDecoration(
                    color: HexColor.fromHex("#4b4b52"),
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50)),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ///experience image
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
                      ///experience title, name and rating column
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GeneralText(
                              widget.experienceData!.title!,
                              style: appTheme
                                  .typographies.interFontFamily.headline6
                                  .copyWith(
                                fontSize: 22,
                                color: HexColor.fromHex('#f1c452'),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            GeneralText(
                              widget.experienceData!.chefBrandName!,
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
                                  widget.experienceData?.averageRating?.toString() ?? 'no reviews',
                                  style: appTheme
                                      .typographies.interFontFamily.headline6
                                      .copyWith(
                                      fontSize: 12,
                                      color: HexColor.fromHex('#8ea659')),
                                ),
                              ],
                            ),
                          ]),
                      ///home icon
                      Positioned.fill(
                        top: 40,
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                                onTap: () {
                                  // Navigator.popUntil(
                                  //     context, (route) => HomeScreen());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        BottomBar(bottomBarType: BottomBarType.home,)),
                                  );
                                },
                                child: const GeneralNewAppBar(
                                  rightIcon: Resources.homeIconSvg,
                                ))),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 33.9,
                ),
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
                            width: 2,
                          ),
                          GeneralText(
                            Strings.productDetailAboutTitle,
                            style: appTheme
                                .typographies.interFontFamily.headline6
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
                      ///experience description
                      Padding(
                        padding: const EdgeInsets.only(left: 23),
                        child: GeneralText(
                          // Strings.productDetailAboutSubTitle,
                          widget.experienceData!.description!,
                          maxLines: 4,
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
                            width: 2,
                          ),
                          GeneralText(
                            Strings.productDetailWowFactorTitle,
                            style: appTheme
                                .typographies.interFontFamily.headline6
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
                chefInformation(appTheme),
                const SizedBox(
                  height: 45.9,
                ),
                productPriceInformation(appTheme),
                const SizedBox(
                  height: 28,
                ),
                extraPaymentNotes(appTheme),
                const SizedBox(
                  height: 209.1,
                ),
              ],
            )),
      ),
    );
  }

  Widget wowFactors(IAppThemeData appTheme) {
    return Container(
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
              padding: const EdgeInsets.only(right: 15.1, bottom: 7.7),
              child: Column(
                children: [
                  Container(
                    width: 58,
                    height: 63.3,
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
   OrderHelper orderHelper = (widget.appService.state.orderHelper)!;
    developer.log(' Schedule Id selected in Summary Page ' +
        orderHelper.scheduleId);

    var _date = InfininURLHelpers.dayOfMonth(
        orderHelper.daysGroup.scheduledDate);
    var dayOfMonth = orderHelper.daysGroup.scheduledDate.day;
    var _month = InfininURLHelpers.months[
    orderHelper.daysGroup.scheduledDate.month - 1];
    var _hourSelected = orderHelper.hourSelected.startTime;

    var _productDetailSelectionDate = _date.toUpperCase() +
        ',  ' +
        (dayOfMonth.toString())+
        "   " +
        _month.toString().toUpperCase();
    var _productDetailSelectionTime = InfininURLHelpers.getAmPm(
        orderHelper.hourSelected.startTime);
    var _productDetailSelectionType =
        orderHelper.selectedCategory;
    var _numberOfPerson =
        orderHelper.numberOfPerson ?? 4.toString();
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
                    children: [
                      Column(
                        children: [
                          GeneralText(
                            _productDetailSelectionDate,
                            style: appTheme
                                .typographies.interFontFamily.headline2
                                .copyWith(
                              fontSize: 14,
                              color: HexColor.fromHex('#ea7458'),
                            ),
                          ),
                          GeneralText(
                            _productDetailSelectionTime,
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
                            _productDetailSelectionType,
                            style: appTheme
                                .typographies.interFontFamily.headline2
                                .copyWith(
                              fontSize: 14,
                              color: HexColor.fromHex('#8ea659'),
                            ),
                          ),
                          GeneralText(
                            _numberOfPerson.toString(),
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
              widget.experienceData?.priceTypeId == 2 ? perItemProductMenuDetails(appTheme) : productMenuDetails(appTheme),
            ],
          )),
    );
  }

  Widget productRelatedNotes(IAppThemeData appTheme) {
    var _noteAdded = widget.appService.state.orderHelper!.noteAdded ?? '';
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
            _noteAdded,
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
          runAlignment: WrapAlignment.start,
          children: [
            for (int index = 0; index < menuListItems.length; index++)
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.experienceData!.priceTypeId != 1 ? GeneralText(
                          Strings.productDetailSelectionMenuQuantity,
                          style: appTheme.typographies.interFontFamily.headline2
                              .copyWith(
                            fontSize: 16,
                            color: HexColor.fromHex('#f89f84'),
                          ),
                        ):const SizedBox(),
                        widget.experienceData!.priceTypeId != 1
                            ? GeneralText(
                          menuListItems[index].price.toString(),
                          style: appTheme
                              .typographies.interFontFamily.headline2
                              .copyWith(
                            fontSize: 16,
                            color: HexColor.fromHex('#909094'),
                          ),
                        )
                            : Container(),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GeneralText(
                      menuListItems[index].name ?? "",
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
        )
      ],
    );
  }

  Widget perItemProductMenuDetails(IAppThemeData appTheme) {

    List<BookingDetails> bookingDetails = locateService<ApplicationService>().state.orderHelper!.bookingMenuDetails;

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
          runAlignment: WrapAlignment.start,
          children: [
            for (var menuItem in menuListItems)
              for(var bookingMenuItem in bookingDetails)
                bookingMenuItem.menuId == menuItem.id ?
                  Container(
                width: 140,
                padding: const EdgeInsetsDirectional.only(
                    top: 10, bottom: 10, start: 14, end: 14),
                margin: const EdgeInsets.only(right: 5, bottom: 7),
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
                          bookingMenuItem.quantity.toString() + 'x',
                          style: appTheme.typographies.interFontFamily.headline2
                              .copyWith(
                            fontSize: 16,
                            color: HexColor.fromHex('#f89f84'),
                          ),
                        ),
                        GeneralText(
                          (menuItem.price! * int.parse(bookingMenuItem.quantity.toString())).toString(),
                          style: appTheme
                              .typographies.interFontFamily.headline2
                              .copyWith(
                            fontSize: 16,
                            color: HexColor.fromHex('#909094'),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GeneralText(
                      menuItem.name ?? "",
                      style: appTheme.typographies.interFontFamily.headline2
                          .copyWith(
                          fontSize: 14,
                          color: HexColor.fromHex('#ffffff'),
                          fontWeight: FontWeight.w400),
                      maxLines: 3,
                    ),
                  ],
                ),
              ) : const SizedBox(),
          ],
        )
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
                width: 2,
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
                      width: 43,
                      height: 43,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          shape: BoxShape.circle),
                      child: CircleAvatar(
                        radius: 27,
                        backgroundImage: NetworkImage(Api.baseURLForImages+widget.chefData.t!.profileImageUrl.toString()),
                          )),
                  const SizedBox(
                    width: 11.5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GeneralText(
                        widget.chefData.t!.name.toString(),
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                          fontSize: 18,
                          color: HexColor.fromHex('#f1c452'),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                              width: 10.8,
                              height: 14.4,
                              child: Image.asset(
                                  "assets/images/icons/location_pin.png")),
                          const SizedBox(
                            width: 5,
                          ),
                          GeneralText(
                          (widget.experienceData?.townName.toString() ?? 'null') + ', '+ (widget.experienceData?.cityName.toString() ?? 'null'),
                            //Strings.productDetailChefLocation,
                            style: appTheme
                                .typographies.interFontFamily.headline6
                                .copyWith(
                                fontSize: 14,
                                color: HexColor.fromHex('#ffffff'),
                                decoration: TextDecoration.underline),
                          ),
                        ],
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
                const SizedBox(
                  height: 1.7,
                ),
                GeneralText(
                  widget.experienceData
                      !.subHostName!, //    Strings.productDetailChefSubHostName,
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
    num price = widget.experienceData!.priceTypeId == 1 ? widget.experienceData!.price! * widget.appService.state.orderHelper.numberOfPerson : widget.experienceData!.price!;
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
                        'Rs. ' + (price + price * 0.17).toStringAsFixed(0),
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
                      'Rs. $price',
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
                      'Rs. ' + (price  * 0.17).toStringAsFixed(0),
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
                      'Rs. ' + ((price + price * 0.17) * 0.20).toStringAsFixed(0),
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                        fontSize: 15,
                        color: HexColor.fromHex('#ffffff'),
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
                width: 2,
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
              Strings.noPaymentRequired,
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

}

class CustomModel {
  String? name;
  String? icon;
  int? price;
  int? id;

  CustomModel({this.name, this.icon, this.price, this.id});
}
