import 'package:chef/ui_kit/widgets/exto_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/resources.dart';
import '../../constants/strings.dart';
import '../../theme/app_theme_widget.dart';
import '../../ui_kit/widgets/exto_text.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextController _mobileNumberController = TextController();

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;

    return Scaffold(
      backgroundColor: appTheme.colors.primaryBackground,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 11,
                ),

                Center(
                  child: ExtoText(
                    Strings.signInLabel,
                    textAlign: TextAlign.center,
                    style: appTheme.typographies.interFontFamily.headline4.copyWith(
                        color: Color(0xfff1c452),
                        fontSize: 28,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 27,
                ),
                ExtoText(
                  Strings.signInMobileNumberLabel,
                  textAlign: TextAlign.center,
                  style: appTheme.typographies.interFontFamily.headline4.copyWith(
                      color: const Color(0xfffbeccb),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                ExtoTextInput(
                    controller: _mobileNumberController,
                    inputType: InputType.digit,
                    backgroundColor: appTheme.colors.textFieldFilledColor,
                    valueStyle: const TextStyle(
                      color: Colors.white
                    ),
                    inputBorder:  appTheme.focusedBorder,
                    hint: '+92 345 000 0000',
                    hintStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14
                    ),
                    // valueStyle: valueStyle,
                    onChanged: (newValue){

                    }

                ),

                const SizedBox(
                  height: 127,
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  SvgPicture.asset(
                    Resources.getSignInLeftArrow,

                  ) ,
                  SvgPicture.asset(
                    Resources.getSignInRightArrow,

                  )

                ],)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
