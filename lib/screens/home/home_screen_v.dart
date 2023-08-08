import 'package:chef/constants/constants.dart';
import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/home/home_response.dart' as home_data;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/color_helper.dart';
import '../../models/home/experience_list_response.dart' as experience_data;
import 'component/food_detail_screen_v.dart';
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
    return const Center(child: CircularProgressIndicator());
  }

  Widget displayLoaded({
    required BuildContext context,
    required home_data.HomeResponse homeResponseData,
    //  required FoodMenuModel foodMenuDetail,
    // required
  }) {
    final appTheme = AppTheme.of(context).theme;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///explore container
          Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: DeviceHelper.height * 0.30,
                    //height: 250,
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
                  SizedBox(
                    height: DeviceHelper.height * 0.10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 31),
                    child: GeneralText(
                      Strings.labelExplore,
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: DeviceHelper.height * 0.005,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 31),
                    child: GeneralText(
                      Strings.labelFoodExperience,
                      style: appTheme.typographies.interFontFamily.headline4
                          .copyWith(
                        fontSize: 25,
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
            height: DeviceHelper.height * 0.37,
            padding: const EdgeInsets.only(left: 31),
            child: ListView.separated(
                // itemCount: 10,
                itemCount: homeResponseData.t!.allExperience!.length,
                physics: const BouncingScrollPhysics(),
                //itemExtent: DeviceHelper.width * 0.52,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: DeviceHelper.width * 0.05),
                    child: _FoodContainer(
                      appTheme: appTheme,
                      data: homeResponseData.t?.allExperience![
                         // (homeResponseData.t!.allExperience!.length - 1) -
                              index],
                      //  foodMenuDetail: foodMenuDetail,
                    ),
                  );
                },
              separatorBuilder: (context, index) => const SizedBox(width: 10,),
            ),
          ),
          SizedBox(
            height: DeviceHelper.height * 0.008,
          ),

          ///popular Experiences
          Container(
            padding: const EdgeInsets.only(left: 31, bottom: 0),
            child: GeneralText(
              Strings.labelPopularExperiences,
              style:
                  appTheme.typographies.interFontFamily.headline6.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xfff1c452),
              ),
            ),
          ),
          SizedBox(height: DeviceHelper.height * 0.02),

          ///popular experiences grid
          Container(
            margin: const EdgeInsets.only(right: 20, left: 20, top: 4),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.61,
                crossAxisSpacing: DeviceHelper.height * 0.025,
                mainAxisSpacing: DeviceHelper.height * 0.025,
              ),
              itemCount: homeResponseData.t!.popularExperiences!.length,
              itemBuilder: (context, index) {
                return _PopularExperience(
                  appTheme: appTheme,
                  popularExperience:
                      homeResponseData.t!.popularExperiences![index],
                  allExperiences: homeResponseData.t!.allExperience,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PopularExperience extends StatelessWidget {
  const _PopularExperience({
    Key? key,
    required this.appTheme,
    required this.popularExperience,
    required this.allExperiences,
  }) : super(key: key);

  final IAppThemeData appTheme;
  final home_data.Experiences? popularExperience;
  final List<home_data.Experiences>? allExperiences;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          // MaterialPageRoute(builder: (context) => const FoodDetailScreen()),
          MaterialPageRoute(
              builder: (context) => FoodDetailScreenView(
                    selectedExperienceId: popularExperience!.id.toString(),
                    experienceData: popularExperience!,
                    //  foodMenuDetail: foodMenuDetail,
                  )),
        );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const PopularFoodDetails()),
        // );
      },
      child: Container(
        // height: 170,
        width: DeviceHelper.width * 0.46,
        padding: EdgeInsets.only(left: DeviceHelper.height * 0.012),
        decoration: BoxDecoration(
          color: HexColor.fromHex("#4b4b52"),
          borderRadius: BorderRadius.all(Radius.circular(DeviceHelper.height * 0.05,),),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(DeviceHelper.height * 0.05),
          child: Stack(
            children: [
              Positioned(
                right: -55,
                top: -25,
                child: Container(
                  height: DeviceHelper.height * 0.25,
                  width: DeviceHelper.height * 0.25,
                  padding: EdgeInsetsDirectional.only(bottom: DeviceHelper.height * 0.025),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/icons/ring_placeholder_dashboard.png'),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    width: DeviceHelper.width * 0.22,
                    height: DeviceHelper.height * 0.18,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Resources.seafoodPNG),
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const SizedBox(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: DeviceHelper.height * 0.015, top: DeviceHelper.height * 0.07,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GeneralText(
                      popularExperience!.title.toString(), //'Sindhi\nBiryani',
                      textAlign: TextAlign.left,
                      style: appTheme.typographies.interFontFamily.headline2
                          .copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    GeneralText(
                      popularExperience!.chefBrandName.toString(),
                      style: appTheme.typographies.interFontFamily.headline2
                          .copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff909094),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Color(0xff909094),
                          size: 16,
                        ),
                        SizedBox(width: DeviceHelper.width * 0.015,),
                        GeneralText(
                          popularExperience?.cityName ?? 'Lahore',
                          style: appTheme.typographies.interFontFamily.headline2
                              .copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff909094),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: DeviceHelper.height * 0.015,
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
      child: SizedBox(
          height: DeviceHelper.height * 0.35,
          width: DeviceHelper.width * 0.55,
          //color: Colors.red,
          //alignment: Alignment.centerRight,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(DeviceHelper.width * 0.07),
                  child: SizedBox(
                    height: DeviceHelper.height * 0.35,
                    width: DeviceHelper.width * 0.52,
                    //padding: const EdgeInsets.only(left: 12),
                    child: Image.asset(
                      Resources.seafoodPNG,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                top: 70,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: DeviceHelper.width * 0.55,
                    height: DeviceHelper.height * 0.12,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: const Color(0xffbb3127),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(DeviceHelper.width * 0.03),
                          topRight: Radius.circular(DeviceHelper.width * 0.03),
                          bottomLeft: Radius.circular(DeviceHelper.width * 0.03),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: DeviceHelper.width * 0.45,
                                child: GeneralText(
                                  data!.title!, // Strings.labelSeaFood2Experience,
                                  style: appTheme
                                      .typographies.interFontFamily.headline2
                                      .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: DeviceHelper.height * 0.01),
                              GeneralText(
                                "by " +
                                    data!.chefBrandName
                                        .toString(), // Strings.labelSeaFood2Experience,
                                style: appTheme
                                    .typographies.interFontFamily.headline2
                                    .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff909094),
                                ),
                              ),
                              GeneralText(
                                data!.chefAddress
                                    .toString(), // Strings.labelSeaFood2Experience,
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
          /// optional
          restartAfterInteractionDuration: const Duration(seconds: 2),
          //
          /// optional
          restartAfterInteraction: true,
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
