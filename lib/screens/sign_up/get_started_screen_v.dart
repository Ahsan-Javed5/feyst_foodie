import 'package:chef/screens/sign_up/sign_up_screen_v.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:chef/base/base.dart';
import 'package:chef/constants/constants.dart';
import 'package:chef/services/services.dart';
import 'package:chef/screens/splash/splash_screen_m.dart';
import 'package:chef/screens/splash/splash_screen_vm.dart';

import '../../theme/app_theme_data/app_theme_data.dart';
import '../../theme/app_theme_widget.dart';
import '../../ui_kit/widgets/general_button.dart';
import '../../ui_kit/widgets/general_text.dart';

class GetStartedScreen extends StatefulWidget {
  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return Scaffold(
      backgroundColor: appTheme.colors.primaryBackground,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Resources.getStartedBgPng,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            _getStartedTitle(appTheme: appTheme),
            SizedBox(
              height: 12,
            ),
            _getStartedSubTitle(appTheme: appTheme),
            SizedBox(
              height: 230,
            ),
            _getStartedButtonTitle(appTheme: appTheme),
            SizedBox(
              height: 50,
            ),
          ],
        ) /* add child content here */,
      ),
    );
  }

  Widget _getStartedTitle({required IAppThemeData appTheme}) {
    return GeneralText(
      Strings.getStartedTitle,
      textAlign: TextAlign.center,
      style: appTheme.typographies.interFontFamily.headline4
          .copyWith(color: Colors.white, fontSize: 21),
    );
  }

  Widget _getStartedSubTitle({required IAppThemeData appTheme}) {
    return GeneralText(
      Strings.getStartedSubtitle,
      textAlign: TextAlign.center,
      style: appTheme.typographies.interFontFamily.headline6
          .copyWith(color: Colors.white, fontSize: 15),
    );
  }

  Widget _getStartedButtonTitle({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      title: Strings.getStartedButtonTitle.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreen()),
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
