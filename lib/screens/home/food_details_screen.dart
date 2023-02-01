import 'package:chef/helpers/helpers.dart';
import 'package:flutter/material.dart';

import '../../constants/resources.dart';
import '../../constants/strings.dart';
import '../../helpers/color_helper.dart';
import '../../theme/app_theme_data/app_theme_data.dart';
import '../../theme/app_theme_widget.dart';
import '../../ui_kit/widgets/general_button.dart';
import '../../ui_kit/widgets/general_dropdown.dart';
import '../../ui_kit/widgets/general_new_appbar.dart';
import '../../ui_kit/widgets/general_text.dart';
import '../../ui_kit/widgets/general_text_input.dart';
import '../user_account/user_profile.dart';

enum TabBars { Details, Menu, Schedule }

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({Key? key}) : super(key: key);

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int foodItemQuantity = 0;
  String selectedDate = "13";
  String selectedDay = "MON";
  String selectedMonth = "OCT";
  String selectedTime = "10 AM";
  final TextController nOfPersons = TextController();
  final TextController notes = TextController();
  late List<DropdownMenuItem<String>> statusList = [];
  // late List<DropdownMenuItem<String>> items = [];

  final items = <String>[];

  bool scheduleForm = false;

  List<CustomModel> wowFactorsList = [];
  List<CustomModel> preferencesList = [];
  List<CustomModel> menuListItems = [];

  @override
  void initState() {
    var newItem = const DropdownMenuItem(
      child: Text('Scientist'),
      value: 'Scientist',
      alignment: Alignment.centerLeft,
    );
    var newItem1 = const DropdownMenuItem(
      child: Text('Couple'),
      value: 'Couple',
      alignment: Alignment.centerLeft,
    );
    var newItem2 = const DropdownMenuItem(
      child: Text('Single'),
      value: 'Single',
      alignment: Alignment.centerLeft,
    );
    // items.add(newItem);
    // items.add(newItem1);
    // items.add(newItem2);

    items.add('Scientist');
    items.add('Couple');
    items.add('Single');

    menuListItems.addAll([
      CustomModel(name: "Sindhi Biryani"),
      CustomModel(name: "Buritto"),
      CustomModel(name: "Vegetable Salad"),
      CustomModel(name: "Hyderabadi Rice"),
      CustomModel(name: "Soft Drinks"),
    ]);
    wowFactorsList.addAll([
      CustomModel(
          icon: Strings.productDetailWowFactorGarden,
          name: "assets/images/icons/garden.png"),
      CustomModel(
          icon: Strings.productDetailWowFactorFireworks,
          name: "assets/images/icons/fireworks.png"),
      CustomModel(
          icon: Strings.productDetailWowFactorPetFriendly,
          name: "assets/images/icons/pet_friendly.png"),
      CustomModel(
          icon: Strings.productDetailWowFactorWifi,
          name: "assets/images/icons/wifi_2.png"),
      CustomModel(
          icon: Strings.productDetailWowFactorMusic,
          name: "assets/images/icons/music.png"),
      CustomModel(
          icon: Strings.productDetailWowFactorParking,
          name: "assets/images/icons/parking.png")
    ]);
    preferencesList.addAll([
      CustomModel(
          icon: Strings.foodDetailPreferenceCouple,
          name: "assets/images/icons/couple.png"),
      CustomModel(
          icon: Strings.foodDetailPreferenceFamily,
          name: "assets/images/icons/family.png"),
      CustomModel(
          icon: Strings.foodDetailPreferenceFnf,
          name: "assets/images/icons/fnf.png"),
    ]);
    super.initState();
  }

  addQuantity() {
    if (foodItemQuantity != null && foodItemQuantity.toString().isNotEmpty) {
      setState(() {
        foodItemQuantity++;
      });
    }
  }

  removeQuantity() {
    if (foodItemQuantity != null && foodItemQuantity > 0) {
      setState(() {
        foodItemQuantity--;
      });
    }
  }

  TabBars selectedTab = TabBars.Menu;

  updateTabView(TabBars tab) {
    setState(() {
      if (TabBars.Details == tab) {
        selectedTab = tab;
      } else if (TabBars.Menu == tab) {
        selectedTab = tab;
      } else if (TabBars.Schedule == tab) {
        selectedTab = tab;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return Scaffold(
      backgroundColor: HexColor.fromHex('#212129'),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: getStartedButtonTitle(appTheme: appTheme),
      body: Stack(
        // clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Image.asset('assets/images/icons/food_detail_bg.png',
                  fit: BoxFit.fill),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsetsDirectional.only(start: 24),
                    color: HexColor.fromHex('#212129'),
                    child: Column(
                      children: [
                        if (selectedTab != TabBars.Schedule)
                          const SizedBox(
                            height: 60,
                          ),
                        if (selectedTab == TabBars.Schedule)
                          const SizedBox(
                            height: 40,
                          ),
                        if (selectedTab == TabBars.Menu)
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
                              getFoodItemHeading(appTheme: appTheme),
                            ],
                          ),
                        const SizedBox(
                          height: 15,
                        ),

                        
                        if (selectedTab == TabBars.Details)
                          detailsTabViewForm(context, appTheme),
                        if (selectedTab == TabBars.Menu)
                          menuTabView(context, appTheme),
                        if (selectedTab == TabBars.Schedule)
                          scheduleTabView(context, appTheme)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Positioned.fill(
            top: 70,
            left: 20,
            child: Align(
                alignment: Alignment.topLeft, child: GeneralNewAppBar()),
          ),
          Positioned(
            top: 140,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 25),
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: HexColor.fromHex("#4b4b52"),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomLeft: Radius.circular(30))),
                      height: 118,
                      padding: EdgeInsetsDirectional.only(bottom: 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(end: 14, top: 30),
                        child: Column(children: [
                          getFoodMainHeading(appTheme: appTheme),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: 36, end: 36),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  child: Column(
                                    children: [
                                      GeneralText(
                                        Strings.foodItemDetails,
                                        style: appTheme.typographies
                                            .interFontFamily.headline6
                                            .copyWith(
                                                fontSize: 14,
                                                fontWeight: selectedTab ==
                                                        TabBars.Details
                                                    ? FontWeight.bold
                                                    : FontWeight.w400,
                                                color: HexColor.fromHex(
                                                    '#f1c452')),
                                      ),
                                      Container(
                                        height: 9,
                                        width: 9,
                                        decoration: BoxDecoration(
                                            color: selectedTab ==
                                                    TabBars.Details
                                                ? HexColor.fromHex('#f1c452')
                                                : Colors.transparent,
                                            shape: BoxShape.circle),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    updateTabView(TabBars.Details);
                                  },
                                ),
                                InkWell(
                                  onTap: () {
                                    updateTabView(TabBars.Menu);
                                  },
                                  child: Column(
                                    children: [
                                      GeneralText(
                                        Strings.foodItemMenu,
                                        style: appTheme.typographies
                                            .interFontFamily.headline6
                                            .copyWith(
                                                fontSize: 14,
                                                fontWeight: selectedTab ==
                                                        TabBars.Menu
                                                    ? FontWeight.bold
                                                    : FontWeight.w400,
                                                color: HexColor.fromHex(
                                                    '#f1c452')),
                                      ),
                                      Container(
                                        height: 9,
                                        width: 9,
                                        decoration: BoxDecoration(
                                            color: selectedTab == TabBars.Menu
                                                ? HexColor.fromHex('#f1c452')
                                                : Colors.transparent,
                                            shape: BoxShape.circle),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    updateTabView(TabBars.Schedule);
                                  },
                                  child: Column(
                                    children: [
                                      GeneralText(
                                        Strings.foodItemSchedule,
                                        style: appTheme.typographies
                                            .interFontFamily.headline6
                                            .copyWith(
                                                fontSize: 14,
                                                fontWeight: selectedTab ==
                                                        TabBars.Schedule
                                                    ? FontWeight.bold
                                                    : FontWeight.w400,
                                                color: HexColor.fromHex(
                                                    '#f1c452')),
                                      ),
                                      Container(
                                        height: 9,
                                        width: 9,
                                        decoration: BoxDecoration(
                                            color: selectedTab ==
                                                    TabBars.Schedule
                                                ? HexColor.fromHex('#f1c452')
                                                : Colors.transparent,
                                            shape: BoxShape.circle),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      )),
                  if (selectedTab == TabBars.Menu ||
                      selectedTab == TabBars.Details) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsetsDirectional.only(
                              start: 25, end: 25, bottom: 15, top: 15),
                          decoration: BoxDecoration(
                              color: HexColor.fromHex("#8ea659"),
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(40))),
                          child: GeneralText(
                            Strings.appCurrency +
                                "." +
                                " " +
                                Strings.foodProductItemPrice,
                            style: appTheme
                                .typographies.interFontFamily.headline4
                                .copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor.fromHex('#ffffff')),
                          ),
                        ),
                      ],
                    ),
                  ]
                ],
              ),
            ),
          ),
          // if (selectedTab != TabBars.Details)
          const Positioned.fill(
            top: 105,
            child: Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 32,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage("assets/images/icons/user_image.png"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget menuTabView(BuildContext context, IAppThemeData appTheme) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 12),
      child: Container(
          padding: const EdgeInsetsDirectional.only(
              start: 9.9, end: 18.3, bottom: 93),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: HexColor.fromHex('#f1c452'))),
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsetsDirectional.all(16),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/icons/food_item_circle.png'),
                                  fit: BoxFit.fill,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                'assets/images/icons/food_item_sample.png',
                                height: 50,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 7.7,
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    getFoodItemTitle(appTheme: appTheme),
                                    getFoodItemAmount(appTheme: appTheme),
                                  ],
                                ),
                                getFoodItemSubTitle(appTheme: appTheme),
                                getFoodItemDescription(appTheme: appTheme),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                Resources.userIcon,
                                height: 15,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              getFoodItemUsers(appTheme: appTheme),
                            ],
                          ),
                          Stack(
                            children: [
                              Row(
                                children: [
                                  getFoodItemQuantityLabel(appTheme: appTheme),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      removeQuantity();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: HexColor.fromHex("#f7dc99"),
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(8),
                                            topLeft: Radius.circular(8)),
                                      ),
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 8, end: 8, top: 6, bottom: 6),
                                      child: const Icon(Icons.remove,
                                          color: Colors.black, size: 18),
                                    ),
                                  ),
                                  const SizedBox(
                                    width:44,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      addQuantity();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: HexColor.fromHex("#f7dc99"),
                                        borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            bottomRight: Radius.circular(8)),
                                      ),
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 8, end: 8, top: 6, bottom: 6),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Positioned.fill(
                                left: 60,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8)),
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 21, end: 21, top: 5, bottom: 5),
                                      child: getFoodItemQuantityValue(
                                          appTheme: appTheme)),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 23,
                      ),
                      Divider(
                        color: HexColor.fromHex('#f1c452'),
                        thickness: 1,
                      )
                    ]);
              })),
    );
  }

  Widget getFoodItemHeading({required IAppThemeData appTheme}) {
    return GeneralText(
      Strings.foodDetailHeading,
      textAlign: TextAlign.center,
      style: appTheme.typographies.interFontFamily.headline5
          .copyWith(color: HexColor.fromHex('#f1c452')),
    );
  }

  Widget getFoodItemTitle({required IAppThemeData appTheme}) {
    return GeneralText(
      Strings.foodProductTitle,
      style: appTheme.typographies.interFontFamily.headline6
          .copyWith(fontSize: 15, color: HexColor.fromHex('#f7dc99')),
    );
  }

  Widget getFoodItemSubTitle({required IAppThemeData appTheme}) {
    return GeneralText(
      Strings.foodProductSubTitle,
      style: appTheme.typographies.interFontFamily.headline6
          .copyWith(fontSize: 15, color: HexColor.fromHex('#b0c18b')),
    );
  }

  Widget getFoodItemAmount({required IAppThemeData appTheme}) {
    return GeneralText(
      Strings.appCurrency + "." + Strings.foodProductItemPrice,
      style: appTheme.typographies.interFontFamily.headline6.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: HexColor.fromHex('#f1c452')),
    );
  }

  Widget getFoodItemDescription({required IAppThemeData appTheme}) {
    return GeneralText(
      Strings.foodProductItemDescription,
      maxLines: 3,
      textAlign: TextAlign.start,
      style: appTheme.typographies.interFontFamily.headline6
          .copyWith(fontSize: 14, color: HexColor.fromHex('#ffffff')),
    );
  }

  Widget getFoodItemUsers({required IAppThemeData appTheme}) {
    return GeneralText(
      Strings.foodProductItemUsers,
      style: appTheme.typographies.interFontFamily.headline6
          .copyWith(fontSize: 16, color: HexColor.fromHex('#ffffff')),
    );
  }

  Widget getFoodItemQuantityLabel({required IAppThemeData appTheme}) {
    return GeneralText(
      Strings.foodProductItemQuantity + ":",
      style: appTheme.typographies.interFontFamily.headline6.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: HexColor.fromHex('#f1c452'),
      ),
    );
  }

  Widget getFoodItemQuantityValue({required IAppThemeData appTheme}) {
    return GeneralText(
      (foodItemQuantity <= 9 && foodItemQuantity > 0)
          ? "0" + foodItemQuantity.toString()
          : foodItemQuantity.toString(),
      style: appTheme.typographies.interFontFamily.headline6.copyWith(
          fontSize: 15,
          color: foodItemQuantity.toString() == "0"
              ? HexColor.fromHex('#212129').withOpacity(0.4)
              : HexColor.fromHex('#212129')),
    );
  }

  Widget getStartedButtonTitle({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      width: 151,
      title: Strings.nextButtonTitle.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserProfile()),
        );
      },
    );
    // ExtoText(
    //   Strings.getStartedButtonTitle,
    //   style: appTheme.typographies.interFontFamily.headline2,
    // );
  }

  Widget getFoodMainHeading({required IAppThemeData appTheme}) {
    return GeneralText(Strings.foodItemMainHeading,
        textAlign: TextAlign.center,
        style: appTheme.typographies.interFontFamily.headline6.copyWith(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24));
  }

  ///Schedule tab view
  Widget scheduleTabView(BuildContext context, IAppThemeData appTheme) {
    return scheduleForm
        ? Padding(
            padding: EdgeInsetsDirectional.only(start: 20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // GeneralRichText(title: 'Oct\n 13'),
                          GeneralText(
                            selectedMonth,
                            // style: appTheme
                            //     .typographies.interFontFamily.headline6
                            //     .copyWith(
                            //         color: HexColor.fromHex('#f1c452'),
                            //         fontSize: 14,
                            //         //  height: 0,
                            //         fontWeight: FontWeight.w800),
                            style:
                                appTheme.typographies.interFontFamily.label11,
                          ),
                          GeneralText(
                            selectedDate,
                            // style: appTheme
                            //     .typographies.interFontFamily.headline6
                            //     .copyWith(
                            //         color: HexColor.fromHex('#909094'),
                            //         fontSize: 40,
                            //         fontWeight: FontWeight.w500),

                            style:
                                appTheme.typographies.interFontFamily.label12,
                          )
                        ]),
                    SizedBox(
                      width: 27,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                              width: double.infinity,
                              padding: EdgeInsetsDirectional.only(
                                  start: 14, top: 15, bottom: 15, end: 25),
                              decoration: BoxDecoration(
                                  color: HexColor.fromHex('#2b2b33'),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GeneralText(selectedTime,
                                      style: appTheme.typographies
                                          .interFontFamily.headline6
                                          .copyWith(
                                              color:
                                                  HexColor.fromHex('#b0c18b'),
                                              fontSize: 36,
                                              fontWeight: FontWeight.normal)),
                                  GeneralText(selectedDay,
                                      style: appTheme.typographies
                                          .interFontFamily.headline6
                                          .copyWith(
                                              color:
                                                  HexColor.fromHex('#909094'),
                                              fontSize: 36,
                                              fontWeight: FontWeight.normal)),
                                ],
                              )),
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                              width: double.infinity,
                              padding: EdgeInsetsDirectional.only(
                                  start: 14, top: 15, bottom: 15, end: 25),
                              decoration: BoxDecoration(
                                  color: HexColor.fromHex('#2b2b33'),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20))),
                              child: Wrap(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GeneralText(Strings.noOfPersonsLabel,
                                          style: appTheme.typographies
                                              .interFontFamily.headline6
                                              .copyWith(
                                                  color: HexColor.fromHex(
                                                      '#fee4a4'),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700)),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 61,
                                            height: 51,
                                            decoration: BoxDecoration(
                                                color:
                                                    HexColor.fromHex('#2b2b33'),
                                                border: Border.all(
                                                    color: HexColor.fromHex(
                                                        '#f1c452')),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            // padding: EdgeInsetsDirectional.only(
                                            //     top: 8, bottom: 8, start: 16, end: 16),
                                            margin: EdgeInsetsDirectional.only(
                                                bottom: 8),
                                            child: noOfPersonsField(
                                              appTheme: appTheme,
                                              valueStyle: appTheme.typographies
                                                  .interFontFamily.body1
                                                  .copyWith(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              hintStyle: appTheme.typographies
                                                  .interFontFamily.body1
                                                  .copyWith(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.8,
                                            height: 51,
                                            decoration: BoxDecoration(
                                                color:
                                                    HexColor.fromHex('#2b2b33'),
                                                border: Border.all(
                                                    color: HexColor.fromHex(
                                                        '#f1c452')),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            margin: EdgeInsetsDirectional.only(
                                                bottom: 8),
                                            padding: EdgeInsetsDirectional.only(
                                                top: 8,
                                                bottom: 8,
                                                start: 8,
                                                end: 8),
                                            child: /*ExtoDropdown(
                                        name: _wfActions.first ?? "",
                                        items: _wfActions,
                                        // isMandatory: true,
                                        onChange: ({required key, value}) {},
                                      ),*/
                                                GeneralDropdown(
                                              borderColor: Colors.transparent,
                                              name: 'Select',
                                              //     dropDownHeight: 51.0,

                                              // borderColor: appTheme.colors.textFieldBorderColor,
                                              style: appTheme.typographies
                                                  .interFontFamily.headline6
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400),
                                              // margin: 22.0,
                                              items: items,
                                              onChange: ({
                                                required String key,
                                                required dynamic value,
                                              }) {},
                                            ),
                                            /*GeneralDropdown(
                                          borderColor: Colors.transparent,
                                          name: 'Select',
                                          // margin: 22.0,
                                          items: statusList,
                                          onChange: ({
                                            required String key,
                                            required dynamic value,
                                          }) {
                                          },
                                        )*/
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                              width: double.infinity,
                              padding: EdgeInsetsDirectional.only(
                                  start: 14, top: 15, bottom: 15, end: 25),
                              decoration: BoxDecoration(
                                  color: HexColor.fromHex('#2b2b33'),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20))),
                              child: Wrap(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GeneralText(Strings.notesLabel,
                                          style: appTheme.typographies
                                              .interFontFamily.headline6
                                              .copyWith(
                                                  color: HexColor.fromHex(
                                                      '#fee4a4'),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700)),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      Container(
                                        // width: 61,
                                        decoration: BoxDecoration(
                                            color: HexColor.fromHex('#2b2b33'),
                                            border: Border.all(
                                                color: HexColor.fromHex(
                                                    '#f1c452')),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        // padding: EdgeInsetsDirectional.only(
                                        //     top: 8, bottom: 8, start: 16, end: 16),
                                        margin: EdgeInsetsDirectional.only(
                                            bottom: 8),
                                        child: notesField(
                                          appTheme: appTheme,
                                          valueStyle: appTheme.typographies
                                              .interFontFamily.body1
                                              .copyWith(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          hintStyle: appTheme.typographies
                                              .interFontFamily.body1
                                              .copyWith(
                                            color:
                                                Colors.white.withOpacity(0.4),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 160,
                ),
              ],
            ),
          )
        : Stack(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(start: 20, bottom: 50),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                scheduleForm = !scheduleForm;
                              });
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(children: [
                                  GeneralText(selectedDay.toUpperCase(),
                                      style: appTheme.typographies
                                          .interFontFamily.headline6
                                          .copyWith(
                                              color:
                                                  HexColor.fromHex('#f1c452'),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700)),
                                  GeneralText(selectedDate,
                                      style: appTheme.typographies
                                          .interFontFamily.headline2
                                          .copyWith(
                                        color: HexColor.fromHex('#909094'),
                                        fontSize: 40,
                                      ))
                                ]),
                                SizedBox(
                                  width: 27,
                                ),
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(
                                        left: 8, top: 10, bottom: 10),
                                    decoration: BoxDecoration(
                                        color: HexColor.fromHex('#2b2b33'),
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20))),
                                    child: Wrap(children: [
                                      timeSelectorBox(appTheme,
                                          showSelectedTime: true),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      timeSelectorBox(appTheme,
                                          showSelectedTime: false),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      timeSelectorBox(appTheme,
                                          showSelectedTime: false),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      timeSelectorBox(appTheme,
                                          showSelectedTime: false),
                                      SizedBox(
                                        width: 7,
                                      ),
                                    ]),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 27,
                          ),
                        ],
                      );
                    }),
              ),
              Positioned.fill(
                right: 20,
                bottom: 40,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    elevation: 6,
                    onPressed: () {
                      selectStartDate(context, appTheme);
                    },
                    child: Image.asset(
                      Resources.calendarPNG,
                      height: 23,
                    ),
                    backgroundColor: appTheme.colors.filledButtonColor,
                  ),
                ),
              ),
            ],
          );
  }

  Future<void> selectStartDate(
      BuildContext context, IAppThemeData appTheme) async {
    final DateTime? picked = await showDatePicker(
      context: context,

      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
                primary: appTheme.colors.primaryBackground // <-- SEE HERE

                ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      //lastDate: DateTime(2101),
      lastDate: DateTime.now(),
    );
  }

  Widget scheduleTabViewForm(BuildContext context, IAppThemeData appTheme) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(children: [
                GeneralText(selectedMonth,
                    style: appTheme.typographies.interFontFamily.headline6
                        .copyWith(
                            color: HexColor.fromHex('#f1c452'),
                            fontSize: 14,
                            fontWeight: FontWeight.w700)),
                GeneralText(selectedDate,
                    style: appTheme.typographies.interFontFamily.headline6
                        .copyWith(
                            color: HexColor.fromHex('#909094'),
                            fontSize: 40,
                            fontWeight: FontWeight.w700))
              ]),
              SizedBox(
                width: 27,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.only(
                            start: 14, top: 15, bottom: 15, end: 25),
                        decoration: BoxDecoration(
                            color: HexColor.fromHex('#2b2b33'),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GeneralText(selectedTime,
                                style: appTheme
                                    .typographies.interFontFamily.headline6
                                    .copyWith(
                                        color: HexColor.fromHex('#b0c18b'),
                                        fontSize: 36,
                                        fontWeight: FontWeight.w200)),
                            GeneralText(selectedDay,
                                style: appTheme
                                    .typographies.interFontFamily.headline6
                                    .copyWith(
                                        color: HexColor.fromHex('#909094'),
                                        fontSize: 36,
                                        fontWeight: FontWeight.w200)),
                          ],
                        )),
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.only(
                            start: 14, top: 15, bottom: 15, end: 25),
                        decoration: BoxDecoration(
                            color: HexColor.fromHex('#2b2b33'),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20))),
                        child: Wrap(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GeneralText(Strings.noOfPersonsLabel,
                                    style: appTheme
                                        .typographies.interFontFamily.headline6
                                        .copyWith(
                                            color: HexColor.fromHex('#fee4a4'),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                SizedBox(
                                  height: 9,
                                ),
                                Wrap(
                                  children: [
                                    Container(
                                      width: 61,
                                      decoration: BoxDecoration(
                                          color: HexColor.fromHex('#2b2b33'),
                                          border: Border.all(
                                              color:
                                                  HexColor.fromHex('#f1c452')),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      // padding: EdgeInsetsDirectional.only(
                                      //     top: 8, bottom: 8, start: 16, end: 16),
                                      margin:
                                          EdgeInsetsDirectional.only(bottom: 8),
                                      child: noOfPersonsField(
                                        appTheme: appTheme,
                                        valueStyle: appTheme
                                            .typographies.interFontFamily.body1
                                            .copyWith(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        hintStyle: appTheme
                                            .typographies.interFontFamily.body1
                                            .copyWith(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.8,
                                      decoration: BoxDecoration(
                                          color: HexColor.fromHex('#2b2b33'),
                                          border: Border.all(
                                              color:
                                                  HexColor.fromHex('#f1c452')),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin:
                                          EdgeInsetsDirectional.only(bottom: 8),
                                      padding: EdgeInsetsDirectional.only(
                                          top: 8, bottom: 8, start: 8, end: 8),
                                      child: /*ExtoDropdown(
                                        name: _wfActions.first ?? "",
                                        items: _wfActions,
                                        // isMandatory: true,
                                        onChange: ({required key, value}) {},
                                      ),*/
                                          GeneralDropdown(
                                        borderColor: Colors.transparent,
                                        name: 'Select',
                                        // margin: 22.0,
                                        items: items,
                                        onChange: ({
                                          required String key,
                                          required dynamic value,
                                        }) {},
                                      ),
                                      /*GeneralDropdown(
                                          borderColor: Colors.transparent,
                                          name: 'Select',
                                          // margin: 22.0,
                                          items: statusList,
                                          onChange: ({
                                            required String key,
                                            required dynamic value,
                                          }) {
                                          },
                                        )*/
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 14,
                    ),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.only(
                            start: 14, top: 15, bottom: 15, end: 25),
                        decoration: BoxDecoration(
                            color: HexColor.fromHex('#2b2b33'),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20))),
                        child: Wrap(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GeneralText(Strings.notesLabel,
                                    style: appTheme
                                        .typographies.interFontFamily.headline6
                                        .copyWith(
                                            color: HexColor.fromHex('#fee4a4'),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700)),
                                SizedBox(
                                  height: 9,
                                ),
                                Container(
                                  // width: 61,
                                  decoration: BoxDecoration(
                                      color: HexColor.fromHex('#2b2b33'),
                                      border: Border.all(
                                          color: HexColor.fromHex('#f1c452')),
                                      borderRadius: BorderRadius.circular(10)),
                                  // padding: EdgeInsetsDirectional.only(
                                  //     top: 8, bottom: 8, start: 16, end: 16),
                                  margin: EdgeInsetsDirectional.only(bottom: 8),
                                  child: notesField(
                                    appTheme: appTheme,
                                    valueStyle: appTheme
                                        .typographies.interFontFamily.body1
                                        .copyWith(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    hintStyle: appTheme
                                        .typographies.interFontFamily.body1
                                        .copyWith(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 27,
          ),
        ],
      ),
    );
  }

  Widget detailsTabViewForm(BuildContext context, IAppThemeData appTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              color: HexColor.fromHex('#f1c452'),
              width: 16,
              height: 1,
            ),
            const SizedBox(
              width: 5,
            ),
            GeneralText(
              Strings.foodDetailAboutTitle,
              style: appTheme.typographies.interFontFamily.headline6.copyWith(
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
            Strings.productDetailAboutSubTitle,
            style: appTheme.typographies.interFontFamily.headline6.copyWith(
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
              width: 5,
            ),
            GeneralText(
              Strings.productDetailWowFactorTitle,
              style: appTheme.typographies.interFontFamily.headline6.copyWith(
                fontSize: 20,
                color: HexColor.fromHex('#f1c452'),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 28,
        ),
        wowFactors(appTheme, wowFactorsList),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Container(
              color: HexColor.fromHex('#f1c452'),
              width: 16,
              height: 1,
            ),
            const SizedBox(
              width: 5,
            ),
            GeneralText(
              Strings.foodDetailPreferences,
              style: appTheme.typographies.interFontFamily.headline6.copyWith(
                fontSize: 20,
                color: HexColor.fromHex('#f1c452'),
              ),
            ),
            Spacer(),
            Image.asset(
              Resources.userIconPNG,
              height: 12,
            ),
            GeneralText(
              '22',
              style: appTheme.typographies.interFontFamily.headline6.copyWith(
                fontSize: 16,
                color: HexColor.fromHex('#f1c452'),
              ),
            ),
            SizedBox(
              width: 12,
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        wowFactors(appTheme, preferencesList),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Container(
              color: HexColor.fromHex('#f1c452'),
              width: 16,
              height: 1,
            ),
            const SizedBox(
              width: 5,
            ),
            GeneralText(
              Strings.foodDetailLocation,
              style: appTheme.typographies.interFontFamily.headline6.copyWith(
                fontSize: 20,
                color: HexColor.fromHex('#f1c452'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget wowFactors(IAppThemeData appTheme, List<CustomModel> items) {
    return Wrap(
      children: [
        for (int i = 0; i < items.length; i++)
          Padding(
            padding: const EdgeInsets.only(right: 17, bottom: 7.7),
            child: Column(
              children: [
                Container(
                  width: 58,
                  padding: const EdgeInsetsDirectional.all(10),
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(
                          'assets/images/icons/food_item_circle.png'),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    height: 50,
                    padding: const EdgeInsetsDirectional.all(10),
                    decoration: BoxDecoration(
                      color: HexColor.fromHex("#f1c452"),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                        items[i].name != null ? items[i].name ?? "" : ''),
                  ),
                ),
                GeneralText(
                  items[i].icon ?? "",
                  style:
                      appTheme.typographies.interFontFamily.headline6.copyWith(
                    fontSize: 14,
                    color: HexColor.fromHex('#ffffff'),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget timeSelectorBox(IAppThemeData appTheme,
      {bool showSelectedTime = false}) {
    return Container(
      // width: 71,
      // height: 36,
      child: GeneralText(selectedTime,
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
              color: showSelectedTime
                  ? HexColor.fromHex('#212129')
                  : HexColor.fromHex('#f1c452'),
              fontSize: 14)),
      decoration: BoxDecoration(
          border: Border.all(color: HexColor.fromHex('#f1c452')),
          color: showSelectedTime
              ? HexColor.fromHex('#f1c452')
              : HexColor.fromHex('#2b2b33'),
          borderRadius: BorderRadius.circular(10)),
      padding:
          EdgeInsetsDirectional.only(top: 8, bottom: 8, start: 16, end: 16),
      margin: EdgeInsetsDirectional.only(bottom: 8),
    );
  }

  Widget noOfPersonsField({
    required IAppThemeData appTheme,
    required TextStyle valueStyle,
    required TextStyle hintStyle,
  }) {
    return GeneralTextInput(
      contentPadding:
          EdgeInsetsDirectional.only(top: 8, bottom: 8, start: 16, end: 16),
      controller: nOfPersons,
      hint: Strings.noOfPersonsHint,
      valueStyle: valueStyle,
      hintStyle: hintStyle,
      validator: (_) {
        return null;
      },
      onChanged: (newValue) {
        setState(() {
          nOfPersons.text = newValue;
        });
      },
    );
  }

  Widget notesField({
    required IAppThemeData appTheme,
    required TextStyle valueStyle,
    required TextStyle hintStyle,
  }) {
    return GeneralTextInput(
      isMultiline: true,
      contentPadding:
          EdgeInsetsDirectional.only(top: 8, bottom: 8, start: 16, end: 16),
      controller: notes,
      hint: Strings.notesHint,
      valueStyle: valueStyle,
      hintStyle: hintStyle,
      validator: (_) {
        return null;
      },
      onChanged: (newValue) {
        setState(() {
          notes.text = newValue;
        });
      },
    );
  }
}

class CustomModel {
  String? name;
  String? icon;

  CustomModel({this.name, this.icon});
}
