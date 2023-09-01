import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chef/helpers/helpers.dart';
import 'package:chef/screens/home/schedule_model.dart';
import 'package:chef/screens/user_account/user_profile.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../../constants/temporary_data.dart';
import '../../../models/food_details_screen/slider_images_response.dart';
import '../../../models/home/chef_data_response.dart';
import '../../../models/home/home_response.dart' as home_data;
import '../../food_product_experience_details/food_product_details_screen_v.dart';
import '/helpers/color_helper.dart';
import '/helpers/order_helper.dart';
import '/setup.dart';
import '/ui_kit/widgets/general_new_appbar.dart';
import '../component/food_detail_screen_vm.dart';
import '../food_details_menu_model.dart';
import '../food_details_menu_model.dart' as menu;
import '/models/home/experience_list_response.dart' as experience_data;
import 'dart:developer' as developer;

enum TabBars { Details, Menu, Schedule }

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({
    Key? key,
    required this.data,
    required this.foodMenuDetail,
    required this.scheduleModel,
    required this.chefData,

    ///required this.preferences,
  }) : super(key: key);
  final home_data.Experiences? data;
  final FoodMenuModel foodMenuDetail;
  final ScheduleModel scheduleModel;
  final ChefDataResponse chefData;
  //final PerferenceResponse preferences;

  @override
  _FoodDetailScreenState createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  List<int> foodItemQuantity = [];
  String selectedDate = "";
  String selectedDay = "";
  String selectedMonth = "";
  String selectedTime = "";
  int openCapacity = 99;
  final TextController nOfPersons = TextController();
  final TextController notes = TextController();
  late List<DropdownMenuItem<String>> statusList = [];
  // late List<DropdownMenuItem<String>> items = [];

  final items = <String>[];
  final preferenceIds = <int>[];

  bool scheduleForm = false;

  List<CustomModel> wowFactorsList = [];
  List<CustomModel> preferencesList = [];
  List<CustomModel> menuListItems = [];
  List<dynamic> headers = [];
  final foodDetailsViewModel = locateService<FoodDetailScreenViewModel>();
  final _appService = locateService<ApplicationService>();
  List months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  var darkMapStyle;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  bool isButtonEnable = true;

  @override
  void initState() {
    developer.log(' Price Id is }');
    headers = widget.foodMenuDetail.t
        .map((element) => element.mealName)
        .toSet()
        .toList();

    widget.data?.experiencePreferences?.forEach((element) {
      items.add(element.preferenceName.toString());
      preferenceIds.add(int.parse(element.id.toString()));
    });

   // items.add('Couple');
   // items.add('Single');
  //  items.add('Family');

    nOfPersons.text = '0';
    if (_appService.state.orderHelper != null) {
      _appService.state.orderHelper!.selectedCategory = items.first;
      _appService.state.orderHelper!.noteAdded = '';
      _appService.state.orderHelper!.scheduleId = 0.toString();

      _appService.state.orderHelper!.daysGroup = DaysGroup(
          scheduledDate: DateTime(1900 - 12 - 12), dayOfMonth: 0, hours: []);
    } else {
      OrderHelper orderHelper = OrderHelper();
      orderHelper.selectedCategory = items.first;
      orderHelper.noteAdded = '';
      orderHelper.scheduleId = 0.toString();
      orderHelper.daysGroup = DaysGroup(
          scheduledDate: DateTime(1900 - 12 - 12), dayOfMonth: 0, hours: []);
      _appService.updateOrderHelper(orderHelper);
    }

    loadWowFactor();
    loadPerferences();
    _loadMapStyles();
    super.initState();
  }

  Future _loadMapStyles() async {
    darkMapStyle =
        await rootBundle.loadString('assets/json/dark_mode_style.json');
  }

  void loadWowFactor() {
    developer.log(' Wow factors are ' + '${widget.data?.experienceWowFactors}');
    var experienceWowFactor = widget.data?.experienceWowFactors;

    for (int i = 0; i < experienceWowFactor!.length; i++) {
      wowFactorsList.addAll([
        CustomModel(
            icon: experienceWowFactor[i].wowFactorName,
            name: experienceWowFactor[i].wowFactorIconPath),
      ]);
    }
  }

  void loadPerferences() {
    developer.log(' loadPerferences factors are ' +
        '${widget.data?.experiencePreferences}');
    var experiencePreferences = widget.data?.experiencePreferences;

    for (int i = 0; i < experiencePreferences!.length; i++) {
      preferencesList.addAll([
        CustomModel(
            icon: experiencePreferences[i].preferenceName,
            name: experiencePreferences[i].preferenceIconPath),
      ]);
    }
  }

  addQuantity(int itemPrice, int index) {
    if (foodItemQuantity[index] != null &&
        foodItemQuantity[index].toString().isNotEmpty) {
      setState(() {
        foodItemQuantity[index]++;
        widget.data?.price = widget.data!.price! + itemPrice;
      });
    }
  }

  removeQuantity(int itemPrice, int index) {
    if (foodItemQuantity[index] != null && foodItemQuantity[index] > 0) {
      setState(() {
        foodItemQuantity[index]--;
        widget.data?.price = widget.data!.price! - itemPrice;
      });
    }
  }

  TabBars selectedTab = TabBars.Details;

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
    //SliderImagesResponse imagesData = getImagesList();
    return Scaffold(
      backgroundColor: HexColor.fromHex('#212129'),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: experienceNextButton(),
      body: Stack(
        children: [
          Column(
            children: [
              FutureBuilder<SliderImagesResponse?>(
                  future: foodDetailsViewModel.getSliderImages(
                      experienceId: widget.data!.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var imagesList = snapshot.data?.t;
                      List images = [];
                      for (var item in imagesList!) {
                        images.add(item.mediaUrl);
                      }
                      return CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                        ),
                        items: (images.isEmpty ? foodDetailsBgImages : images)
                            .map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Image.network('${Api.baseURLForImages}$i',
                                  fit: BoxFit.fill);
                            },
                          );
                        }).toList(),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsetsDirectional.only(
                      start: DeviceHelper.width * 0.10,
                    ),
                    color: HexColor.fromHex('#212129'),
                    child: Column(
                      children: [
                        if (selectedTab != TabBars.Schedule)
                          SizedBox(
                            height: DeviceHelper.height * 0.10,
                          ),
                        if (selectedTab == TabBars.Schedule)
                          SizedBox(
                            height: DeviceHelper.height * 0.05,
                          ),
                        if (selectedTab == TabBars.Menu)
                          SizedBox(
                            height: DeviceHelper.height * 0.01,
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
          Positioned.fill(
            top: DeviceHelper.height * 0.10,
            left: DeviceHelper.width * 0.05,
            child: Align(
                alignment: Alignment.topLeft, child: GeneralNewAppBar(
              callBack: (){
                setState(() {
                  selectedTab == TabBars.Details
                      ? Navigator.pop(context)
                      : (selectedTab == TabBars.Menu
                      ? setTab(TabBars.Details)
                      : scheduleForm
                      ? scheduleForm = false
                      : setTab(TabBars.Menu));
                });
              },
            )),
          ),
          Positioned(
              top: DeviceHelper.height * 0.19,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                    start: DeviceHelper.width * 0.07),
                child: Column(children: [
                  Container(
                      decoration: BoxDecoration(
                        color: HexColor.fromHex("#4b4b52"),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            DeviceHelper.height * 0.03,
                          ),
                          bottomLeft: Radius.circular(
                            DeviceHelper.height * 0.03,
                          ),
                        ),
                      ),
                      height: DeviceHelper.height * 0.14,
                      padding: const EdgeInsetsDirectional.only(bottom: 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                            top: DeviceHelper.height * 0.025),
                        child: Column(children: [
                          getFoodMainHeading(
                              appTheme: appTheme, title: widget.data!.title),
                          SizedBox(
                            height: DeviceHelper.height * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: DeviceHelper.width * 0.10,
                                end: DeviceHelper.width * 0.10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        height: DeviceHelper.height * 0.012,
                                        width: DeviceHelper.height * 0.012,
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
                                                fontWeight:
                                                    selectedTab == TabBars.Menu
                                                        ? FontWeight.bold
                                                        : FontWeight.w400,
                                                color: HexColor.fromHex(
                                                    '#f1c452')),
                                      ),
                                      Container(
                                        height: DeviceHelper.height * 0.012,
                                        width: DeviceHelper.height * 0.012,
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
                                        height: DeviceHelper.height * 0.012,
                                        width: DeviceHelper.height * 0.012,
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
                    displayPriceOption(),
                  ]
                  //),
                ]),
              )),
          // if (selectedTab != TabBars.Details)
          ///chef image
          Positioned.fill(
            top: DeviceHelper.height * 0.14,
            right: DeviceHelper.width * 0.02,
            child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: DeviceHelper.width * 0.09,
                  child: CircleAvatar(
                    radius: DeviceHelper.width * 0.085,
                    backgroundImage: NetworkImage(Api.baseURLForImages +
                        widget.chefData.t!.profileImageUrl.toString()),
                  ),
                ),
                onTap: () async {
                  // ChefDataResponse chefData = await foodDetailsViewModel.getChefData(
                  //     //widget.scheduleModel.t.chefId
                  //   1
                  // );
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          UserProfile(chefData: widget.chefData)));
                },
              ),
            ),
          ),
          // if (selectedTab == TabBars.Schedule)
          //   Positioned.fill(
          //     right: 20,
          //     bottom: 60,
          //     child: Align(
          //       alignment: Alignment.bottomRight,
          //       child: FloatingActionButton(
          //         elevation: 6,
          //         onPressed: () {
          //           selectStartDate(context, appTheme);
          //         },
          //         child: Image.asset(
          //           Resources.calendarPNG,
          //           height: 23,
          //         ),
          //         backgroundColor: appTheme.colors.filledButtonColor,
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }

  Widget experienceNextButton() {
    return GeneralButton.button(
      width: DeviceHelper.width * 0.37,
      title: Strings.nextButtonTitle.toUpperCase(),
      //isEnable: (!scheduleForm && selectedTime == "") ? true : false,
      styleType: ButtonStyleType.fill,
      onTap: () {
        setState(() {
          if (!scheduleForm &&
              selectedTime == "" &&
              selectedTab == TabBars.Schedule) {
            Toaster.infoToast(
                context: context, message: 'Please Select Schedule Slot!');
          } else {
            selectedTab == TabBars.Details
                ? setTab(TabBars.Menu)
                : (selectedTab == TabBars.Menu
                    ? setTab(TabBars.Schedule)
                    : scheduleForm
                        ? goToRequestToBookScreen()
                        : setScheduleFormValue());
          }
        });
      },
    );
  }

  void setTab(var a) {
    selectedTab = a;
  }

  void goToRequestToBookScreen() {
    if(int.parse(nOfPersons.text) <= 0 || int.parse(nOfPersons.text) > openCapacity){
      Toaster.infoToast(context: context, message: 'Number of Persons must between 1 and $openCapacity');
    }
    else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              FoodProductExperienceDetailsScreenView(
                selectedExperienceId: widget.data!.id.toString(),
                experienceData: widget.data!,
                foodMenuDetail: widget.foodMenuDetail,
                chefData: widget.chefData,
              ),
        ),
      );
    }
  }

  void setScheduleFormValue() {
    scheduleForm = true;
  }

  Widget displayPriceOption() {
    final appTheme = AppTheme.of(context).theme;

    /// if (widget.data.priceTypeId == 2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsetsDirectional.only(
              start: 25, end: 25, bottom: 5, top: 5),
          decoration: BoxDecoration(
              color: HexColor.fromHex("#8ea659"),
              borderRadius:
                  const BorderRadius.only(bottomLeft: Radius.circular(40))),
          child: Column(
            children: [
              GeneralText(
                Strings.appCurrency + "." + " " + widget.data!.price.toString(),
                style: appTheme.typographies.interFontFamily.headline6.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: HexColor.fromHex('#ffffff')),
              ),
              widget.data!.priceTypeId == 1
                  ? GeneralText(
                      Strings.perPerson,
                      style: appTheme.typographies.interFontFamily.headline4
                          .copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: HexColor.fromHex('#ffffff')),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ],
    );
    // }
    // return Container();

    // ];
  }

  Widget menuTabView(BuildContext context, IAppThemeData appTheme) {
    return Padding(
        padding: const EdgeInsetsDirectional.only(end: 12),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: headers.length,
          itemBuilder: (BuildContext context, int index) {
            foodItemQuantity.add(0);
            List<menu.T> filteredList = widget.foodMenuDetail.t
                .where((element) => element.mealName == headers[index])
                .toList();
            return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///Meal Name Title Row
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
                      getFoodItemHeading(
                          appTheme: appTheme, mealTitle: headers[index]),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsetsDirectional.only(
                      start: 10,
                      end: 18.3,
                      bottom: 15,
                      top: 10,
                    ),
                    margin: const EdgeInsets.only(
                      bottom: 25,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: HexColor.fromHex('#f1c452'))),
                    child: Column(
                      children: [
                        for (int k = 0; k < filteredList.length; k++)
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      padding:
                                          const EdgeInsetsDirectional.all(16),
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/icons/food_item_circle.png'),
                                          fit: BoxFit.fill,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: NetworkImage(
                                          Api.baseURLForImages+filteredList[k].pictureUrl,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7.7,
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          top: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              getFoodItemTitle(
                                                  appTheme: appTheme,
                                                  foodItemTitle:
                                                      filteredList[k].dish),
                                              widget.data!.priceTypeId != 1
                                                  ? getFoodItemAmount(
                                                      appTheme: appTheme,
                                                      foodItemPrice:
                                                          filteredList[k]
                                                              .price
                                                              .toString(),
                                                      quantityIndex: index)
                                                  : Container(),
                                            ],
                                          ),
                                          getFoodItemSubTitle(
                                              appTheme: appTheme,
                                              subTitle:
                                                  filteredList[k].baseDishName),
                                          getFoodItemDescription(
                                              appTheme: appTheme,
                                              foodItemDescription:
                                                  filteredList[k].description),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              widget.data!.priceTypeId != 1
                                  ? displayQuantityData(
                                      widget.foodMenuDetail.t[index].price,
                                      index)
                                  : Container(),
                              const SizedBox(
                                height: 15,
                              ),
                              filteredList.length - 2 == k
                                  ? Divider(
                                      color: HexColor.fromHex('#f1c452'),
                                      thickness: 1,
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                      ],
                    ),
                  ),
                ]);
          },
        )
        // )
        );

    //);
  }

  Widget displayQuantityData(int price, int index) {
    final appTheme = AppTheme.of(context).theme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              Resources.userIconMenu,
              height: 15,
              color: foodItemQuantity[index] == 0
                  ? HexColor.fromHex('#909094')
                  : HexColor.fromHex('#ffffff'),
            ),
            const SizedBox(
              width: 4,
            ),
            getFoodItemUsers(appTheme: appTheme, index: index),
          ],
        ),
        displayQuantityDetails(price, index),
      ],
    );
  }

  Widget displayQuantityDetails(int itemPrice, int index) {
    final appTheme = AppTheme.of(context).theme;
    return Stack(
      children: [
        Row(
          children: [
            getFoodItemQuantityLabel(appTheme: appTheme),
            const SizedBox(
              width: 4,
            ),
            InkWell(
              onTap: () {
                removeQuantity(itemPrice, index);
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
                child: const Icon(Icons.remove, color: Colors.black, size: 18),
              ),
            ),
            const SizedBox(
              width: 44,
            ),
            InkWell(
              onTap: () {
                addQuantity(itemPrice, index);
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
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 18,
                ),
              ),
            )
          ],
        ),
        displayQuantityNumber(index),
      ],
    );
  }

  Widget displayQuantityNumber(int index) {
    final appTheme = AppTheme.of(context).theme;
    return Positioned.fill(
      left: 60,
      child: Align(
        alignment: Alignment.center,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsetsDirectional.only(
                start: 21, end: 21, top: 5, bottom: 5),
            child: getFoodItemQuantityValue(appTheme: appTheme, index: index)),
      ),
    );
  }


  Widget getFoodItemHeading(
      {required IAppThemeData appTheme, required mealTitle}) {
    return GeneralText(
      mealTitle,
      textAlign: TextAlign.center,
      style: appTheme.typographies.interFontFamily.headline4
          .copyWith(color: HexColor.fromHex('#f1c452')),
    );
  }

  Widget getFoodItemTitle(
      {required IAppThemeData appTheme, required String foodItemTitle}) {
    return GeneralText(
      //  Strings.foodProductTitle,
      foodItemTitle,
      style: appTheme.typographies.interFontFamily.headline6
          .copyWith(fontSize: 15, color: HexColor.fromHex('#f7dc99')),
    );
  }

  Widget getFoodItemSubTitle(
      {required IAppThemeData appTheme, required subTitle}) {
    return GeneralText(
      subTitle,
      style: appTheme.typographies.interFontFamily.headline6
          .copyWith(fontSize: 15, color: HexColor.fromHex('#b0c18b')),
    );
  }

  Widget getFoodItemAmount(
      {required IAppThemeData appTheme,
      required String foodItemPrice,
      required int quantityIndex}) {
    return GeneralText(
      //   Strings.appCurrency + "." + Strings.foodProductItemPrice,
      Strings.appCurrency + "." + foodItemPrice,
      style: appTheme.typographies.interFontFamily.headline6.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: foodItemQuantity[quantityIndex] == 0
            ? HexColor.fromHex('#909094')
            : HexColor.fromHex('#f1c452'),
      ),
    );
  }

  Widget getFoodItemDescription(
      {required IAppThemeData appTheme, required String foodItemDescription}) {
    return GeneralText(
      // Strings.foodProductItemDescription,
      foodItemDescription,
      maxLines: 3,
      textAlign: TextAlign.start,
      style: appTheme.typographies.interFontFamily.headline6
          .copyWith(fontSize: 14, color: HexColor.fromHex('#ffffff')),
    );
  }

  Widget getFoodItemUsers({required IAppThemeData appTheme, required index}) {
    return GeneralText(
      Strings.foodProductItemUsers,
      style: appTheme.typographies.interFontFamily.headline6.copyWith(
        fontSize: 16,
        color: foodItemQuantity[index] == 0
            ? HexColor.fromHex('#909094')
            : HexColor.fromHex('#ffffff'),
      ),
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

  Widget getFoodItemQuantityValue(
      {required IAppThemeData appTheme, required int index}) {
    return GeneralText(
      (foodItemQuantity[index] <= 9 && foodItemQuantity[index] > 0)
          ? "0" + foodItemQuantity[index].toString()
          : foodItemQuantity[index].toString(),
      style: appTheme.typographies.interFontFamily.headline6.copyWith(
          fontSize: 15,
          color: foodItemQuantity[index].toString() == "0"
              ? HexColor.fromHex('#212129').withOpacity(0.4)
              : HexColor.fromHex('#212129')),
    );
  }

  // Widget getStartedButtonTitle({required IAppThemeData appTheme}) {
  //   return GeneralButton.button(
  //     width: 151,
  //     title: Strings.nextButtonTitle.toUpperCase(),
  //     styleType: ButtonStyleType.fill,
  //     onTap: () {
  //       // Navigator.push(
  //       //   context,
  //       //   MaterialPageRoute(builder: (context) => UserProfile()),
  //       // );
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => FoodProductExperienceDetails()),
  //       );
  //     },
  //   );
  //   // ExtoText(
  //   //   Strings.getStartedButtonTitle,
  //   //   style: appTheme.typographies.interFontFamily.headline2,
  //   // );
  // }

  Widget getFoodMainHeading({required IAppThemeData appTheme, required title}) {
    return GeneralText(title,
        textAlign: TextAlign.center,
        style: appTheme.typographies.interFontFamily.headline6.copyWith(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24));
  }

  ///Schedule tab view
  Widget scheduleTabView(BuildContext context, IAppThemeData appTheme) {
    return scheduleForm

        ///for notes page code see this padding widget
        ? Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 20,
              top: 30,
            ),
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
                    const SizedBox(
                      width: 27,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsetsDirectional.only(
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

                                      // GeneralText(item.scheduledDate,
                                      style: appTheme.typographies
                                          .interFontFamily.headline6
                                          .copyWith(
                                              color:
                                                  HexColor.fromHex('#909094'),
                                              fontSize: 36,
                                              fontWeight: FontWeight.normal)),
                                ],
                              )),
                          const SizedBox(
                            height: 14,
                          ),
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsetsDirectional.only(
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
                                      const SizedBox(
                                        height: 9,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 58,
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
                                            margin: const EdgeInsetsDirectional
                                                .only(bottom: 8),
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
                                          const SizedBox(
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
                                            margin: const EdgeInsetsDirectional
                                                .only(bottom: 8),
                                            padding: const EdgeInsetsDirectional
                                                    .only(
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
                                                  selectedItemId: 1,
                                              borderColor: Colors.transparent,
                                              name: 'Select',
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
                                              }) {
                                                developer.log(
                                                    ' Selected value from Drop Down is ' +
                                                        '${value}');
                                                _appService.state.orderHelper!
                                                    .selectedCategory = value;
                                                widget.data?.experiencePreferences?.forEach((element) {
                                                  if(element.preferenceName == value)
                                                    {
                                                      _appService.state.orderHelper?.selectedPreferenceId = int.parse(element.preferenceId.toString());
                                                    }
                                                });
                                              },
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
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(Resources.peopleIconSvg, height: 12.5,color: HexColor.fromHex('#ea7458'),),
                                          const SizedBox(width: 4),
                                          GeneralText('MAX LIMIT : ',
                                              style: appTheme.typographies.interFontFamily.headline6.copyWith(
                                                  color: HexColor.fromHex('#ea7458'),
                                                  fontSize: 14)),
                                          GeneralText(openCapacity.toString(),
                                              style: appTheme.typographies.interFontFamily.headline6.copyWith(
                                                  color: HexColor.fromHex('#ea7458'),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          const SizedBox(
                            height: 14,
                          ),
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsetsDirectional.only(
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
                                      const SizedBox(
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
                                        margin:
                                            const EdgeInsetsDirectional.only(
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
                const SizedBox(
                  height: 160,
                ),
              ],
            ),
          )

        ///for select time slot see this stack widget
        : Stack(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 50),
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.scheduleModel.t.daysGroups?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      var item = widget.scheduleModel.t.daysGroups![index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              _appService.state.orderHelper!.daysGroup =
                                  widget.scheduleModel.t.daysGroups![index];
                              selectedDay = InfininURLHelpers.dayOfMonth(
                                  item.scheduledDate);
                              selectedMonth =
                                  months[item.scheduledDate.month - 1];
                              selectedDate = item.scheduledDate.day.toString();
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(children: [
                                  GeneralText(dayOfMonth(item.scheduledDate),
                                      style: appTheme.typographies
                                          .interFontFamily.headline6
                                          .copyWith(
                                              color:
                                                  HexColor.fromHex('#f1c452'),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700)),
                                  SizedBox(
                                    width: 70,
                                    child: GeneralText(
                                        item.scheduledDate.day.toString(),
                                        textAlign: TextAlign.center,
                                        style: appTheme.typographies
                                            .interFontFamily.headline2
                                            .copyWith(
                                          color: HexColor.fromHex('#909094'),
                                          fontSize: 40,
                                        )),
                                  )
                                ]),
                                // const SizedBox(
                                //   width: 27,
                                // ),
                                displayScheduleTime(
                                  item.hours,
                                  item.scheduledDate,
                                ),

                                // Expanded(
                                //   child: Container(
                                //     width: double.infinity,
                                //     padding: const EdgeInsets.only(
                                //         left: 8, top: 10, bottom: 10),
                                //     decoration: BoxDecoration(
                                //         color: HexColor.fromHex('#2b2b33'),
                                //         borderRadius: const BorderRadius.only(
                                //             topLeft: Radius.circular(20),
                                //             bottomLeft: Radius.circular(20))),
                                //     child: Wrap(children: [
                                //       timeSelectorBox(appTheme,
                                //           showSelectedTime: true),
                                //       SizedBox(
                                //         width: 7,
                                //       ),
                                //       timeSelectorBox(appTheme,
                                //           showSelectedTime: false),
                                //       SizedBox(
                                //         width: 7,
                                //       ),
                                //       timeSelectorBox(appTheme,
                                //           showSelectedTime: false),
                                //       SizedBox(
                                //         width: 7,
                                //       ),
                                //       timeSelectorBox(appTheme,
                                //           showSelectedTime: false),
                                //       SizedBox(
                                //         width: 7,
                                //       ),
                                //     ]),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 27,
                          ),
                        ],
                      );
                    }),
              ),
            ],
          );
  }

  String dayOfMonth(DateTime _date) {
    var dateData = DateFormat('EEEE').format(_date);
    selectedMonth = months[_date.month - 1];

    return dateData.substring(0, 3);
  }

  Widget displayScheduleTime(List<Hour> _hours, DateTime scheduledDate) {
    final appTheme = AppTheme.of(context).theme;
    return Expanded(
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 8, top: 10, bottom: 10),
          decoration: BoxDecoration(
              color: HexColor.fromHex('#2b2b33'),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
          child: Wrap(
            spacing: 10,
            direction: Axis.horizontal,
            children: [
              for (var i in _hours) //displayTimeData(i),
                timeSelectorBox(
                  appTheme,
                  i.startTime.toString(),
                  i,
                  scheduledDate,
                  showSelectedTime: _appService.state.orderHelper!.scheduleId ==
                          i.scheduleId.toString()
                      ? true
                      : false,
                ),
              // const SizedBox(
              //   width: 7,
              // ),
            ],
          )),
    );
  }

  Widget data() {
    return Container();
  }

  // Widget displayTimeData(i) {
  //   final appTheme = AppTheme.of(context).theme;
  //   return Row(
  //     children: [
  //       timeSelectorBox(
  //         appTheme,
  //         i.startTime.toString(),
  //         i,
  //         showSelectedTime: false,
  //       ),
  //     ],
  //   );
  // }

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
      padding: const EdgeInsetsDirectional.only(start: 20),
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
              const SizedBox(
                width: 27,
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsetsDirectional.only(
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
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsetsDirectional.only(
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
                                const SizedBox(
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
                                      margin: const EdgeInsetsDirectional.only(
                                          bottom: 8),
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
                                    const SizedBox(
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
                                      margin: const EdgeInsetsDirectional.only(
                                          bottom: 8),
                                      padding: const EdgeInsetsDirectional.only(
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
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsetsDirectional.only(
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
                                const SizedBox(
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
                                  margin: const EdgeInsetsDirectional.only(
                                      bottom: 8),
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
          const SizedBox(
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
            //  Strings.productDetailAboutSubTitle,
            // 'Test',
            widget.data!.description.toString(),
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

        ///wow factors
        wowFactors(appTheme, wowFactorsList),
        const SizedBox(
          height: 12,
        ),

        ///preferences and no of persons section in this row
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
              style: appTheme.typographies.interFontFamily.headline6
                  .copyWith(
                fontSize: 20,
                color: HexColor.fromHex('#f1c452'),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          //width: MediaQuery.of(context).size.width * 0.50,
          child: wowFactors(appTheme, preferencesList),
        ),
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
        const SizedBox(height: 90),

        ///Google map
        Container(
          height: 400,
          width: MediaQuery.of(context).size.width,
          transform: Matrix4.translationValues(-12.0, 0, 0.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: appTheme.colors.primary,
                blurRadius: 400.0,
                spreadRadius: 70,
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
                widget.chefData.t!.latitude ?? 0.0,
                widget.chefData.t!.longitude ?? 0.0,
              ),
              zoom: 14.4746,
            ),
            markers: <Marker>{
              Marker(
                  markerId: const MarkerId('SomeId'),
                  position: LatLng(
                    widget.chefData.t!.latitude ?? 0.0,
                    widget.chefData.t!.longitude ?? 0.0,
                  ),
                  infoWindow: const InfoWindow(title: '')),
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              controller.setMapStyle(darkMapStyle);
            },
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }

  Widget wowFactors(IAppThemeData appTheme, List<CustomModel> items) {
    return Wrap(
      children: [
        for (int i = 0; i < items.length; i++)
          Container(
            width: MediaQuery.of(context).size.width * 0.23,
            padding: const EdgeInsets.only(bottom: 7.7),
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
                    height: 50,
                    padding: const EdgeInsetsDirectional.all(10),
                    decoration: BoxDecoration(
                      color: HexColor.fromHex("#f1c452"),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.network(
                      items[i].name != null
                          ? Api.baseURLForImages + items[i].name.toString()
                          : '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                GeneralText(
                  items[i].icon ?? "",
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style:
                      appTheme.typographies.interFontFamily.headline6.copyWith(
                    fontSize: 12,
                    color: HexColor.fromHex('#ffffff'),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget timeSelectorBoxtest(IAppThemeData appTheme, String displayTime,
      {bool showSelectedTime = false}) {
    //  developer.log('Time Display is ' +
    //      DateFormat.jm().format(
    //        DateFormat("hh:mm:ss").parse(displayTime),
    //      ));
    //  var _formatedTime =
    //      DateFormat.jm().format(DateFormat("hh:mm:ss").parse(displayTime));
    // // var _finalDate =
    //  var data = _formatedTime.split(':');
    //  var finalDate = '';
    //  finalDate = data[0];
    //  finalDate = finalDate + data[1].replaceAll('00', '');
    var finalDate = '';
    finalDate = InfininURLHelpers.getAmPm(displayTime);

    return InkWell(
        onTap: () {
          developer.log(' Clicked on final date is ' + '${finalDate}');
          // selectedTime = finalDate;
          // developer.log(' Schedule Id selected is ' + '${_hour.scheduleId}');
          // final _appService = locateService<ApplicationService>();
          // OrderHelper orderHelper = OrderHelper();
          // orderHelper.scheduleId = _hour.scheduleId.toString();
          // orderHelper.selectedExperienceDetail = widget.data;
          // orderHelper.hourSelected = _hour;
          // _appService.updateOrderHelper(orderHelper);
          //  _appService.updateScheduleId(scheduleId)
          setState(() {});
        },
        child: Container(
          child: GeneralText(finalDate,
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
          padding: const EdgeInsetsDirectional.only(
              top: 8, bottom: 8, start: 16, end: 16),
          margin: const EdgeInsetsDirectional.only(bottom: 8),
        ));
  }

  Widget timeSelectorBox(IAppThemeData appTheme, String displayTime, Hour _hour,
      DateTime scheduledDate,
      {bool showSelectedTime = false}) {
    //  developer.log('Time Display is ' +
    //      DateFormat.jm().format(
    //        DateFormat("hh:mm:ss").parse(displayTime),
    //      ));
    //  var _formatedTime =
    //      DateFormat.jm().format(DateFormat("hh:mm:ss").parse(displayTime));
    // // var _finalDate =
    //  var data = _formatedTime.split(':');
    //  var finalDate = '';
    //  finalDate = data[0];
    //  finalDate = finalDate + data[1].replaceAll('00', '');
    var finalDate = '';
    finalDate = InfininURLHelpers.getAmPm(displayTime);

    return InkWell(
        onTap: () {
          selectedDate = DateFormat("d").format(scheduledDate);
          selectedDay = DateFormat('EEE').format(scheduledDate);
          developer.log(' Clicked on final date is ' + '$finalDate');
          selectedTime = finalDate;
          openCapacity = _hour.openCapacity;
          developer.log(' Schedule Id selected is ' + '${_hour.scheduleId}');
          // final _appService = locateService<ApplicationService>();
          OrderHelper orderHelper = OrderHelper();
          orderHelper.openCapacity = _hour.openCapacity;
          orderHelper.scheduleId = _hour.scheduleId.toString();
          orderHelper.selectedExperienceDetail = widget.data!;
          //selectedDate = finalDate;
          orderHelper.hourSelected = _hour;
          orderHelper.daysGroup =
              DaysGroup(scheduledDate: scheduledDate, dayOfMonth: 0, hours: []);
          orderHelper.numberOfPerson =
              int.parse(widget.data!.persons.toString());
          // orderHelper.selectedCategory = widget
          //     .data!
          //     .experiencePreferences![
          //         int.parse(widget.data?.preferenceId as String)]
          //     .preferenceName
          //     .toString();
          //.data!.persons;
          _appService.updateOrderHelper(orderHelper);
          //_appService.updateScheduleId(scheduleId)
          setState(() {
            showSelectedTime = true;
          });
        },
        child: Column(
          children: [
            Container(
              child: GeneralText(finalDate,
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
              padding: const EdgeInsetsDirectional.only(
                  top: 8, bottom: 8, start: 16, end: 16),
              margin: const EdgeInsetsDirectional.only(bottom: 2),
            ),
            SizedBox(
              width: 23,
              child: Row(
                children: [
                  SvgPicture.asset(Resources.peopleIconSvg, height: 12, color:
                  HexColor.fromHex(showSelectedTime ? '#fbeccb' : '#909094'),),
                  const SizedBox(width:3),
                  GeneralText(_hour.openCapacity.toString(),
                      style: appTheme.typographies
                          .interFontFamily.headline6
                          .copyWith(
                          color:
                          HexColor.fromHex(showSelectedTime ? '#fbeccb' : '#909094'),
                          fontSize: 14,
                          fontWeight: showSelectedTime ? FontWeight.w700 : FontWeight.normal)),
                ],
              ),
            ),
          ],
        ));
  }

  Widget noOfPersonsField({
    required IAppThemeData appTheme,
    required TextStyle valueStyle,
    required TextStyle hintStyle,
  }) {
    return GeneralTextInput(
      contentPadding: const EdgeInsetsDirectional.only(
          top: 8, bottom: 8, start: 16, end: 16),
      controller: nOfPersons,
      hint: Strings.noOfPersonsHint,
      inputType: InputType.digit,
      valueStyle: valueStyle,
      hintStyle: hintStyle,
      validator: (_) {
        return null;
      },
      onChanged: (newValue) {
        if (newValue.isNotEmpty) {
          setState(() {
            developer.log(' New Value of Persons ' + '${newValue}');

            nOfPersons.text = newValue;
            _appService.state.orderHelper!.numberOfPerson =
                int.parse(nOfPersons.text);
          });
        }
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
      contentPadding: const EdgeInsetsDirectional.only(
          top: 8, bottom: 8, start: 16, end: 16),
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
          _appService.state.orderHelper!.noteAdded = notes.text;
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