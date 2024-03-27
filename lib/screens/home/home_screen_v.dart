import 'package:chef/firebase_messaging/notification_services.dart';
import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/home/home_response.dart' as home_data;
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../helpers/color_helper.dart';
import 'component/food_detail_screen_v.dart';
import 'home_screen_m.dart';
import 'home_screen_vm.dart';

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
            child: SafeArea(
              child: Scaffold(
                  backgroundColor: const Color(0xff212129),
                  body: state.when(
                    initialized: displayInitialized,
                    loading: displayLoading,
                    loaded: (homeResponse) => GestureDetector(
                      onVerticalDragEnd: (d) {
                        viewModel.fetchData(context: context);
                      },
                      child: displayLoaded(
                        context: context,
                        homeResponseData: homeResponse,
                        //foodMenuDetail: foodMenuDetail,
                      ),
                    ),
                  )),
            ),
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
    NotificationServices().fireBaseInit(context);
    NotificationServices().setupInteractMessage(context);
    NotificationServices().getDeviceToken();
    Future.delayed(const Duration(seconds: 3), () {
      return NotificationServices().requestNotificationPermission();
    });
    final appTheme = AppTheme.of(context).theme;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        bottom: 10,
        left: DeviceHelper.width * 0.06,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///explore container
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      Resources.homeFeystLogo,
                      width: 120,
                    ),
                    SizedBox(
                      height: DeviceHelper.height * 0.03,
                    ),
                    GeneralText(
                      Strings.labelExplore,
                      style: appTheme.typographies.interFontFamily.headline7
                          .copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xfffbeccb),
                      ),
                    ),
                    SizedBox(
                      height: DeviceHelper.height * 0.005,
                    ),
                    GeneralText(
                      Strings.labelFoodExperience,
                      style: appTheme.typographies.interFontFamily.headline4
                          .copyWith(
                        fontSize: 23,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w400,
                        color: const Color(0xfffbeccb),
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                width: DeviceHelper.width * 0.35,
                Resources.homeCurl,
                fit: BoxFit.cover,
              )
            ],
          ),
          SizedBox(height: DeviceHelper.height * 0.02),

          ///experiences list
          Container(
            height: DeviceHelper.height * 0.65,
            margin: EdgeInsets.only(
              right: DeviceHelper.width * 0.05,
            ),
            child: ListView.separated(
              // itemCount: 10,
              itemCount: homeResponseData.t!.allExperience!.length,
              physics: const BouncingScrollPhysics(),
              //itemExtent: DeviceHelper.width * 0.52,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: DeviceHelper.height * 0.01),
                  child: _FoodContainer(
                    appTheme: appTheme,
                    data: homeResponseData.t?.allExperience![
                        // (homeResponseData.t!.allExperience!.length - 1) -
                        index],
                    //  foodMenuDetail: foodMenuDetail,
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
            ),
          ),

          // SizedBox(
          //   height: DeviceHelper.height * 0.008,
          // ),
          // ///popular Experiences
          // Container(
          //   padding: const EdgeInsets.only(left: 31, bottom: 0),
          //   child: GeneralText(
          //     Strings.labelPopularExperiences,
          //     style: appTheme.typographies.interFontFamily.headline6.copyWith(
          //       fontSize: 20,
          //       fontWeight: FontWeight.w700,
          //       color: const Color(0xfff1c452),
          //     ),
          //   ),
          // ),
          // SizedBox(height: DeviceHelper.height * 0.02),
          // ///popular experiences grid
          // Container(
          //   margin: const EdgeInsets.only(right: 20, left: 20, top: 4),
          //   child: GridView.builder(
          //     padding: EdgeInsets.zero,
          //     physics: const NeverScrollableScrollPhysics(),
          //     shrinkWrap: true,
          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       childAspectRatio: 0.61,
          //       crossAxisSpacing: DeviceHelper.height * 0.025,
          //       mainAxisSpacing: DeviceHelper.height * 0.025,
          //     ),
          //     itemCount: homeResponseData.t!.popularExperiences!.length,
          //     itemBuilder: (context, index) {
          //       return _PopularExperience(
          //         appTheme: appTheme,
          //         popularExperience:
          //             homeResponseData.t!.popularExperiences![index],
          //         allExperiences: homeResponseData.t!.allExperience,
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  Future<void> getNotificationPermission() async {
    //Permission.notification.request();
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
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
          borderRadius: BorderRadius.all(
            Radius.circular(
              DeviceHelper.height * 0.05,
            ),
          ),
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
                  padding: EdgeInsetsDirectional.only(
                      bottom: DeviceHelper.height * 0.025),
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
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(Api.baseURLForImages +
                            popularExperience!.experienceMedia![0].mediaUrl
                                .toString()),
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const SizedBox(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: DeviceHelper.height * 0.015,
                  top: DeviceHelper.height * 0.07,
                ),
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
                        SizedBox(
                          width: DeviceHelper.width * 0.015,
                        ),
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
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FoodDetailScreenView(
                    selectedExperienceId: data!.id.toString(),
                    experienceData: data!,
                  )),
        );
      },
      child: SizedBox(
          width: DeviceHelper.width,
          child: Container(
            padding: EdgeInsets.only(bottom: DeviceHelper.height * 0.035),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DeviceHelper.width * 0.07),
              color: const Color(0xff34343e),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(DeviceHelper.width * 0.07),
                  child: SizedBox(
                    height: DeviceHelper.height * 0.37,
                    width: DeviceHelper.width,
                    //padding: const EdgeInsets.only(left: 12),
                    child: data!.experienceMedia!.isEmpty
                        ? Image.asset(
                            Resources.seafoodPNG,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            Api.baseURLForImages +
                                data!.experienceMedia![0].mediaUrl.toString(),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(
                  height: DeviceHelper.height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: DeviceHelper.width * 0.05,
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
                              data!.title!, // Strings.labelSeaFood2Experience,
                              style: appTheme
                                  .typographies.interFontFamily.headline2
                                  .copyWith(
                                fontSize: 18,
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
                                  data!.averageRating?.toString() ??
                                      '4.8', // Strings.labelSeaFood2Experience,
                                  style: appTheme
                                      .typographies.interFontFamily.headline2
                                      .copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xfffbeccb),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: DeviceHelper.height * 0.01),
                      GeneralText(
                        "${Strings.byText} ${data!.chefBrandName}", // Strings.labelSeaFood2Experience,
                        style: appTheme.typographies.interFontFamily.headline2
                            .copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff909094),
                        ),
                      ),
                      GeneralText(
                        '${data!.townName}, ${data!.cityName}', // Strings.labelSeaFood2Experience,
                        style: appTheme.typographies.interFontFamily.headline6
                            .copyWith(
                          fontSize: 14,
                          //fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: DeviceHelper.height * 0.02),
                      Row(
                        children: [
                          GeneralText(
                            'SAR. 350', // Strings.labelSeaFood2Experience,
                            style: appTheme
                                .typographies.interFontFamily.headline2
                                .copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xfff1c452),
                            ),
                          ),
                          GeneralText(
                            " /Person", // Strings.labelSeaFood2Experience,
                            style: appTheme
                                .typographies.interFontFamily.headline2
                                .copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff909094),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
