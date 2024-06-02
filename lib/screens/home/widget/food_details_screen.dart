import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chef/helpers/device_helper.dart';
import 'package:chef/helpers/helpers.dart';
import 'package:chef/screens/home/schedule_model.dart';
import 'package:chef/screens/home/widget/order_detail_screen.dart';
import 'package:chef/screens/user_account/user_profile.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carousel_media_slider/carousel_media.dart';
import 'package:flutter_carousel_media_slider/flutter_carousel_media_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

import '../../../constants/temporary_data.dart';
import '../../../models/booking/booking_request.dart';
import '../../../models/food_details_screen/slider_images_response.dart';
import '../../../models/home/chef_data_response.dart';
import '../../../models/home/home_response.dart' as home_data;
import '../../food_product_experience_details/food_product_details_screen_v.dart';
import '../../user_account/reviews.dart';
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
  late VideoPlayerController _videoPlayerController1;
  late VideoPlayerController _videoPlayerController2;
  late ChewieController _chewieController;
  late ChewieController _chewieController2;
  List<CarouselMedia> media = [
    CarouselMedia(
      mediaName: 'Image 1',
      mediaUrl:
          'https://images.pexels.com/photos/1172253/pexels-photo-1172253.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      mediaType: CarouselMediaType.image,
      carouselImageSource: CarouselImageSource.network,
    ),
    CarouselMedia(
      mediaName: 'Video 1',
      mediaUrl: 'https://www.youtube.com/watch?v=snYu2JUqSWs',
      mediaType: CarouselMediaType.video,
      carouselImageSource: CarouselImageSource.network,
    ),
    CarouselMedia(
      mediaName: 'Image 2',
      mediaUrl:
          'https://media.istockphoto.com/photos/mountain-landscape-picture-id517188688?k=20&m=517188688&s=612x612&w=0&h=i38qBm2P-6V4vZVEaMy_TaTEaoCMkYhvLCysE7yJQ5Q=',
      mediaType: CarouselMediaType.image,
      carouselImageSource: CarouselImageSource.network,
    ),
    // CarouselMedia(
    //   mediaName: 'Image 5',
    //   mediaUrl:
    //       'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
    //   mediaType: CarouselMediaType.video,
    //   carouselImageSource: CarouselImageSource.network,
    // )
  ];
  List<BookingDetails> bookingMenuDetails = [];
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
  int menuCounter = 0;
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

  List weekDays = [
    'Mon',
    'Tue',
    'Wed',
    'Thur',
    'Fri',
    'Sat',
    'Sun',
  ];

  var darkMapStyle;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  int _current = 0;
  final CarouselController _sliderController = CarouselController();

  bool isButtonEnable = true;

  @override
  void initState() {
    _videoPlayerController1 = VideoPlayerController.network(
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4');
    _videoPlayerController2 = VideoPlayerController.network(
        'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4');

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 4 / 3,
      autoPlay: true,
      showControls: true,
      hideControlsTimer: ChewieController.defaultHideControlsTimer,
      showOptions: true,
      autoInitialize: true,
      draggableProgressBar: false,
      showControlsOnInitialize: false,
      allowFullScreen: false,
      allowMuting: true,
      looping: false,
    );

    _chewieController.videoPlayerController.addListener(() {
      if (_chewieController.videoPlayerController.value.position ==
          _chewieController.videoPlayerController.value.duration) {
        _sliderController.nextPage();
        print('video Ended');
      }
    });

    _chewieController2 = ChewieController(
      videoPlayerController: _videoPlayerController2,
      //aspectRatio: 4 / 3,
      autoPlay: true,
      looping: true,
    );

    developer.log(' Price Id is }');
    headers = widget.foodMenuDetail.t
        .map((element) => element.mealName)
        .toSet()
        .toList();
    for (var element in widget.foodMenuDetail.t) {
      bookingMenuDetails.add(BookingDetails(menuId: element.id, quantity: 0));
    }
    widget.data?.experiencePreferences?.forEach((element) {
      items.add(element.preferenceName.toString());
      preferenceIds.add(int.parse(element.id.toString()));
    });

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
    loadPreferences();
    _loadMapStyles();
    super.initState();
  }

  getBack() {
    if (widget.data!.priceTypeId == 2) {
      widget.data!.price = 0;
    }
    Navigator.pop(context);
  }

  Future _loadMapStyles() async {
    darkMapStyle =
        await rootBundle.loadString('assets/json/dark_mode_style.json');
  }

  void loadWowFactor() {
    developer.log(' Wow factors are ' '${widget.data?.experienceWowFactors}');
    var experienceWowFactor = widget.data?.experienceWowFactors;

    for (int i = 0; i < experienceWowFactor!.length; i++) {
      wowFactorsList.addAll([
        CustomModel(
            icon: experienceWowFactor[i].wowFactorName,
            name: experienceWowFactor[i].wowFactorIconPath),
      ]);
    }
  }

  void loadPreferences() {
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
    if (bookingMenuDetails[index].quantity.toString().isNotEmpty) {
      setState(() {
        bookingMenuDetails[index].quantity =
            (bookingMenuDetails[index].quantity ?? 0) + 1;
        widget.data?.price = widget.data!.price! + itemPrice;
      });
    }
  }

  removeQuantity(int itemPrice, int index) {
    if (bookingMenuDetails[index].quantity! > 0) {
      setState(() {
        bookingMenuDetails[index].quantity =
            (bookingMenuDetails[index].quantity ?? 0) - 1;
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
    return WillPopScope(
      onWillPop: () {
        if (widget.data!.priceTypeId == 2) {
          widget.data!.price = 0;
        }
        return Future(() => true);
      },
      child: Scaffold(
        backgroundColor: HexColor.fromHex('#212129'),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            selectedTab == TabBars.Details || selectedTab == TabBars.Menu
                ? experienceNextButton()
                : const SizedBox(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                //fit: StackFit.expand,
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
                              images = images + images;
                              return Column(
                                children: [
                                  // CarouselSlider(
                                  //   options: CarouselOptions(
                                  //     height: DeviceHelper.height * 0.50,
                                  //     autoPlay: true,
                                  //   ),
                                  //   items: (images.isEmpty
                                  //           ? foodDetailsBgImages
                                  //           : images)
                                  //       .map((i) {
                                  //     return Builder(
                                  //       builder: (BuildContext context) {
                                  //         return Image.network(
                                  //             Api.baseURLForImages + i,
                                  //             fit: BoxFit.fitHeight);
                                  //       },
                                  //     );
                                  //   }).toList(),
                                  // ),
                                  CarouselSlider(
                                    carouselController: _sliderController,
                                    items: [
                                      Chewie(
                                        controller: _chewieController,
                                      ),
                                      Image.asset(foodDetailsBgImages[0]),
                                    ],
                                    options: CarouselOptions(
                                        height: DeviceHelper.height * 0.50,
                                        autoPlay: true,
                                        onPageChanged: (index, reason) {
                                          _chewieController.seekTo(
                                              const Duration(seconds: 0));
                                          _chewieController.pause();
                                        }),
                                  ),
                                  // FlutterCarouselMediaSlider(
                                  //   height: DeviceHelper.height * 0.50,
                                  //   carouselMediaList: media,
                                  //   // placeholder: const Center(
                                  //   //   child: Text('Loading...'),
                                  //   // ),
                                  //   onPageChanged: (index) {
                                  //     debugPrint('Page Changed: $index');
                                  //   },
                                  // ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                        images.asMap().entries.map((entry) {
                                      return GestureDetector(
                                        onTap: () => _sliderController
                                            .animateToPage(entry.key),
                                        child: Container(
                                          width: 12.0,
                                          height: 12.0,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 4.0),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: (Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black)),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              );
                            } else {
                              return Container(
                                margin:
                                    const EdgeInsets.only(bottom: 90, top: 100),
                                child: const CircularProgressIndicator(),
                              );
                            }
                          }),
                      // Expanded(
                      //   child: SingleChildScrollView(
                      //     child: Container(
                      //       padding: EdgeInsetsDirectional.only(
                      //         start: DeviceHelper.width * 0.10,
                      //         top: DeviceHelper.height * 0.07,
                      //       ),
                      //       color: HexColor.fromHex('#212129'),
                      //       child: Column(
                      //         children: [
                      //           if (selectedTab != TabBars.Schedule)
                      //             SizedBox(
                      //               height: DeviceHelper.height * 0.10,
                      //             ),
                      //           if (selectedTab == TabBars.Schedule)
                      //             SizedBox(
                      //               height: DeviceHelper.height * 0.05,
                      //             ),
                      //           if (selectedTab == TabBars.Menu)
                      //             SizedBox(
                      //               height: DeviceHelper.height * 0.01,
                      //             ),
                      //           if (selectedTab == TabBars.Details)
                      //             detailsTabViewForm(context, appTheme),
                      //           if (selectedTab == TabBars.Menu)
                      //             menuTabView(context, appTheme),
                      //           if (selectedTab == TabBars.Schedule)
                      //             scheduleTabView(context, appTheme)
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),

                  ///appbar
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 40),
                    child: GeneralNewAppBar(
                      callBack: () {
                        setState(() {
                          selectedTab == TabBars.Details
                              ? getBack()
                              : (selectedTab == TabBars.Menu
                                  ? setTab(TabBars.Details)
                                  : scheduleForm
                                      ? scheduleForm = false
                                      : setTab(TabBars.Menu));
                        });
                      },
                    ),
                  ),

                  ///title section
                  // Positioned(
                  //     top: DeviceHelper.height * 0.27,
                  //     width: MediaQuery.of(context).size.width,
                  //     child: Padding(
                  //       padding: EdgeInsetsDirectional.only(
                  //           start: DeviceHelper.width * 0.07),
                  //       child: Column(children: [
                  //         Container(
                  //             decoration: BoxDecoration(
                  //               color: HexColor.fromHex("#4b4b52"),
                  //               borderRadius: BorderRadius.only(
                  //                 topLeft: Radius.circular(
                  //                   DeviceHelper.height * 0.03,
                  //                 ),
                  //                 bottomLeft: Radius.circular(
                  //                   DeviceHelper.height * 0.03,
                  //                 ),
                  //               ),
                  //             ),
                  //             height: DeviceHelper.height * 0.175,
                  //             padding: const EdgeInsetsDirectional.only(bottom: 0),
                  //             child: Padding(
                  //               padding: EdgeInsetsDirectional.only(
                  //                   top: DeviceHelper.height * 0.025),
                  //               child: Column(children: [
                  //                 getFoodMainHeading(
                  //                     appTheme: appTheme, title: widget.data!.title),
                  //                 SizedBox(
                  //                   height: DeviceHelper.height * 0.005,
                  //                 ),
                  //                 Row(
                  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     const SizedBox(),
                  //                     InkWell(
                  //                       onTap: () {
                  //                         Navigator.push(
                  //                           context,
                  //                           MaterialPageRoute(
                  //                               builder: (context) => ReviewsScreen(
                  //                                     fromFoodDetailScreen: true,
                  //                                     experienceId: widget.data?.id,
                  //                                   )),
                  //                         );
                  //                       },
                  //                       child: Row(
                  //                         children: [
                  //                           Image.asset(
                  //                             Resources.bookingStarPNG,
                  //                             height: 10,
                  //                           ),
                  //                           widget.data?.averageRating == null
                  //                               ? GeneralText(
                  //                                   Strings.noReviews,
                  //                                   style: appTheme.typographies
                  //                                       .interFontFamily.headline6
                  //                                       .copyWith(
                  //                                           fontSize: 14,
                  //                                           color: HexColor.fromHex(
                  //                                               '#8ea659')),
                  //                                 )
                  //                               : Text.rich(
                  //                                   TextSpan(
                  //                                     text:
                  //                                         ' ${widget.data?.averageRating} ( ',
                  //                                     style: appTheme.typographies
                  //                                         .interFontFamily.headline6
                  //                                         .copyWith(
                  //                                             fontSize: 14,
                  //                                             color: HexColor.fromHex(
                  //                                                 '#8ea659')),
                  //                                     children: <TextSpan>[
                  //                                       TextSpan(
                  //                                         text:
                  //                                             '${widget.data?.noOfRatings} reviews',
                  //                                         style: appTheme
                  //                                             .typographies
                  //                                             .interFontFamily
                  //                                             .headline6
                  //                                             .copyWith(
                  //                                                 fontSize: 14,
                  //                                                 decoration:
                  //                                                     TextDecoration
                  //                                                         .underline,
                  //                                                 color: HexColor
                  //                                                     .fromHex(
                  //                                                         '#8ea659')),
                  //                                       ),
                  //                                       const TextSpan(
                  //                                         text: ' )',
                  //                                       ),
                  //                                       // can add more TextSpans here...
                  //                                     ],
                  //                                   ),
                  //                                 ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     const SizedBox(),
                  //                   ],
                  //                 ),
                  //                 Padding(
                  //                   padding: EdgeInsetsDirectional.only(
                  //                       start: DeviceHelper.width * 0.10,
                  //                       end: DeviceHelper.width * 0.10),
                  //                   child: Row(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.spaceBetween,
                  //                     children: [
                  //                       InkWell(
                  //                         child: Column(
                  //                           children: [
                  //                             GeneralText(
                  //                               Strings.foodItemDetails,
                  //                               style: appTheme.typographies
                  //                                   .interFontFamily.headline6
                  //                                   .copyWith(
                  //                                       fontSize: 14,
                  //                                       fontWeight: selectedTab ==
                  //                                               TabBars.Details
                  //                                           ? FontWeight.bold
                  //                                           : FontWeight.w400,
                  //                                       color: HexColor.fromHex(
                  //                                           '#f1c452')),
                  //                             ),
                  //                             Container(
                  //                               height: DeviceHelper.height * 0.012,
                  //                               width: DeviceHelper.height * 0.012,
                  //                               decoration: BoxDecoration(
                  //                                   color: selectedTab ==
                  //                                           TabBars.Details
                  //                                       ? HexColor.fromHex('#f1c452')
                  //                                       : Colors.transparent,
                  //                                   shape: BoxShape.circle),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         onTap: () {
                  //                           updateTabView(TabBars.Details);
                  //                         },
                  //                       ),
                  //                       InkWell(
                  //                         onTap: () {
                  //                           updateTabView(TabBars.Menu);
                  //                         },
                  //                         child: Column(
                  //                           children: [
                  //                             GeneralText(
                  //                               Strings.foodItemMenu,
                  //                               style: appTheme.typographies
                  //                                   .interFontFamily.headline6
                  //                                   .copyWith(
                  //                                       fontSize: 14,
                  //                                       fontWeight: selectedTab ==
                  //                                               TabBars.Menu
                  //                                           ? FontWeight.bold
                  //                                           : FontWeight.w400,
                  //                                       color: HexColor.fromHex(
                  //                                           '#f1c452')),
                  //                             ),
                  //                             Container(
                  //                               height: DeviceHelper.height * 0.012,
                  //                               width: DeviceHelper.height * 0.012,
                  //                               decoration: BoxDecoration(
                  //                                   color: selectedTab == TabBars.Menu
                  //                                       ? HexColor.fromHex('#f1c452')
                  //                                       : Colors.transparent,
                  //                                   shape: BoxShape.circle),
                  //                             )
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       InkWell(
                  //                         onTap: () {
                  //                           updateTabView(TabBars.Schedule);
                  //                         },
                  //                         child: Column(
                  //                           children: [
                  //                             GeneralText(
                  //                               Strings.foodItemSchedule,
                  //                               style: appTheme.typographies
                  //                                   .interFontFamily.headline6
                  //                                   .copyWith(
                  //                                       fontSize: 14,
                  //                                       fontWeight: selectedTab ==
                  //                                               TabBars.Schedule
                  //                                           ? FontWeight.bold
                  //                                           : FontWeight.w400,
                  //                                       color: HexColor.fromHex(
                  //                                           '#f1c452')),
                  //                             ),
                  //                             Container(
                  //                               height: DeviceHelper.height * 0.012,
                  //                               width: DeviceHelper.height * 0.012,
                  //                               decoration: BoxDecoration(
                  //                                   color: selectedTab ==
                  //                                           TabBars.Schedule
                  //                                       ? HexColor.fromHex('#f1c452')
                  //                                       : Colors.transparent,
                  //                                   shape: BoxShape.circle),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ]),
                  //             )),
                  //         if (selectedTab == TabBars.Menu ||
                  //             selectedTab == TabBars.Details) ...[
                  //           displayPriceOption(),
                  //         ]
                  //         //),
                  //       ]),
                  //     )),

                  ///chef image
                  // Positioned.fill(
                  //   top: DeviceHelper.height * 0.23,
                  //   right: DeviceHelper.width * 0.02,
                  //   child: Align(
                  //     alignment: Alignment.topRight,
                  //     child: GestureDetector(
                  //       child: CircleAvatar(
                  //         backgroundColor: Colors.white,
                  //         radius: DeviceHelper.width * 0.09,
                  //         child: CircleAvatar(
                  //           radius: DeviceHelper.width * 0.085,
                  //           backgroundImage: NetworkImage(Api.baseURLForImages +
                  //               widget.chefData.t!.profileImageUrl.toString()),
                  //         ),
                  //       ),
                  //       onTap: () async {
                  //         Navigator.of(context).push(MaterialPageRoute(
                  //             builder: (context) =>
                  //                 UserProfile(chefData: widget.chefData)));
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: GeneralText(
                            widget.data!.title ??
                                '', // Strings.labelSeaFood2Experience,
                            style: appTheme
                                .typographies.interFontFamily.headline2
                                .copyWith(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/star.svg',
                                height: 13,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GeneralText(
                                widget.data!.averageRating?.toString() ??
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
                        ),
                      ],
                    ),
                    //SizedBox(height: DeviceHelper.height * 0.01),
                    GeneralText(
                      "${Strings.byText} ${widget.data!.chefBrandName}", // Strings.labelSeaFood2Experience,
                      style: appTheme.typographies.interFontFamily.headline2
                          .copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff909094),
                      ),
                    ),
                    GeneralText(
                      '${widget.data!.townName}, ${widget.data!.cityName}', // Strings.labelSeaFood2Experience,
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                        fontSize: 13,
                        //fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    getDivider(),
                    selectedTab == TabBars.Menu ||
                            selectedTab == TabBars.Schedule
                        ? GeneralText(
                            selectedTab == TabBars.Menu
                                ? Strings.foodItemMenu
                                : selectedTab == TabBars.Schedule
                                    ? Strings.foodItemNextAvailable
                                    : '', // Strings.labelSeaFood2Experience,
                            style: appTheme
                                .typographies.interFontFamily.headline2
                                .copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xffeee0c1),
                            ),
                          )
                        : const SizedBox(),
                    if (selectedTab == TabBars.Details)
                      experienceDetailView(context, appTheme),
                    if (selectedTab == TabBars.Menu)
                      experienceMenuView(context, appTheme),
                    if (selectedTab == TabBars.Schedule)
                      experienceScheduleView(context, appTheme)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget experienceNextButton() {
    return Container(
      height: DeviceHelper.height * 0.10,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              GeneralText(
                'SAR. 350', // Strings.labelSeaFood2Experience,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xfff1c452),
                ),
              ),
              GeneralText(
                " /Person", // Strings.labelSeaFood2Experience,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff909094),
                ),
              ),
            ],
          ),
          GeneralButton.button(
            title: selectedTab == TabBars.Details
                ? Strings.foodItemMenu
                : selectedTab == TabBars.Menu
                    ? Strings.foodItemSchedule
                    : '',
            //isEnable: (!scheduleForm && selectedTime == "") ? true : false,
            styleType: ButtonStyleType.fill,
            onTap: () {
              setState(() {
                if (!scheduleForm &&
                    selectedTime == "" &&
                    selectedTab == TabBars.Schedule) {
                  Toaster.infoToast(
                      context: context,
                      message: 'Please Select Schedule Slot!');
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
          ),
        ],
      ),
    );
  }

  void setTab(var a) {
    selectedTab = a;
  }

  Widget getDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: DeviceHelper.height * 0.01),
      child: Divider(
        color: Colors.white.withOpacity(0.1),
      ),
    );
  }

  void goToRequestToBookScreen() {
    if (nOfPersons.text.isEmpty ||
        int.parse(nOfPersons.text) <= 0 ||
        int.parse(nOfPersons.text) > openCapacity) {
      Toaster.infoToast(
          context: context,
          message: '${Strings.noOfPersonsMust} $openCapacity');
    } else {
      if (widget.data!.priceTypeId == 2) {
        int a = 0;
        for (var element in bookingMenuDetails) {
          if (element.quantity != 0) {
            a = 1;
          }
        }
        if (a == 1) {
          bookingMenuDetails.removeWhere((element) => element.quantity == 0);
          _appService.state.orderHelper?.bookingMenuDetails =
              bookingMenuDetails;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FoodProductExperienceDetailsScreenView(
                selectedExperienceId: widget.data!.id.toString(),
                experienceData: widget.data!,
                foodMenuDetail: widget.foodMenuDetail,
                chefData: widget.chefData,
              ),
            ),
          );
        } else {
          Toaster.errorToast(
              context: context, message: Strings.selectAtLeastOne);
        }
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodProductExperienceDetailsScreenView(
              selectedExperienceId: widget.data!.id.toString(),
              experienceData: widget.data!,
              foodMenuDetail: widget.foodMenuDetail,
              chefData: widget.chefData,
            ),
          ),
        );
      }
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
                "${Strings.appCurrency}. ${widget.data!.price}",
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
            // bookingMenuDetails.add(BookingDetails(menuId: widget.foodMenuDetail.t[0].id, quantity: 0));
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
                      SizedBox(
                        width: DeviceHelper.width * 0.05,
                      ),
                      getFoodItemHeading(
                          appTheme: appTheme, mealTitle: headers[index]),
                    ],
                  ),
                  SizedBox(height: DeviceHelper.height * 0.03),
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
                          getMenuItem(filteredList, k, appTheme, index,
                              filteredList[k]),
                      ],
                    ),
                  ),
                ]);
          },
        ));
  }

  Widget experienceMenuView(BuildContext context, IAppThemeData appTheme) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 150),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: headers.length,
          itemBuilder: (BuildContext context, int index) {
            // bookingMenuDetails.add(BookingDetails(menuId: widget.foodMenuDetail.t[0].id, quantity: 0));
            List<menu.T> filteredList = widget.foodMenuDetail.t
                .where((element) => element.mealName == headers[index])
                .toList();
            return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///Meal Name Title Row
                  // Row(
                  //   children: [
                  //     Container(
                  //       color: HexColor.fromHex('#f1c452'),
                  //       width: 16,
                  //       height: 1,
                  //     ),
                  //     SizedBox(
                  //       width: DeviceHelper.width * 0.05,
                  //     ),
                  //     getFoodItemHeading(
                  //         appTheme: appTheme, mealTitle: headers[index]),
                  //   ],
                  // ),
                  // SizedBox(height: DeviceHelper.height * 0.03),
                  Column(
                    children: [
                      for (int k = 0; k < filteredList.length; k++)
                        getMenuItem(
                            filteredList, k, appTheme, index, filteredList[k]),
                    ],
                  ),
                ]);
          },
        ));
  }

  getMenuItem(List filteredList, int k, IAppThemeData appTheme, int index,
      menu.T menuItem) {
    return Container(
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
              Api.baseURLForImages + menuItem.pictureUrl,
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
                    appTheme: appTheme, foodItemTitle: menuItem.dish),
                // getFoodItemSubTitle(
                //     appTheme: appTheme, subTitle: menuItem.baseDishName),
                getFoodItemDescription(
                    appTheme: appTheme,
                    foodItemDescription: menuItem.description),
              ],
            ),
          ),
          widget.data!.priceTypeId == 2
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
                          Container(
                              child: getFoodItemUsers(
                                  appTheme: appTheme,
                                  index: index,
                                  menuItem: menuItem)),
                        ],
                      ),
                      SizedBox(
                        height: DeviceHelper.height * 0.01,
                      ),
                      displayQuantityData(filteredList[k].price, k, menuItem),
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

  Widget displayQuantityData(int price, int index, menu.T menuItem) {
    final appTheme = AppTheme.of(context).theme;
    for (var element in bookingMenuDetails) {
      if (element.menuId == menuItem.id) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.data!.priceTypeId == 2
                ? getFoodItemAmount(
                    appTheme: appTheme,
                    foodItemPrice: menuItem.price.toString(),
                    quantityIndex: index,
                    menuItem: menuItem,
                  )
                : Container(),
            displayQuantityDetails(price, index, menuItem),
          ],
        );
      }
    }
    return const SizedBox();
  }

  Widget displayQuantityDetails(int itemPrice, int index, menu.T menuItem) {
    final appTheme = AppTheme.of(context).theme;
    return Stack(
      children: [
        Row(
          children: [
            getFoodItemQuantityLabel(appTheme: appTheme),
            SizedBox(
              width: DeviceHelper.width * 0.01,
            ),
            InkWell(
              onTap: () {
                for (var element in bookingMenuDetails) {
                  if (element.menuId == menuItem.id) {
                    if (element.quantity != 0) {
                      setState(() {
                        element.quantity = (element.quantity ?? 0) - 1;
                        widget.data?.price =
                            widget.data!.price! - menuItem.price;
                      });
                    }
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor.fromHex("#f7dc99"),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      topLeft: Radius.circular(8)),
                ),
                padding: const EdgeInsetsDirectional.only(
                    start: 6, end: 6, top: 4, bottom: 4),
                child: const Icon(Icons.remove, color: Colors.black, size: 16),
              ),
            ),
            SizedBox(
              width: DeviceHelper.width * 0.08,
            ),
            InkWell(
              onTap: () {
                for (var element in bookingMenuDetails) {
                  if (element.menuId == menuItem.id) {
                    if (element.quantity.toString().isNotEmpty) {
                      setState(() {
                        element.quantity = (element.quantity ?? 0) + 1;
                        widget.data?.price =
                            widget.data!.price! + menuItem.price;
                      });
                    }
                  }
                }
                // if (bookingMenuDetails[index].quantity.toString().isNotEmpty) {
                //   setState(() {
                //     bookingMenuDetails[index].quantity = (bookingMenuDetails[index].quantity ?? 0) + 1;
                //     widget.data?.price = widget.data!.price! + itemPrice;
                //   });
                // }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor.fromHex("#f7dc99"),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                ),
                padding: const EdgeInsetsDirectional.only(
                    start: 6, end: 6, top: 4, bottom: 4),
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 16,
                ),
              ),
            )
          ],
        ),
        displayQuantityNumber(index, menuItem),
      ],
    );
  }

  Widget displayQuantityNumber(int index, menu.T menuItem) {
    final appTheme = AppTheme.of(context).theme;
    return Positioned.fill(
      left: 60,
      child: Align(
        alignment: Alignment.center,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsetsDirectional.only(
                start: 15, end: 15, top: 1, bottom: 5.5),
            child: getFoodItemQuantityValue(
                appTheme: appTheme, index: index, menuItem: menuItem)),
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
      required int quantityIndex,
      required menu.T menuItem}) {
    for (var element in bookingMenuDetails) {
      if (element.menuId == menuItem.id) {
        return GeneralText(
          //   Strings.appCurrency + "." + Strings.foodProductItemPrice,
          "${Strings.sarCurrency}. $foodItemPrice",
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
            fontSize: 19,
            fontWeight: FontWeight.w700,
            color:
                // element.quantity == 0
                //     ? HexColor.fromHex('#909094')
                //     :
                HexColor.fromHex('#f1c452'),
          ),
        );
      }
    }
    return const SizedBox();
  }

  Widget getFoodItemUsers(
      {required IAppThemeData appTheme,
      required index,
      required menu.T menuItem}) {
    return GeneralText(
      '${Strings.foodProductItemUsers} ${Strings.servings}',
      style: appTheme.typographies.interFontFamily.headline6.copyWith(
        fontSize: 14,
        color: HexColor.fromHex('#d9d9d9'),
      ),
    );
    return const GeneralText('');
  }

  Widget getFoodItemQuantityLabel({required IAppThemeData appTheme}) {
    return GeneralText(
      "${Strings.foodProductItemQuantity}:",
      style: appTheme.typographies.interFontFamily.headline6.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: HexColor.fromHex('#f1c452'),
      ),
    );
  }

  Widget? getFoodItemQuantityValue(
      {required IAppThemeData appTheme,
      required int index,
      required menu.T menuItem}) {
    for (var element in bookingMenuDetails) {
      if (element.menuId == menuItem.id) {
        return GeneralText(
          (element.quantity! <= 9 && element.quantity! > 0)
              ? "0${element.quantity}"
              : element.quantity.toString(),
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
              fontSize: 15,
              color: element.quantity.toString() == "0"
                  ? HexColor.fromHex('#212129').withOpacity(0.4)
                  : HexColor.fromHex('#212129')),
        );
      }
    }
    return null;
  }

  Widget getFoodMainHeading({required IAppThemeData appTheme, required title}) {
    return GeneralText(title,
        textAlign: TextAlign.center,
        style: appTheme.typographies.interFontFamily.headline6.copyWith(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24));
  }

  ///Schedule tab view
  Widget scheduleTabView(BuildContext context, IAppThemeData appTheme) {
    widget.scheduleModel.t.daysGroups.sort((a, b) {
      return a.scheduledDate.compareTo(b.scheduledDate);
    });

    return scheduleForm

        ///for notes page code see this padding widget
        ? Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 15,
              top: 50,
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

                    ///space between date and other details
                    SizedBox(
                      width: DeviceHelper.width * 0.07,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          /// time and day container
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
                          SizedBox(
                            height: DeviceHelper.height * 0.02,
                          ),
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsetsDirectional.only(
                                  start: 14, top: 15, bottom: 15, end: 15),
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
                                        height: DeviceHelper.height * 0.01,
                                      ),

                                      ///no of persons and preference
                                      Row(
                                        children: [
                                          ///persons text-field
                                          Container(
                                            width: DeviceHelper.width * 0.16,
                                            height: DeviceHelper.height * 0.065,
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
                                          SizedBox(
                                            width: DeviceHelper.width * 0.05,
                                          ),

                                          ///preference dropdown
                                          Container(
                                            width: DeviceHelper.width * 0.33,
                                            height: DeviceHelper.height * 0.07,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                //color: Colors.red,
                                                color:
                                                    HexColor.fromHex('#2b2b33'),
                                                border: Border.all(
                                                    color: HexColor.fromHex(
                                                        '#f1c452')),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            margin: const EdgeInsetsDirectional
                                                .only(bottom: 6),
                                            // padding: const EdgeInsetsDirectional
                                            //         .only(
                                            //     top: 8,
                                            //     bottom: 8,
                                            //     start: 0,
                                            //     end: 0),
                                            child: Center(
                                              child: GeneralDropdown(
                                                selectedItemId: 1,
                                                borderColor: Colors.transparent,
                                                name: Strings.tableSelect,
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
                                                      ' Selected value from Drop Down is '
                                                      '$value');
                                                  _appService.state.orderHelper!
                                                      .selectedCategory = value;
                                                  widget.data
                                                      ?.experiencePreferences
                                                      ?.forEach((element) {
                                                    if (element
                                                            .preferenceName ==
                                                        value) {
                                                      _appService
                                                              .state
                                                              .orderHelper
                                                              ?.selectedPreferenceId =
                                                          int.parse(element
                                                              .preferenceId
                                                              .toString());
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            Resources.peopleIconSvg,
                                            height: 12.5,
                                            color: HexColor.fromHex('#ea7458'),
                                          ),
                                          const SizedBox(width: 4),
                                          GeneralText(Strings.maxLimitLabel,
                                              style: appTheme.typographies
                                                  .interFontFamily.headline6
                                                  .copyWith(
                                                      color: HexColor.fromHex(
                                                          '#ea7458'),
                                                      fontSize: 14)),
                                          GeneralText(openCapacity.toString(),
                                              style: appTheme.typographies
                                                  .interFontFamily.headline6
                                                  .copyWith(
                                                      color: HexColor.fromHex(
                                                          '#ea7458'),
                                                      fontWeight:
                                                          FontWeight.bold,
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
                padding: const EdgeInsetsDirectional.only(bottom: 50, top: 30),
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
                                  widget.scheduleModel.t.daysGroups[index];
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
                                  GeneralText(getMonth(item.scheduledDate),
                                      style: appTheme.typographies
                                          .interFontFamily.headline6
                                          .copyWith(
                                              color:
                                                  HexColor.fromHex('#f1c452'),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700)),
                                  SizedBox(
                                    width: DeviceHelper.width * 0.25,
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
                          SizedBox(
                            height: DeviceHelper.height * 0.05,
                          ),
                        ],
                      );
                    }),
              ),
            ],
          );
  }

  Widget experienceScheduleView(BuildContext context, IAppThemeData appTheme) {
    widget.scheduleModel.t.daysGroups.sort((a, b) {
      return a.scheduledDate.compareTo(b.scheduledDate);
    });

    //return SizedBox();
    //scheduleForm

    ///for notes page code see this padding widget
    // ? Padding(
    //     padding: const EdgeInsetsDirectional.only(
    //       start: 15,
    //       top: 50,
    //     ),
    //     child: Column(
    //       children: [
    //         Row(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Column(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   // GeneralRichText(title: 'Oct\n 13'),
    //                   GeneralText(
    //                     selectedMonth,
    //                     // style: appTheme
    //                     //     .typographies.interFontFamily.headline6
    //                     //     .copyWith(
    //                     //         color: HexColor.fromHex('#f1c452'),
    //                     //         fontSize: 14,
    //                     //         //  height: 0,
    //                     //         fontWeight: FontWeight.w800),
    //                     style:
    //                         appTheme.typographies.interFontFamily.label11,
    //                   ),
    //                   GeneralText(
    //                     selectedDate,
    //                     // style: appTheme
    //                     //     .typographies.interFontFamily.headline6
    //                     //     .copyWith(
    //                     //         color: HexColor.fromHex('#909094'),
    //                     //         fontSize: 40,
    //                     //         fontWeight: FontWeight.w500),
    //
    //                     style:
    //                         appTheme.typographies.interFontFamily.label12,
    //                   )
    //                 ]),
    //
    //             ///space between date and other details
    //             SizedBox(
    //               width: DeviceHelper.width * 0.07,
    //             ),
    //             Expanded(
    //               child: Column(
    //                 children: [
    //                   /// time and day container
    //                   Container(
    //                       width: double.infinity,
    //                       padding: const EdgeInsetsDirectional.only(
    //                           start: 14, top: 15, bottom: 15, end: 25),
    //                       decoration: BoxDecoration(
    //                           color: HexColor.fromHex('#2b2b33'),
    //                           borderRadius: const BorderRadius.only(
    //                               topLeft: Radius.circular(20),
    //                               bottomLeft: Radius.circular(20))),
    //                       child: Row(
    //                         mainAxisAlignment:
    //                             MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           GeneralText(selectedTime,
    //                               style: appTheme.typographies
    //                                   .interFontFamily.headline6
    //                                   .copyWith(
    //                                       color:
    //                                           HexColor.fromHex('#b0c18b'),
    //                                       fontSize: 36,
    //                                       fontWeight: FontWeight.normal)),
    //                           GeneralText(selectedDay,
    //
    //                               // GeneralText(item.scheduledDate,
    //                               style: appTheme.typographies
    //                                   .interFontFamily.headline6
    //                                   .copyWith(
    //                                       color:
    //                                           HexColor.fromHex('#909094'),
    //                                       fontSize: 36,
    //                                       fontWeight: FontWeight.normal)),
    //                         ],
    //                       )),
    //                   SizedBox(
    //                     height: DeviceHelper.height * 0.02,
    //                   ),
    //                   Container(
    //                       width: double.infinity,
    //                       padding: const EdgeInsetsDirectional.only(
    //                           start: 14, top: 15, bottom: 15, end: 15),
    //                       decoration: BoxDecoration(
    //                           color: HexColor.fromHex('#2b2b33'),
    //                           borderRadius: const BorderRadius.only(
    //                               topLeft: Radius.circular(20),
    //                               bottomLeft: Radius.circular(20))),
    //                       child: Wrap(
    //                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Column(
    //                             crossAxisAlignment:
    //                                 CrossAxisAlignment.start,
    //                             children: [
    //                               GeneralText(Strings.noOfPersonsLabel,
    //                                   style: appTheme.typographies
    //                                       .interFontFamily.headline6
    //                                       .copyWith(
    //                                           color: HexColor.fromHex(
    //                                               '#fee4a4'),
    //                                           fontSize: 14,
    //                                           fontWeight: FontWeight.w700)),
    //                               SizedBox(
    //                                 height: DeviceHelper.height * 0.01,
    //                               ),
    //
    //                               ///no of persons and preference
    //                               Row(
    //                                 children: [
    //                                   ///persons text-field
    //                                   Container(
    //                                     width: DeviceHelper.width * 0.16,
    //                                     height: DeviceHelper.height * 0.065,
    //                                     decoration: BoxDecoration(
    //                                         color:
    //                                             HexColor.fromHex('#2b2b33'),
    //                                         border: Border.all(
    //                                             color: HexColor.fromHex(
    //                                                 '#f1c452')),
    //                                         borderRadius:
    //                                             BorderRadius.circular(10)),
    //                                     // padding: EdgeInsetsDirectional.only(
    //                                     //     top: 8, bottom: 8, start: 16, end: 16),
    //                                     margin: const EdgeInsetsDirectional
    //                                         .only(bottom: 8),
    //                                     child: noOfPersonsField(
    //                                       appTheme: appTheme,
    //                                       valueStyle: appTheme.typographies
    //                                           .interFontFamily.body1
    //                                           .copyWith(
    //                                         color: Colors.white,
    //                                         fontSize: 14,
    //                                         fontWeight: FontWeight.w400,
    //                                       ),
    //                                       hintStyle: appTheme.typographies
    //                                           .interFontFamily.body1
    //                                           .copyWith(
    //                                         color: Colors.white,
    //                                         fontSize: 14,
    //                                         fontWeight: FontWeight.w400,
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   SizedBox(
    //                                     width: DeviceHelper.width * 0.05,
    //                                   ),
    //
    //                                   ///preference dropdown
    //                                   Container(
    //                                     width: DeviceHelper.width * 0.33,
    //                                     height: DeviceHelper.height * 0.07,
    //                                     alignment: Alignment.center,
    //                                     decoration: BoxDecoration(
    //                                         //color: Colors.red,
    //                                         color:
    //                                             HexColor.fromHex('#2b2b33'),
    //                                         border: Border.all(
    //                                             color: HexColor.fromHex(
    //                                                 '#f1c452')),
    //                                         borderRadius:
    //                                             BorderRadius.circular(10)),
    //                                     margin: const EdgeInsetsDirectional
    //                                         .only(bottom: 6),
    //                                     // padding: const EdgeInsetsDirectional
    //                                     //         .only(
    //                                     //     top: 8,
    //                                     //     bottom: 8,
    //                                     //     start: 0,
    //                                     //     end: 0),
    //                                     child: Center(
    //                                       child: GeneralDropdown(
    //                                         selectedItemId: 1,
    //                                         borderColor: Colors.transparent,
    //                                         name: Strings.tableSelect,
    //                                         style: appTheme.typographies
    //                                             .interFontFamily.headline6
    //                                             .copyWith(
    //                                                 color: Colors.white,
    //                                                 fontSize: 15,
    //                                                 fontWeight:
    //                                                     FontWeight.w400),
    //                                         // margin: 22.0,
    //                                         items: items,
    //                                         onChange: ({
    //                                           required String key,
    //                                           required dynamic value,
    //                                         }) {
    //                                           developer.log(
    //                                               ' Selected value from Drop Down is '
    //                                               '$value');
    //                                           _appService.state.orderHelper!
    //                                               .selectedCategory = value;
    //                                           widget.data
    //                                               ?.experiencePreferences
    //                                               ?.forEach((element) {
    //                                             if (element
    //                                                     .preferenceName ==
    //                                                 value) {
    //                                               _appService
    //                                                       .state
    //                                                       .orderHelper
    //                                                       ?.selectedPreferenceId =
    //                                                   int.parse(element
    //                                                       .preferenceId
    //                                                       .toString());
    //                                             }
    //                                           });
    //                                         },
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                               const SizedBox(
    //                                 height: 3,
    //                               ),
    //                               Row(
    //                                 children: [
    //                                   SvgPicture.asset(
    //                                     Resources.peopleIconSvg,
    //                                     height: 12.5,
    //                                     color: HexColor.fromHex('#ea7458'),
    //                                   ),
    //                                   const SizedBox(width: 4),
    //                                   GeneralText(Strings.maxLimitLabel,
    //                                       style: appTheme.typographies
    //                                           .interFontFamily.headline6
    //                                           .copyWith(
    //                                               color: HexColor.fromHex(
    //                                                   '#ea7458'),
    //                                               fontSize: 14)),
    //                                   GeneralText(openCapacity.toString(),
    //                                       style: appTheme.typographies
    //                                           .interFontFamily.headline6
    //                                           .copyWith(
    //                                               color: HexColor.fromHex(
    //                                                   '#ea7458'),
    //                                               fontWeight:
    //                                                   FontWeight.bold,
    //                                               fontSize: 14)),
    //                                 ],
    //                               ),
    //                             ],
    //                           ),
    //                         ],
    //                       )),
    //                   const SizedBox(
    //                     height: 14,
    //                   ),
    //                   Container(
    //                       width: double.infinity,
    //                       padding: const EdgeInsetsDirectional.only(
    //                           start: 14, top: 15, bottom: 15, end: 25),
    //                       decoration: BoxDecoration(
    //                           color: HexColor.fromHex('#2b2b33'),
    //                           borderRadius: const BorderRadius.only(
    //                               topLeft: Radius.circular(20),
    //                               bottomLeft: Radius.circular(20))),
    //                       child: Wrap(
    //                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Column(
    //                             crossAxisAlignment:
    //                                 CrossAxisAlignment.start,
    //                             children: [
    //                               GeneralText(Strings.notesLabel,
    //                                   style: appTheme.typographies
    //                                       .interFontFamily.headline6
    //                                       .copyWith(
    //                                           color: HexColor.fromHex(
    //                                               '#fee4a4'),
    //                                           fontSize: 14,
    //                                           fontWeight: FontWeight.w700)),
    //                               const SizedBox(
    //                                 height: 9,
    //                               ),
    //                               Container(
    //                                 // width: 61,
    //                                 decoration: BoxDecoration(
    //                                     color: HexColor.fromHex('#2b2b33'),
    //                                     border: Border.all(
    //                                         color: HexColor.fromHex(
    //                                             '#f1c452')),
    //                                     borderRadius:
    //                                         BorderRadius.circular(10)),
    //                                 // padding: EdgeInsetsDirectional.only(
    //                                 //     top: 8, bottom: 8, start: 16, end: 16),
    //                                 margin:
    //                                     const EdgeInsetsDirectional.only(
    //                                         bottom: 8),
    //                                 child: notesField(
    //                                   appTheme: appTheme,
    //                                   valueStyle: appTheme.typographies
    //                                       .interFontFamily.body1
    //                                       .copyWith(
    //                                     color: Colors.white,
    //                                     fontSize: 14,
    //                                     fontWeight: FontWeight.w400,
    //                                   ),
    //                                   hintStyle: appTheme.typographies
    //                                       .interFontFamily.body1
    //                                       .copyWith(
    //                                     color:
    //                                         Colors.white.withOpacity(0.4),
    //                                     fontSize: 14,
    //                                     fontWeight: FontWeight.w400,
    //                                   ),
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ],
    //                       )),
    //                 ],
    //               ),
    //             )
    //           ],
    //         ),
    //         const SizedBox(
    //           height: 160,
    //         ),
    //       ],
    //     ),
    //   )

    ///for select time slot see this stack widget
    // :
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.scheduleModel.t.daysGroups.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              var item = widget.scheduleModel.t.daysGroups[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      _appService.state.orderHelper!.daysGroup =
                          widget.scheduleModel.t.daysGroups[index];
                      selectedDay =
                          InfininURLHelpers.dayOfMonth(item.scheduledDate);
                      selectedMonth = months[item.scheduledDate.month - 1];
                      selectedDate = item.scheduledDate.day.toString();
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        displayScheduleTime(
                          item.hours,
                          item.scheduledDate,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: DeviceHelper.height * 0.05,
                  ),
                ],
              );
            }),
        GeneralText(
          Strings.anotherTimeText, // Strings.labelSeaFood2Experience,
          style: appTheme.typographies.interFontFamily.headline2.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: const Color(0xffeee0c1),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: DeviceHelper.width * 0.40,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                //borderRadius: BorderRadius.zero, //Rectangular border
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 6,
              ),
            ),
            child: const GeneralText(
              Strings.moreOptionButtonTitle,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  String getMonth(DateTime _date) {
    //var dateData = DateFormat('EEEE').format(_date);
    selectedMonth = months[_date.month - 1];
    return selectedMonth;
  }

  String getWeekDay(DateTime _date) {
    selectedMonth = weekDays[_date.weekday - 1];
    return selectedMonth;
  }

  Widget displayScheduleTime(List<Hour> _hours, DateTime scheduledDate) {
    final appTheme = AppTheme.of(context).theme;
    return Expanded(
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 12, top: 15, bottom: 12),
          decoration: BoxDecoration(
              color: HexColor.fromHex('#2b2b33'),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GeneralText(
                  '${InfininURLHelpers.dayOfMonth(scheduledDate)}, ${getMonth(scheduledDate)} ${scheduledDate.day}',
                  style: appTheme.typographies.interFontFamily.headline6
                      .copyWith(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700)),
              timeSelectorBox(
                appTheme,
                _hours[0].startTime.toString(),
                _hours[0],
                scheduledDate,
                showSelectedTime: _appService.state.orderHelper!.scheduleId ==
                        _hours[0].scheduleId.toString()
                    ? true
                    : false,
              ),
              const SizedBox(
                height: 15,
              ),
              const Row(
                children: [
                  GeneralText(
                    'SAR. 350', // Strings.labelSeaFood2Experience,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Color(0xfff1c452),
                    ),
                  ),
                  GeneralText(
                    " /Person", // Strings.labelSeaFood2Experience,
                    style: TextStyle(
                      fontSize: 13,
                      //fontWeight: FontWeight.w500,
                      color: Color(0xff909094),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              GeneralButton.button(
                title: Strings.chooseButtonTitle,
                styleType: ButtonStyleType.fill,
                onTap: () {
                  //_videoPlayerController1.dispose();
                  //_chewieController.dispose();
                  if (widget.data!.priceTypeId == 2) {
                    int a = 0;
                    for (var element in bookingMenuDetails) {
                      if (element.quantity != 0) {
                        a = 1;
                      }
                    }
                    if (a == 1) {
                      bookingMenuDetails
                          .removeWhere((element) => element.quantity == 0);
                      _appService.state.orderHelper?.bookingMenuDetails =
                          bookingMenuDetails;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OrderDetailScreen(
                                data: widget.data,
                                scheduleModel: widget.scheduleModel,
                              )));
                    } else {
                      Toaster.errorToast(
                          context: context, message: Strings.selectAtLeastOne);
                    }
                  }

                  // locateService<INavigationService>()
                  //     .navigateTo(route: BottomBarRoute());
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => BottomBar(),
                  //     //  HomeScreen(),
                  //   ),
                  // );
                  //    viewModel.goToForgotPasswordScreen();
                },
              )
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
                                        name: Strings.tableSelect,
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
        SizedBox(
          height: DeviceHelper.height * 0.05,
        ),
        Row(
          children: [
            Container(
              color: HexColor.fromHex('#f1c452'),
              width: 16,
              height: 1,
            ),
            SizedBox(
              width: DeviceHelper.width * 0.01,
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
        SizedBox(
          height: DeviceHelper.height * 0.01,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 23),
          child: GeneralText(
            //  Strings.productDetailAboutSubTitle,
            // 'Test',
            widget.data!.description.toString(),
            maxLines: 3,
            style: appTheme.typographies.interFontFamily.headline6.copyWith(
                fontSize: 14,
                color: HexColor.fromHex('#ffffff'),
                fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: DeviceHelper.height * 0.04,
        ),
        Row(
          children: [
            Container(
              color: HexColor.fromHex('#f1c452'),
              width: 16,
              height: 1,
            ),
            SizedBox(
              width: DeviceHelper.width * 0.01,
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
        SizedBox(
          height: DeviceHelper.height * 0.03,
        ),

        ///wow factors
        wowFactors(appTheme, wowFactorsList),
        SizedBox(
          height: DeviceHelper.height * 0.03,
        ),

        ///preferences and no of persons section in this row
        Row(
          children: [
            Container(
              color: HexColor.fromHex('#f1c452'),
              width: 16,
              height: 1,
            ),
            SizedBox(
              width: DeviceHelper.width * 0.01,
            ),
            GeneralText(
              Strings.foodDetailPreferences,
              style: appTheme.typographies.interFontFamily.headline6.copyWith(
                fontSize: 20,
                color: HexColor.fromHex('#f1c452'),
              ),
            ),
          ],
        ),
        SizedBox(
          height: DeviceHelper.height * 0.012,
        ),
        wowFactors(appTheme, preferencesList),
        SizedBox(
          height: DeviceHelper.height * 0.012,
        ),
        Row(
          children: [
            Container(
              color: HexColor.fromHex('#f1c452'),
              width: 16,
              height: 1,
            ),
            SizedBox(
              width: DeviceHelper.width * 0.01,
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
        SizedBox(
          height: DeviceHelper.height * 0.01,
        ),
        GeneralText(
          Strings.locationAfterOrderConfirm,
          maxLines: 2,
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
            fontSize: 11,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: DeviceHelper.height * 0.10,
        ),

        ///Google map
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
                widget.data!.latitude ?? 0.0,
                widget.data!.longitude ?? 0.0,
              ),
              zoom: 14.4746,
            ),
            markers: <Marker>{
              Marker(
                  markerId: const MarkerId('SomeId'),
                  position: LatLng(
                    widget.data!.latitude ?? 0.0,
                    widget.data!.longitude ?? 0.0,
                  ),
                  infoWindow: const InfoWindow(title: '')),
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              controller.setMapStyle(darkMapStyle);
            },
          ),
        ),
        SizedBox(
          height: DeviceHelper.height * 0.15,
        ),
      ],
    );
  }

  Widget experienceDetailView(BuildContext context, IAppThemeData appTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GeneralText(
                  Strings.hostedBy, // Strings.labelSeaFood2Experience,
                  style:
                      appTheme.typographies.interFontFamily.headline2.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffeee0c1),
                  ),
                ),
                GeneralText(
                  '${widget.data!.chefName}', // Strings.labelSeaFood2Experience,
                  style:
                      appTheme.typographies.interFontFamily.headline6.copyWith(
                    fontSize: 13,
                    //fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: DeviceHelper.width * 0.07,
                child: CircleAvatar(
                  radius: DeviceHelper.width * 0.07,
                  backgroundImage: NetworkImage(Api.baseURLForImages +
                      widget.chefData.t!.profileImageUrl.toString()),
                ),
              ),
              onTap: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        UserProfile(chefData: widget.chefData)));
              },
            ),
          ],
        ),
        getDivider(),
        GeneralText(
          Strings.foodDetailAboutTitle, // Strings.labelSeaFood2Experience,
          style: appTheme.typographies.interFontFamily.headline2.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: const Color(0xffeee0c1),
          ),
        ),
        SizedBox(height: DeviceHelper.height * 0.01),
        GeneralText(
          "${widget.data?.description}", // Strings.labelSeaFood2Experience,
          style: appTheme.typographies.interFontFamily.headline2.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: const Color(0xff909094),
          ),
        ),
        getDivider(),
        GeneralText(
          Strings
              .productDetailWowFactorTitle, // Strings.labelSeaFood2Experience,
          style: appTheme.typographies.interFontFamily.headline2.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: const Color(0xffeee0c1),
          ),
        ),
        SizedBox(height: DeviceHelper.height * 0.02),
        wowFactors(appTheme, wowFactorsList),
        getDivider(),
        GeneralText(
          Strings.foodDetailPreferences, // Strings.labelSeaFood2Experience,
          style: appTheme.typographies.interFontFamily.headline2.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: const Color(0xffeee0c1),
          ),
        ),
        SizedBox(height: DeviceHelper.height * 0.02),
        wowFactors(appTheme, preferencesList),
        getDivider(),
        GeneralText(
          Strings.foodDetailLocation, // Strings.labelSeaFood2Experience,
          style: appTheme.typographies.interFontFamily.headline2.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: const Color(0xffeee0c1),
          ),
        ),
        SizedBox(height: DeviceHelper.height * 0.03),
        Container(
          height: DeviceHelper.height * 0.60,
          width: MediaQuery.of(context).size.width,
          transform: Matrix4.translationValues(0, 0, 0.0),
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
                widget.data!.latitude ?? 0.0,
                widget.data!.longitude ?? 0.0,
              ),
              zoom: 14.4746,
            ),
            markers: <Marker>{
              Marker(
                  markerId: const MarkerId('SomeId'),
                  position: LatLng(
                    widget.data!.latitude ?? 0.0,
                    widget.data!.longitude ?? 0.0,
                  ),
                  infoWindow: const InfoWindow(title: '')),
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              controller.setMapStyle(darkMapStyle);
            },
          ),
        ),
        SizedBox(height: DeviceHelper.height * 0.10),
      ],
    );
  }

  Widget wowFactors(IAppThemeData appTheme, List<CustomModel> items) {
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
                        ? Api.baseURLForImages + items[i].name.toString()
                        : '',
                    fit: BoxFit.cover,
                    width: 35,
                    color: const Color(0xfff1c452),
                  ),
                  SizedBox(height: DeviceHelper.height * 0.02),
                  GeneralText(
                    items[i].icon ?? "",
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

  Widget timeSelectorBox(IAppThemeData appTheme, String displayTime, Hour _hour,
      DateTime scheduledDate,
      {bool showSelectedTime = false}) {
    var finalDate = '';
    //finalDate = InfininURLHelpers.getAmPm(displayTime);
    finalDate = DateFormat.jm().format(scheduledDate);

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
          orderHelper.selectedCategory =
              widget.data!.experiencePreferences![0].preferenceName.toString();
          orderHelper.selectedPreferenceId = int.parse(
              widget.data!.experiencePreferences![0].preferenceId.toString());
          //.data!.persons;
          _appService.updateOrderHelper(orderHelper);
          //_appService.updateScheduleId(scheduleId)
          setState(() {
            showSelectedTime = true;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: GeneralText('$finalDate - $finalDate',
                  style: appTheme.typographies.interFontFamily.body1
                      .copyWith(color: Colors.white, fontSize: 16)),
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
            developer.log(' New Value of Persons $newValue');

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

class MenuItem {
  int menuId;
  int quantity;

  MenuItem({required this.menuId, required this.quantity});
}
