import 'package:chef/constants/constants.dart';
import 'package:chef/ui_kit/general_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../constants/strings.dart';
import '../../helpers/color_helper.dart';
import '../../theme/app_theme_data/app_theme_data.dart';
import '../../theme/app_theme_widget.dart';

enum TabBars { Details, Menu, Schedule }

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({Key? key}) : super(key: key);

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int foodItemQuantity = 0;

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
      floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: getStartedButtonTitle(appTheme: appTheme)),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  Container(
                    child: Image.asset('assets/images/icons/food_detail_bg.png',
                        fit: BoxFit.fill),
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.only(start: 24),
                    color: HexColor.fromHex('#212129'),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 60,
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
                            getFoodItemHeading(appTheme: appTheme),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        if (selectedTab == TabBars.Details)
                          menuTabView(context, appTheme),
                        if (selectedTab == TabBars.Menu)
                          menuTabView(context, appTheme),
                        if (selectedTab == TabBars.Schedule)
                          menuTabView(context, appTheme)
                      ],
                    ),
                  ),
                ],
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
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                    end: 14, top: 30),
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
                                                        color: HexColor.fromHex(
                                                            '#f1c452')),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 9,
                                                width: 9,
                                                decoration: BoxDecoration(
                                                    color: selectedTab ==
                                                            TabBars.Details
                                                        ? HexColor.fromHex(
                                                            '#f1c452')
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
                                                        color: HexColor.fromHex(
                                                            '#f1c452')),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              if (selectedTab == TabBars.Menu)
                                                Container(
                                                  height: 9,
                                                  width: 9,
                                                  decoration: BoxDecoration(
                                                      color: HexColor.fromHex(
                                                          '#f1c452'),
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
                                                        color: HexColor.fromHex(
                                                            '#f1c452')),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              if (selectedTab ==
                                                  TabBars.Schedule)
                                                Container(
                                                  height: 9,
                                                  width: 9,
                                                  decoration: BoxDecoration(
                                                      color: HexColor.fromHex(
                                                          '#f1c452'),
                                                      shape: BoxShape.circle),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                              ),
                              Positioned.fill(
                                bottom: 32,
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 32,
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                          "assets/images/icons/user_image.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Widget menuTabView(BuildContext context, IAppThemeData appTheme) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 12),
      child: Container(
          padding: const EdgeInsetsDirectional.only(
              start: 9.9, end: 18.3, bottom: 23),
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
                              padding: const EdgeInsetsDirectional.all(10),
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
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8)),
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 21, end: 21, top: 5, bottom: 5),
                                  child: getFoodItemQuantityValue(
                                      appTheme: appTheme)),
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
      style: appTheme.typographies.interFontFamily.headline6
          .copyWith(fontSize: 12, color: HexColor.fromHex('#f1c452')),
    );
  }

  Widget getFoodItemQuantityValue({required IAppThemeData appTheme}) {
    return GeneralText(
      (foodItemQuantity <= 9 && foodItemQuantity > 0)
          ? "0" + foodItemQuantity.toString()
          : foodItemQuantity.toString(),
      style: appTheme.typographies.interFontFamily.headline6
          .copyWith(fontSize: 15, color: HexColor.fromHex('#212129')),
    );
  }

  Widget getStartedButtonTitle({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      title: Strings.nextButtonTitle.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {},
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
}
