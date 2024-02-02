import 'package:chef/helpers/helpers.dart';
import 'package:chef/screens/forgot_password/forgot_password_screen_v.dart';
import 'package:chef/screens/sign_in/sign_in_screen_vm.dart';
import 'package:chef/services/device/device_service.dart';
import 'package:chef/ui_kit/widgets/general_text_input.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../base/base_view.dart';
import '../../constants/api.dart';
import '../../constants/resources.dart';
import '../../constants/strings.dart';
import '../../setup.dart';
import '../../theme/app_theme_widget.dart';
import '../../ui_kit/general_ui_kit.dart';
import '../../ui_kit/helpers/dialog_helper.dart';
import '../../ui_kit/widgets/general_bottom_sheet.dart';
import '../../ui_kit/widgets/general_text.dart';
import '../sign_up/sign_up_screen_v.dart';

class SignInScreen extends BaseView<SignInScreenViewModel> {
  SignInScreen({Key? key}) : super(key: key);
  final TextController _mobileNumberController = TextController();
  final TextController _passwordController = TextController();
  final _navigation = locateService<INavigationService>();

  @override
  Widget buildScreen(
      {required BuildContext context, required ScreenSizeData screenSizeData}) {
    final appTheme = AppTheme.of(context).theme;

    return Scaffold(
      backgroundColor: appTheme.colors.primaryBackground,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 142,
                left: 187,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/images/icons/food_product_ring.png',
                    height: 300,
                    color: const Color(0xfff1c452).withOpacity(0.1),
                  ),
                ),
              ),
              Container(
                height: 750,
                //color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 41,
                    ),
                    Center(
                      child: GeneralText(
                        Strings.signInLabel,
                        textAlign: TextAlign.center,
                        style: appTheme.typographies.interFontFamily.headline4
                            .copyWith(
                                color: const Color(0xfff1c452),
                                fontSize: 28,
                                fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 127,
                    ),
                    GeneralText(
                      Strings.signInMobileNumberLabel,
                      textAlign: TextAlign.center,
                      style: appTheme.typographies.interFontFamily.headline4
                          .copyWith(
                              color: const Color(0xfffbeccb),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GeneralTextInput(
                        controller: _mobileNumberController,
                        inputType: InputType.digit,
                        backgroundColor: appTheme.colors.textFieldFilledColor,
                        valueStyle: const TextStyle(color: Colors.white),
                        inputBorder: appTheme.focusedBorder,
                        prefixIcon: CountryCodePicker(
                          onChanged: (value) {
                            viewModel.countryCode = value.dialCode!;
                          },
                          textStyle: const TextStyle(color: Colors.white),
                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                          initialSelection: 'PK',
                          //enabled: isProfileDetails ? false : true,
                          favorite: const ['+92', 'PK'],
                          // optional. Shows only country name and flag
                          showCountryOnly: false,
                          // optional. Shows only country name and flag when popup is closed.
                          showOnlyCountryWhenClosed: false,
                          // optional. aligns the flag and the Text left
                          alignLeft: false,
                          hideSearch: true,
                        ),
                        hint: '3xx xxx xxxx',
                        hintStyle:
                            const TextStyle(color: Colors.white, fontSize: 15),
                        onChanged: (newValue) {
                          if (newValue.length == 1 && newValue == '0') {
                            _mobileNumberController.clear();
                          }
                        }),
                    const SizedBox(
                      height: 25,
                    ),
                    GeneralText(
                      "Password",
                      textAlign: TextAlign.center,
                      style: appTheme.typographies.interFontFamily.headline4
                          .copyWith(
                              color: const Color(0xfffbeccb),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GeneralTextInput(
                        controller: _passwordController,
                        inputType: InputType.password,
                        backgroundColor: appTheme.colors.textFieldFilledColor,
                        valueStyle: const TextStyle(color: Colors.white),
                        inputBorder: appTheme.focusedBorder,
                        hint: 'Enter Your Password',
                        hintStyle:
                            const TextStyle(color: Colors.white, fontSize: 15),
                        onChanged: (newValue) {}),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen(false)),
                              );
                            },
                            child: GeneralText(
                              "Create New Account?",
                              textAlign: TextAlign.center,
                              style: appTheme
                                  .typographies.interFontFamily.headline7
                                  .copyWith(
                                color: const Color(0xfffbeccb),
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          GestureDetector(
                            onTap: () {
                              locateService<INavigationService>().navigateTo(
                                  route: ForgotPasswordRoute(
                                      baseUrl: Api.baseURL));
                            },
                            child: GeneralText(
                              "Forgot Password?",
                              textAlign: TextAlign.center,
                              style: appTheme
                                  .typographies.interFontFamily.headline7
                                  .copyWith(
                                color: const Color(0xfffbeccb),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                        child: _loginButtonTitle(
                            appTheme: appTheme, context: context)),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: _exploreExperiencesButton(appTheme: appTheme)),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen(
                                          false,
                                        )),
                              );
                            },
                            child: SvgPicture.asset(
                              Resources.getSignInLeftArrow,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              viewModel.verifyUser(
                                mobileNumber: _mobileNumberController.text
                                    .toString()
                                    .trim(),
                                password:
                                    _passwordController.text.toString().trim(),
                                context: context,
                              );
                            },
                            child: SvgPicture.asset(
                              Resources.getSignInRightArrow,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginButtonTitle(
      {required IAppThemeData appTheme, required BuildContext context}) {
    return GeneralButton.button(
      width: 200,
      title: Strings.login.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        viewModel.verifyUser(
          mobileNumber: _mobileNumberController.text.toString().trim(),
          password: _passwordController.text.toString().trim(),
          context: context,
        );
        //_navigation.navigateTo(route: SignInRoute());
      },
    );
  }

  Widget _exploreExperiencesButton({required IAppThemeData appTheme}) {
    return InkWell(
      onTap: () {
        _navigation.navigateTo(route: BottomBar());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        child: Column(
          children: [
            GeneralText(
              'EXPLORE EXPERIENCES',
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
            GeneralText(
              'As Guest User',
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline4.copyWith(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
