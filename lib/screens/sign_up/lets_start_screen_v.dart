import 'package:chef/screens/home/food_details_screen.dart';
import 'package:chef/theme/app_theme_data/app_theme_data.dart';
import 'package:chef/ui_kit/widgets/general_text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/resources.dart';
import '../../../constants/strings.dart';
import '../../../theme/app_theme_widget.dart';
import '../../../ui_kit/widgets/general_text.dart';
import '../../ui_kit/widgets/general_button.dart';
 
class SignUpLetsStartScreen extends StatefulWidget {
  @override
  _SignUpLetsStartScreenState createState() =>
      _SignUpLetsStartScreenState();
}

class _SignUpLetsStartScreenState extends State<SignUpLetsStartScreen> {
  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;

    return Scaffold(
      backgroundColor: appTheme.colors.primaryBackground,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 260,
              width: double.infinity,
              child: Image.asset(Resources.getSignUpLetsStartScreenBgPng),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 25,right:20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GeneralText(
                    Strings.letsStartScreenLabel,
                    textAlign: TextAlign.start,
                    style: appTheme.typographies.interFontFamily.headline4
                        .copyWith(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 27,
                  ),

                  GeneralText(
                    Strings.letsStartScreenLabel1,
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    style: appTheme.typographies.interFontFamily.headline4
                        .copyWith(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  Row(children: [
                    Image.asset(Resources.getSignUpLetsStartScreenTickPng,height: 15,),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GeneralText(
                        Strings.letsStartScreenLabel2,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: appTheme.typographies.interFontFamily.headline4
                            .copyWith(
                            color: Color(0xfffee4a4),
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(children: [
                    Image.asset(Resources.getSignUpLetsStartScreenTickPng,height: 15,),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GeneralText(
                        Strings.letsStartScreenLabel2,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: appTheme.typographies.interFontFamily.headline4
                            .copyWith(
                            color: Color(0xfffee4a4),
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(children: [
                    Image.asset(Resources.getSignUpLetsStartScreenTickPng,height: 15,),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GeneralText(
                        Strings.letsStartScreenLabel2,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: appTheme.typographies.interFontFamily.headline4
                            .copyWith(
                            color: Color(0xfffee4a4),
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(children: [
                    Image.asset(Resources.getSignUpLetsStartScreenTickPng,height: 15,),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GeneralText(
                        Strings.letsStartScreenLabel2,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: appTheme.typographies.interFontFamily.headline4
                            .copyWith(
                            color: Color(0xfffee4a4),
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],),
                  const SizedBox(
                    height: 80,
                  ),

                ],
              ),
            ),
            Center(child: _letsStartedButtonTitle(appTheme: appTheme)),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
  Widget _letsStartedButtonTitle({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      title: Strings.letsStartScreenBtnLabel.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FoodDetailScreen()),
        );
        //    viewModel.goToForgotPasswordScreen();
      },
    );
    GeneralText(
      Strings.getStartedButtonTitle,
      style: appTheme.typographies.interFontFamily.headline2,
    );
  }
}

