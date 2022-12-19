import 'package:chef/screens/sign_up/questionire/sign_up_questionnaire_screen_v.dart';
import 'package:chef/ui_kit/general_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/resources.dart';
import '../../constants/strings.dart';
import '../../theme/app_theme_data/app_theme_data.dart';
import '../../theme/app_theme_widget.dart';
import '../../ui_kit/widgets/general_button.dart';
import '../../ui_kit/widgets/general_dropdown.dart';
import '../../ui_kit/widgets/general_text.dart';
import '../sign_in/sign_in_screen_v.dart';

enum Gender {
  male,
  female,
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // List<String> items = ['Scientist', 'Mathematician'];
  late List<DropdownMenuItem<String>> items = [];
  final TextController _nameController = TextController();
  final TextController _mobileNumberController = TextController();
  final TextController _ageController = TextController();

  @override
  void initState() {
    // DropdownMenuItem obj = new DropdownMenuItem()
    var newItem = const DropdownMenuItem(
      child: Text('Scientist'),
      value: 'Scientist',
    );
    var newItem2 = const DropdownMenuItem(
      child: Text('Mathematician'),
      value: 'Mathematician',
    );
    items.add(newItem);
    items.add(newItem2);
    super.initState();
  }

  Gender selectedGender = Gender.male;
  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;

    return Scaffold(
      backgroundColor: appTheme.colors.primaryBackground,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 11,
                ),
                _getStartedTitle(appTheme: appTheme),
                Center(
                  child: GeneralText(
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
                GeneralText(
                  Strings.signFullNameLabel,
                  textAlign: TextAlign.center,
                  style: appTheme.typographies.interFontFamily.headline4
                      .copyWith(
                          color: const Color(0xfffbeccb),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                GeneralTextInput(
                    controller: _nameController,
                    inputType: InputType.text,
                    backgroundColor: appTheme.colors.textFieldFilledColor,
                    inputBorder: appTheme.focusedBorder,
                    valueStyle: const TextStyle(color: Colors.white),
                    hint: 'Enter name',
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 14),
                    // valueStyle: valueStyle,
                    onChanged: (newValue) {}),
                const SizedBox(
                  height: 27,
                ),
                GeneralText(
                  Strings.signMobileNumberLabel,
                  textAlign: TextAlign.center,
                  style: appTheme.typographies.interFontFamily.headline4
                      .copyWith(
                          color: const Color(0xfffbeccb),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                GeneralTextInput(
                    controller: _mobileNumberController,
                    inputType: InputType.digit,
                    backgroundColor: appTheme.colors.textFieldFilledColor,
                    inputBorder: appTheme.focusedBorder,
                    valueStyle: const TextStyle(color: Colors.white),
                    hint: 'Enter Mobile Number',
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 14),
                    // valueStyle: valueStyle,
                    onChanged: (newValue) {}),
                const SizedBox(
                  height: 27,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GeneralText(
                            Strings.signAgeLabel,
                            textAlign: TextAlign.center,
                            style: appTheme
                                .typographies.interFontFamily.headline4
                                .copyWith(
                                    color: const Color(0xfffbeccb),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          GeneralTextInput(
                              height: 200,
                              textFieldWidth: 80,
                              controller: _ageController,
                              inputType: InputType.digit,
                              backgroundColor:
                                  appTheme.colors.textFieldFilledColor,
                              inputBorder: appTheme.focusedBorder,
                              valueStyle: const TextStyle(color: Colors.white),
                              hint: '18',
                              hintStyle: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              // valueStyle: valueStyle,
                              onChanged: (newValue) {}),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GeneralText(
                            Strings.signGenderLabel,
                            textAlign: TextAlign.center,
                            style: appTheme
                                .typographies.interFontFamily.headline4
                                .copyWith(
                                    color: const Color(0xfffbeccb),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              _genderWidget(
                                  appTheme, Gender.male, Strings.signMaleLabel),
                              const SizedBox(
                                width: 18,
                              ),
                              _genderWidget(appTheme, Gender.female,
                                  Strings.signFemaleLabel),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 27,
                // ),

                GeneralText(
                  Strings.signProfessionLabel,
                  textAlign: TextAlign.center,
                  style: appTheme.typographies.interFontFamily.headline4
                      .copyWith(
                          color: const Color(0xfffbeccb),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                // GeneralDropdown(
                //   name: 'select',
                //   // margin: 22.0,
                //   items: items,
                //   borderColor: appTheme.colors.textFieldBorderColor,
                //   onChange: ({
                //     required String key,
                //     required dynamic value,
                //   }) {},
                // ),
                const SizedBox(
                  height: 140,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()),
                        );
                      },
                      child: GeneralText(
                        Strings.signAlreadyUserLabel,
                        textAlign: TextAlign.center,
                        style: appTheme.typographies.interFontFamily.headline4
                            .copyWith(
                                color: const Color(0xfff7dc99),
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w500),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SignUpQuestionnaireScreen()),
                        );
                      },
                      child: SvgPicture.asset(
                        Resources.getRightArrow,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _genderWidget(IAppThemeData appTheme, Gender gender, String text) {
    return Expanded(
      child: InkWell(
        onTap: () {
          changeGender(gender);
        },
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: GeneralText(
              text,
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline2.copyWith(
                  color: selectedGender == gender ? Colors.black : Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(
                border: Border.all(
                    color: appTheme.colors
                        .textFieldBorderColor // green as background color

                    ),
                borderRadius: BorderRadius.circular(8), // radius of 10
                color: selectedGender == gender
                    ? appTheme.colors.textFieldBorderColor
                    : appTheme.colors.primaryBackground)),
      ),
    );
  }

  Widget _getStartedTitle({required IAppThemeData appTheme}) {
    return Center(
      child: GeneralText(
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
    return GeneralButton.button(
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
    GeneralText(
      Strings.getStartedButtonTitle,
      style: appTheme.typographies.interFontFamily.headline2,
    );
  }

  void changeGender(Gender gender) {
    setState(() {
      selectedGender = gender;
    });
  }
}
