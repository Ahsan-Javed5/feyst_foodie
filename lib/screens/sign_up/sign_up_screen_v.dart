import 'package:chef/screens/sign_up/questionire/sign_up_questionire_screen_v.dart';
import 'package:chef/ui_kit/exto_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/resources.dart';
import '../../constants/strings.dart';
import '../../theme/app_theme_data/app_theme_data.dart';
import '../../theme/app_theme_widget.dart';
import '../../ui_kit/widgets/exto_button.dart';
import '../../ui_kit/widgets/exto_text.dart';
import '../sign_in/sign_in_screen_v.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {



  List<String> items=['Scientist','Mathematician'];
  final TextController _nameController = TextController();
  final TextController _mobileNumberController = TextController();
  final TextController _ageController = TextController();

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
                _getStartedTitle(appTheme: appTheme),
                Center(
                  child: ExtoText(
                    Strings.signUpTitle,
                    textAlign: TextAlign.center,
                    style: appTheme.typographies.interFontFamily.headline4
                        .copyWith(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 27,
                ),
                ExtoText(
                  Strings.signFullNameLabel,
                  textAlign: TextAlign.center,
                  style: appTheme.typographies.interFontFamily.headline4.copyWith(
                      color: const Color(0xfffbeccb),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                ExtoTextInput(
                  controller: _nameController,
                  inputType: InputType.text,
                  backgroundColor: appTheme.colors.textFieldFilledColor,
                  inputBorder:  appTheme.focusedBorder,
                    valueStyle: const TextStyle(
                        color: Colors.white
                    ),
                  hint: 'Enter name',
                   hintStyle: const TextStyle(
                     color: Colors.white,
                     fontSize: 14
                   ),
                  // valueStyle: valueStyle,
                  onChanged: (newValue){

                  }

                ),

                const SizedBox(
                  height: 27,
                ),
                ExtoText(
                  Strings.signMobileNumberLabel,
                  textAlign: TextAlign.center,
                  style: appTheme.typographies.interFontFamily.headline4.copyWith(
                      color: const Color(0xfffbeccb),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                ExtoTextInput(
                    controller: _mobileNumberController,
                    inputType: InputType.digit,
                    backgroundColor: appTheme.colors.textFieldFilledColor,
                    inputBorder:  appTheme.focusedBorder,
                    valueStyle: const TextStyle(
                        color: Colors.white
                    ),
                    hint: 'Enter Mobile Number',
                    hintStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14
                    ),
                    // valueStyle: valueStyle,
                    onChanged: (newValue){

                    }

                ),


               /* const SizedBox(
                  height: 27,
                ),


                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ExtoText(
                          Strings.signAgeLabel,
                          textAlign: TextAlign.center,
                          style: appTheme.typographies.interFontFamily.headline4.copyWith(
                              color: const Color(0xfffbeccb),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(
                          height: 8,
                        ),
                        ExtoTextInput(
                             controller: _ageController,
                            inputType: InputType.digit,
                            backgroundColor: appTheme.colors.textFieldFilledColor,
                            inputBorder:  appTheme.focusedBorder,

                            hint: '12',
                            hintStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 14
                            ),
                            // valueStyle: valueStyle,
                            onChanged: (newValue){

                            }

                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ExtoText(
                          Strings.signGenderLabel,
                          textAlign: TextAlign.center,
                          style: appTheme.typographies.interFontFamily.headline4.copyWith(
                              color: const Color(0xfffbeccb),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(
                          height: 8,
                        ),
                         Row(children: [
                           Container(
                               child:   ExtoText(
                                 Strings.signMaleLabel,
                                 textAlign: TextAlign.center,
                                 style: appTheme.typographies.interFontFamily.headline4.copyWith(
                                     color:  Colors.black,
                                     fontSize: 15,
                                     fontWeight: FontWeight.w500),
                               ),
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(12), // radius of 10
                                   color: appTheme.colors.textFieldBorderColor  // green as background color
                               )
                           ),
                           const SizedBox(
                             width: 5,
                           ),
                         ],)
                      ],
                    ),
                  ],
                ),*/

                const SizedBox(
                  height: 27,
                ),
                ExtoText(
                  Strings.signProfessionLabel,
                  textAlign: TextAlign.center,
                  style: appTheme.typographies.interFontFamily.headline4.copyWith(
                      color: const Color(0xfffbeccb),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),


                ExtoDropdown(
                  name: 'select',
                   // margin: 22.0,
                  items:items,

                  onChange: ({
                    required String key,
                    required dynamic value,
                  }) {

                  },
                ),
                const SizedBox(
                  height: 140,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  InkWell(
                    onTap: (){

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                      );
                    },
                    child: ExtoText(

                      Strings.signAlreadyUserLabel,
                      textAlign: TextAlign.center,

                      style: appTheme.typographies.interFontFamily.headline4.copyWith(
                          color: const Color(0xfff7dc99),
                          fontSize: 15,

                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpQuestionireScreen()),
                        );

                      },
                      child: SvgPicture.asset(
                        Resources.getRightArrow,

                      ),
                    )
                ],)

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getStartedTitle({required IAppThemeData appTheme}) {
    return Center(
      child: ExtoText(
        Strings.letsGetTitle,
        textAlign: TextAlign.center,
        style: appTheme.typographies.interFontFamily.headline4.copyWith(
            color: Color(0xfff1c452),
            fontSize: 28,
            fontWeight: FontWeight.w500),
      ),
    );
  }


  Widget _getStartedButtonTitle({required IAppThemeData appTheme}) {
    return ExtoButton.button(
      title: Strings.getStartedButtonTitle.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => SignUpScreen()),
        // );
        //    viewModel.goToForgotPasswordScreen();
      },
    );
    ExtoText(
      Strings.getStartedButtonTitle,
      style: appTheme.typographies.interFontFamily.headline2,
    );
  }
}
