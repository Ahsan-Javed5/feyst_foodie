import 'package:chef/constants/constants.dart';
import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/home/home_response.dart' as home_data;
import 'package:chef/screens/home/popular_food_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/color_helper.dart';
import '../../models/home/experience_list_response.dart' as experience_data;
import '../../theme/app_theme_widget.dart';
import '../../ui_kit/widgets/general_new_appbar.dart';
import '../../ui_kit/widgets/general_text.dart';
import 'component/food_detail_screen_v.dart';
import 'food_details_menu_model.dart';
import 'home_screen_m.dart';
import 'home_screen_vm.dart';
import 'package:marqueer/marqueer.dart';

import 'dart:developer' as developer;

class HomeScreen extends BaseView<HomeScreenViewModel> {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(
      {required BuildContext context, required ScreenSizeData screenSizeData}) {
    return BlocBuilder<HomeScreenViewModel, HomeScreenState>(
        bloc: viewModel..fetchData(context: context),
        builder: (_, state) {
          return WillPopScope(
            child: Scaffold(
                backgroundColor: const Color(0xff212129),
                body: state.when(
                  initialized: displayInitialized,
                  loading: displayLoading,
                  loaded: (homeResponse) => displayLoaded(
                    context: context,
                    homeResponseData: homeResponse,
                    //foodMenuDetail: foodMenuDetail,
                  ),
                )),
            onWillPop: () => onWillPop(),
          );
        });
  }

  Future<bool> onWillPop() async {
    return false;
  }

  Widget displayInitialized() {
    return Container();
  }

  Widget displayLoading() {
    return Container();
  }

  Widget displayLoaded({
    required BuildContext context,
    required home_data.HomeResponse homeResponseData,
    //  required FoodMenuModel foodMenuDetail,
    // required
  }) {
    final appTheme = AppTheme.of(context).theme;
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///explore container
              Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 250,
                        width: double.infinity,
                        child: Image.asset(
                          Resources.homeScreenBG,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 31),
                        child: GeneralText(
                          Strings.labelExplore,
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                            fontSize: 35,
                            // fontFamily: 'Poppins-Medium',
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 31),
                        child: GeneralText(
                          Strings.labelFoodExperience,
                          style: appTheme.typographies.interFontFamily.headline4
                              .copyWith(
                            fontSize: 29,
                            fontFamily: 'Poppins-Medium',
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              ///experiences horizontal list
              Container(
                height: 250,
                padding: const EdgeInsets.only(left: 31),
                child: ListView.builder(
                   // itemCount: 10,
                    itemCount: homeResponseData.t?.experiences?.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return _FoodContainer(
                        appTheme: appTheme,
                        data: homeResponseData.t?.experiences![(homeResponseData.t!.experiences!.length - 1)-index],
                        //  foodMenuDetail: foodMenuDetail,
                      );
                    }),
              ),
              ///popular dishes label
              Container(
                padding: const EdgeInsets.only(left: 31, bottom: 0),
                child: GeneralText(
                  Strings.labelPopularDishes,
                  style:
                      appTheme.typographies.interFontFamily.headline6.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xfff1c452),
                  ),
                ),
              ),
              ///popular dishes grid
              Container(
                margin: const EdgeInsets.only(right: 20, left: 20, top: 4),
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.61,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                  ),
                  itemCount: homeResponseData.t!.experienceMenus!.length,
                  itemBuilder: (context, index) {
                    return _PopularDishes(
                        appTheme: appTheme, dishData: homeResponseData.t!.experienceMenus![index], experiencesList: homeResponseData.t!.experiences,);
                  },
                ),
              ),
              // Center(child: _letsStartedButtonTitle(appTheme: appTheme)),
              // const SizedBox(
              //   height: 20,
              // ),
            ],
          ),
        )
      ],
    );
  }
}

class _PopularDishes extends StatelessWidget {
  const _PopularDishes({
    Key? key,
    required this.appTheme,
    required this.dishData,
    required this.experiencesList,
  }) : super(key: key);

