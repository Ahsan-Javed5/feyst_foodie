import 'dart:ui';

import 'package:chef/constants/api.dart';
import 'package:chef/helpers/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/resources.dart';
import '../../constants/strings.dart';
import '../../models/home/chef_data_response.dart';
import '../../theme/app_theme_data/app_theme_data.dart';
import '../../theme/app_theme_widget.dart';
import '../../ui_kit/widgets/general_new_appbar.dart';
import '../../ui_kit/widgets/general_text.dart';
import '../food_product_experience_details/food_product_details_screen_v.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key, required this.chefData}) : super(key: key);

  ChefDataResponse chefData;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  List<SocialMediaHandles> handlesList = [];

  @override
  void initState() {
    // TODO: implement initState

    handlesList.addAll([
      SocialMediaHandles(
          socialMediaName: widget.chefData.t!.instagram.toString(),
          socialMediaIcon: "assets/images/icons/instagram_1.png",
          socialMediaLink: 'https://www.instagram.com/',
      ),
      SocialMediaHandles(
          socialMediaName: widget.chefData.t!.facebook.toString(),
          socialMediaIcon: "assets/images/icons/facebook.png",
        socialMediaLink: 'https://www.facebook.com/',
      ),
      SocialMediaHandles(
          socialMediaName: widget.chefData.t!.twitter.toString(),
          socialMediaIcon: "assets/images/icons/twitter.png",
        socialMediaLink: 'https://www.twitter.com/',
      ),
      SocialMediaHandles(
          socialMediaName: widget.chefData.t!.tiktok.toString(),
          socialMediaIcon: "assets/images/icons/tiktok.png",
        socialMediaLink: 'https://www.tiktok.com/',
      )
    ]);
    super.initState();
  }

  Future<bool> onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double _sigmaX = 8; // from 0-10
    double _sigmaY = 8; // from 0-10
    double _opacity = 1;
    final appTheme = AppTheme.of(context).theme;
    return WillPopScope(
        onWillPop: () => onWillPop(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [
              Container(
                  // decoration: BoxDecoration(
                  //   color: HexColor.fromHex("#212129").withOpacity(0.8),
                  // ),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/icons/user_blurred.jpeg'),
                          fit: BoxFit.cover)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                    child: Container(
                      color: HexColor.fromHex("#212129").withOpacity(0.96),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 70,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 18.0),
                            child: GeneralNewAppBar(
                              rightIcon: Resources.homeIconSvg,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CircleAvatar(
                            radius: 55,
                            backgroundImage: NetworkImage(Api.baseURLForImages+widget.chefData.t!.profileImageUrl.toString(),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) =>
                              //           FoodProductExperienceDetails()),
                              // );
                            },
                            child: GeneralText(
                              widget.chefData.t!.brandName.toString(),
                              style: appTheme
                                  .typographies.interFontFamily.headline6
                                  .copyWith(
                                      fontSize: 25,
                                      color: HexColor.fromHex('#f1c452'),
                                      fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(
                            height: 38,
                          ),
                        ],
                      ),
                    ),
                  )),
              Container(
                padding: const EdgeInsetsDirectional.only(
                    top: 10, bottom: 10, start: 23),
                color: HexColor.fromHex("#2c292b"),
                child: Row(
                  children: [
                    GeneralText(
                      Strings.userProfileDetailsLabel,
                      style: appTheme.typographies.interFontFamily.headline6
                          .copyWith(
                              fontSize: 20,
                              color: HexColor.fromHex('#f1c452'),
                              fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                  color: HexColor.fromHex("#212129"),
                  padding: const EdgeInsetsDirectional.only(
                      start: 23, end: 23, top: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getQuestion(
                          appTheme, widget.chefData.t!.chefQuestionAnswers![0]),
                      const SizedBox(
                        height: 38,
                      ),
                      getSecondQuestion(
                          appTheme, widget.chefData.t!.chefQuestionAnswers![1]),
                      const SizedBox(
                        height: 38,
                      ),
                      userInterest(
                        appTheme,
                      ),
                      const SizedBox(
                        height: 38,
                      ),
                      socialMediaHandles(appTheme),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
            ]),
          ),
        ));
  }

  Widget getQuestion(
      IAppThemeData appTheme, ChefQuestionAnswers chefQuestionAnswer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralText(
          chefQuestionAnswer.question!.name.toString(),
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
              fontSize: 16,
              color: HexColor.fromHex('#fee4a4'),
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        GeneralText(
          chefQuestionAnswer.answers![0].name.toString(),
          maxLines: 2,
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
              fontSize: 15,
              color: HexColor.fromHex('#909094'),
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget getSecondQuestion(
      IAppThemeData appTheme, ChefQuestionAnswers chefQuestionAnswer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralText(
          chefQuestionAnswer.question!.name.toString(),
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
              fontSize: 16,
              color: HexColor.fromHex('#fee4a4'),
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        GeneralText(
          chefQuestionAnswer.inputAnswer.toString(),
          maxLines: 2,
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
              fontSize: 15,
              color: HexColor.fromHex('#909094'),
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget userInterest(IAppThemeData appTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralText(
          Strings.userProfileYourInterestLabel,
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
              fontSize: 18,
              color: HexColor.fromHex('#fee4a4'),
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for(int k = 0; k < widget.chefData.t!.chefQuestionAnswers![2]
                  .answers!.length; k++ )
              Padding(
                padding: const EdgeInsets.only(right: 15,),
                child: Column(
                  children: [
                    Container(
                      width : 60,
                      height: 60,
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
                        decoration: BoxDecoration(
                          color: HexColor.fromHex("#f1c452"),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.network(
                            Api.baseURLForImages + widget.chefData.t!.chefQuestionAnswers![2]
                                .answers![k].iconPath
                                .toString(),
                        ),
                      ),
                    ),
                    GeneralText(
                      widget.chefData.t!.chefQuestionAnswers![2]
                          .answers![k].name
                          .toString(),
                      style:
                          appTheme.typographies.interFontFamily.headline6.copyWith(
                        fontSize: 14,
                        color: HexColor.fromHex('#ffffff'),
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(
              //   width: 30,
              // ),
              // Column(
              //   children: [
              //     Container(
              //       width: 58,
              //       padding: const EdgeInsetsDirectional.all(10),
              //       decoration: const BoxDecoration(
              //         image: DecorationImage(
              //           image: AssetImage(
              //               'assets/images/icons/food_item_circle.png'),
              //           fit: BoxFit.fill,
              //         ),
              //         shape: BoxShape.circle,
              //       ),
              //       child: Image.asset(
              //         'assets/images/icons/food_item_sample.png',
              //       ),
              //     ),
              //     GeneralText(
              //       widget.chefData.t!.chefQuestionAnswers![2].answers![1].name
              //           .toString(),
              //       style:
              //           appTheme.typographies.interFontFamily.headline6.copyWith(
              //         fontSize: 14,
              //         color: HexColor.fromHex('#ffffff'),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        )
      ],
    );
  }

  Widget socialMediaHandles(IAppThemeData appTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralText(
          Strings.userProfileSocialMediaLabel,
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
              fontSize: 18,
              color: HexColor.fromHex('#fee4a4'),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 15,),
        GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 19,
              crossAxisSpacing: 20,
              childAspectRatio: 5.5,
            ),
            itemCount: handlesList.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Container(
                  padding: const EdgeInsets.only(left: 10,top: 10,bottom: 10,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.yellow,),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        padding: const EdgeInsetsDirectional.all(6),
                        decoration: BoxDecoration(
                            color: HexColor.fromHex("#4b4b52"),
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          handlesList[index].socialMediaIcon ?? "",
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: GeneralText(
                          handlesList[index].socialMediaName ?? "",
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                            fontSize: 14,
                            color: HexColor.fromHex('#ffffff'),
                            decoration: TextDecoration.underline,
                          ),
                          //maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () async {
                  await launchUrl(Uri.parse('${handlesList[index].socialMediaName}'),);
                },
              );
            }),
      ],
    );
  }
}

class SocialMediaHandles {
  String? socialMediaName;
  String? socialMediaIcon;
  String? socialMediaLink;

  SocialMediaHandles({this.socialMediaIcon, this.socialMediaName, this.socialMediaLink});
}
