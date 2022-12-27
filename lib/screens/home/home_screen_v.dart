import 'package:chef/constants/constants.dart';
import 'package:chef/helpers/helpers.dart';
import 'package:flutter/material.dart';

import '../../theme/app_theme_widget.dart';
import '../../ui_kit/widgets/general_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;

    return Scaffold(
      backgroundColor: Color(0xff212129),
      body: Stack(
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

          Positioned.fill(
            top: 80,
            child: Container(
              padding: EdgeInsets.only(left: 31),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GeneralText(
                    Strings.labelExplore,
                    style: appTheme.typographies.interFontFamily.headline2
                        .copyWith(
                      fontSize: 29,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  GeneralText(
                    Strings.labelFoodExperience,
                    style: appTheme.typographies.interFontFamily.headline2
                        .copyWith(
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

SizedBox(height: 60,),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                        itemCount: 3,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return  ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Stack(
                                children: [

                                  Container(
                                    height: 230,
                                    padding: EdgeInsets.all(12),
                                    child: Container(
                                        height: 200,
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
                                        width: 150,
                                        height: 50,
                                        padding: EdgeInsets.all(4),
                                        decoration:  BoxDecoration(
                                            color: const Color(0xffbb3127),
                                            borderRadius: BorderRadius.only(
                                              topLeft: const Radius.circular(12.0),
                                              topRight: const Radius.circular(12.0),
                                              bottomLeft: const Radius.circular(12.0),
                                            )
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                GeneralText(
                                                  Strings.labelSeaFoodExperience,
                                                  style: appTheme
                                                      .typographies.interFontFamily.headline2
                                                      .copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white,
                                                  ),
                                                ),

                                                GeneralText(
                                                  Strings.labelSeaFood2Experience,
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

                                            SizedBox(width: 12,),
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
                              ));
                        }),
                  ),


                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