  final IAppThemeData appTheme;
  final home_data.ExperienceMenus dishData;
  final List<home_data.Experiences>? experiencesList;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PopularFoodDetails()),
        );
      },
      child: Container(
        // height: 170,
        width: 170,
        padding: const EdgeInsets.only(left: 13),
        decoration: BoxDecoration(
          color: HexColor.fromHex("#4b4b52"),
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(40),
            bottomLeft: Radius.circular(40),
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Stack(
            children: [
              Positioned(
                right: -50,
                top: -20,
                child: Container(
                  height: 180,
                  width: 180,
                  padding: const EdgeInsetsDirectional.only(bottom: 20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/icons/ring_placeholder_dashboard.png'),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    dishData.pictureUrl.toString(),
                    // height: 130,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GeneralText(
                      dishData.dish.toString(), //'Sindhi\nBiryani',
                      textAlign: TextAlign.left,
                      style: appTheme.typographies.interFontFamily.headline2
                          .copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    GeneralText(
                      'by Zee Lounge',
                      style: appTheme.typographies.interFontFamily.headline2
                          .copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff909094),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _FoodContainer extends StatelessWidget {
  const _FoodContainer({
    Key? key,
    required this.appTheme,
    required this.data,
    // required this.foodMenuDetail,
  }) : super(key: key);

  final IAppThemeData appTheme;
  final home_data.Experiences? data;
  // final FoodMenuModel foodMenuDetail;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        developer.log('Experience Id selected is ' + '${data?.id}');
        Navigator.push(
          context,
          // MaterialPageRoute(builder: (context) => const FoodDetailScreen()),
          MaterialPageRoute(
              builder: (context) => FoodDetailScreenView(
                    selectedExperienceId: data!.id.toString(),
                    experienceData: data!,
                    //  foodMenuDetail: foodMenuDetail,
                  )),
        );
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Stack(
            children: [
              Container(
                height: 264,
                width: 206,
                padding: const EdgeInsets.all(12),
                child: Container(
                    height: 264,
                    width: 206,
                    child: Image.asset(
                      Resources.seafoodPNG,
                      fit: BoxFit.cover,
                    )),
              ),
              Positioned.fill(
                top: 70,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 198,
                    height: 85,
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        color: Color(0xffbb3127),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                          bottomLeft: Radius.circular(12.0),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width:45,
                                    child: displayMarque(data!.title! +" ", appTheme
                                            .typographies.interFontFamily.headline2
                                            .copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),),
                                    // GeneralText(
                                    //   data.title,
                                    //   // 'test',
                                    //   style: appTheme
                                    //       .typographies.interFontFamily.headline2
                                    //       .copyWith(
                                    //     fontSize: 14,
                                    //     fontWeight: FontWeight.w400,
                                    //     color: Colors.white,
                                    //   ),
                                    // ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                     displayMarque(data!.description!+" ",appTheme
                                             .typographies.interFontFamily.headline2
                                             .copyWith(
                                           fontSize: 14,
                                           fontWeight: FontWeight.bold,
                                           color: Colors.white,
                                         ),),
                                  // GeneralText(
                                  //   data.description, // Strings.labelSeaFood2Experience,
                                  //   style: appTheme
                                  //       .typographies.interFontFamily.headline2
                                  //       .copyWith(
                                  //     fontSize: 14,
                                  //     fontWeight: FontWeight.bold,
                                  //     color: Colors.white,
                                  //   ),
                                  // ),
                                ],
                              ),
                              //    displayMarque(data.description),
                              const SizedBox(height: 10),
                              GeneralText(
                                "by " + data!.chefBrandName.toString(), // Strings.labelSeaFood2Experience,
                                style:appTheme.typographies.interFontFamily.headline2
                                    .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff909094),
                                ),
                              ),
                              GeneralText(
                                data!.chefAddress.toString(), // Strings.labelSeaFood2Experience,
                                style: appTheme
                                    .typographies.interFontFamily.headline2
                                    .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),

                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 1,
                        ),
                        SvgPicture.asset(
                          Resources.arrowRT,
                          height: 15,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget displayMarque(String _text, TextStyle style) {
    final _controller = MarqueerController();
    return SizedBox(
        height: 20,
        width: 100,
        child: Marqueer(
          // pps: 100,
          //
          // /// optional
          // controller: _controller,
          //
          // /// optional
          // restartAfterInteractionDuration: const Duration(seconds: 6),
          //
          // /// optional
          // restartAfterInteraction: false,
          //
          // /// optional
          // onChangeItemInViewPort: (index) {
          //   print('item index: $index');
          // },
          // onInteraction: () {
          //   print('on interaction callback');
          // },
          // onStarted: () {
          //   print('on started callback');
          // },
          // onStopped: () {
          //   print('on stopped callback');
          // },
          child: GeneralText(
            _text, // Strings.labelSeaFood2Experience,
            style: style,
            maxLines: 1,
          ),
        ));
  }
}
