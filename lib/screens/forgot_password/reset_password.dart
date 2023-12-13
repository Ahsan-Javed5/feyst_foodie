import 'package:chef/screens/forgot_password/forgot_password_screen_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/resources.dart';
import '../../constants/strings.dart';
import '../../setup.dart';
import '../../theme/app_theme_data/app_theme_data.dart';
import '../../theme/app_theme_widget.dart';
import '../../ui_kit/widgets/general_text.dart';
import '../../ui_kit/widgets/general_text_input.dart';


class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key, required this.tokenId, required this.phoneNumber,}) : super(key: key);

  final String? tokenId;
  final String phoneNumber;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreen();
}

class _ResetPasswordScreen extends State<ResetPasswordScreen> {
  final TextController passwordController = TextController();
  final TextController confirmPasswordController = TextController();

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;

    return Scaffold(
      backgroundColor: appTheme.colors.primaryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
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
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: GeneralText(
                        'Reset Password',
                        textAlign: TextAlign.center,
                        style: appTheme.typographies.interFontFamily.headline4
                            .copyWith(
                            color: const Color(0xfff1c452),
                            fontSize: 28,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    displayPassword(appTheme),
                    const SizedBox(height: 20),
                    displayConfirmPassword(appTheme),
                    const SizedBox(height: 220,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        InkWell(
                          onTap: () async {
                            var viewModel = locateService<ForgotPasswordScreenViewModel>();
                            viewModel.resetPassword(context, passwordController.text.trim(), widget.phoneNumber, widget.tokenId);
                          },
                          child: SvgPicture.asset(
                            Resources.getSignInRightArrow,
                          ),
                        )
                      ],
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

  Widget displayPassword(
      IAppThemeData appTheme,
      ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralText(
          'Password',
          textAlign: TextAlign.center,
          style: appTheme.typographies.interFontFamily.headline4.copyWith(
              color: const Color(0xfffbeccb),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        GeneralTextInput(
            controller: passwordController,
            inputType: InputType.password,
            backgroundColor: appTheme.colors.textFieldFilledColor,
            isEnable: true,
            disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.grey)),
            inputBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            valueStyle: const TextStyle(color: Colors.white),
            hint: 'Enter Password',
            validator: (pass){
              if(pass!.length < 6){
                return 'Password must contain at least 6 characters';
              }
              return null;
            },
            hintStyle:
            TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
            // valueStyle: valueStyle,
            onChanged: (value) {

            }),
      ],
    );
  }

  Widget displayConfirmPassword(
      IAppThemeData appTheme,
      ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GeneralText(
          'Confirm Password',
          textAlign: TextAlign.center,
          style: appTheme.typographies.interFontFamily.headline4.copyWith(
              color: const Color(0xfffbeccb),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        GeneralTextInput(
            controller: confirmPasswordController,
            inputType: InputType.password,
            backgroundColor: appTheme.colors.textFieldFilledColor,
            isEnable: true,
            disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.grey)),
            inputBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            valueStyle: const TextStyle(color: Colors.white),
            hint: 'Re enter Password',
            validator: (pass){
              if(pass!.length < 6){
                return 'Password must contain at least 6 characters';
              }else if(pass != passwordController.text)
              {
                return 'Password not same';
              }
              return null;
            },
            hintStyle:
            TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
            // valueStyle: valueStyle,
            onChanged: (value) {

            }),
      ],
    );
  }
}
