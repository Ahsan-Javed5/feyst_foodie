import 'dart:ui';

import 'package:chef/helpers/color_helper.dart';
import 'package:chef/helpers/helpers.dart';
import 'package:chef/screens/user_account/user_profile.dart';
import 'package:flutter/material.dart';

import '../../constants/resources.dart';
import '../../constants/strings.dart';
import '../../theme/app_theme_data/app_theme_data.dart';
import '../../theme/app_theme_widget.dart';
import '../../ui_kit/widgets/general_new_appbar.dart';
import '../../ui_kit/widgets/general_text.dart';
import '../food_product_experience_details/bbq_experience_details.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {



  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor.fromHex("#212129"),
        body: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Container(
              padding: EdgeInsets.only(left: 12, top: 20, bottom: 20),
              child: const GeneraNewAppBar(
                rightIcon: Resources.homeIconSvg,
                title: Strings.labelTitleReviews,
                titleColor: Colors.white,
              ),
            ),


            Expanded(
              child: ListView.separated(
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        GeneralText(
                          '11-04-2022',
                          style: appTheme.typographies.interFontFamily.headline6
                              .copyWith(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.4),
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [


                            CircleAvatar(
                        backgroundImage:
                        AssetImage(Resources.seafoodPNG)

                            ),

                            SizedBox(width: 30,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                Row(
                                  children: [
                                    GeneralText(
                                      'BBQ Experience',
                                      style: appTheme.typographies.interFontFamily.headline6
                                          .copyWith(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),  // radius of 10
                                          color: const Color(0xfff1c452),
                                        )
                                   ,
                                      padding: EdgeInsets.symmetric(horizontal: 7,vertical: 3),
                                      child: Row(
                                        children: [
                                          Icon(Icons.star,color: Colors.red,
                                          size: 12,),
                                          GeneralText(
                                            '4.6',
                                            style: appTheme.typographies.interFontFamily.headline6
                                                .copyWith(
                                                fontSize: 10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),

                                GeneralText(
                                  'Zee Lounge',
                                  style: appTheme.typographies.interFontFamily.headline6
                                      .copyWith(
                                      fontSize: 12,
                                      color: const Color(0xfff1c452),
                                      fontWeight: FontWeight.w400),
                                ),
                                GeneralText(
                                  Strings.letsStartScreenLabel1,
                                  style: appTheme.typographies.interFontFamily.headline6
                                      .copyWith(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],),
                            ),


                          ],
                        ),
                      ],
                    ),
                  );
                }, separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Color(0xfff1c452),
                  indent: 20,
                  thickness: 0.1,
                  endIndent: 20,
                );

              },),
            ),

          ]),
        ),
      ),
    );
  }


}

