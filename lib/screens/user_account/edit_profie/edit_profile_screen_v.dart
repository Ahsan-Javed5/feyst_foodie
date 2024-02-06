import 'package:chef/helpers/color_helper.dart';
import 'package:chef/helpers/helpers.dart';
import 'package:chef/screens/bottom_bar/bottom_bar.dart' as bottom_bar;
import 'package:chef/screens/privacy_policy/privacy_policy.dart';
import 'package:chef/screens/screen.dart';
import 'package:chef/screens/user_account/reviews.dart';
import 'package:chef/screens/user_account/user_profile.dart';

import '../../../setup.dart';
import '../../../ui_kit/widgets/general_new_appbar.dart';

import 'dart:developer' as developer;

import '../../sign_up/questionire/sign_up_questionire_screen_vm.dart';
import '../../update_password/update_password_v.dart';
import 'edit_profile_screen_vm.dart';

class EditProfileScreen extends BaseView<EditProfileScreenViewModel> {
  EditProfileScreen({Key? key}) : super(key: key);
  List<String> accountList = [
    Strings.labelPersonalDetails,
    Strings.labelProfile,
    Strings.labelReviews,
    Strings.updatePassword,
  ];

  final _navigation = locateService<INavigationService>();
  final _storage = locateService<IStorageService>();

  final signUpQuestionnaireViewModel =
      locateService<SignUpQuestionnaireScreenViewModel>();

  Future<bool> onWillPop() async {
    return false;
  }

  @override
  Widget buildScreen(
      {required BuildContext context, required ScreenSizeData screenSizeData}) {
    List<String> othersList = _storage.readString(key: 'auth_token').isEmpty
        ? [
            Strings.labelPrivacyPolicy,
            Strings.labelTermsCond,
          ]
        : [
            Strings.labelPrivacyPolicy,
            Strings.labelTermsCond,
            Strings.labelLogOut,
          ];
    final appTheme = AppTheme.of(context).theme;
    //signUpQuestionnaireViewModel.getFoodieAnswers();
    return WillPopScope(
      onWillPop: () => onWillPop(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: HexColor.fromHex("#212129"),
          body: SingleChildScrollView(
            child: Column(children: [
              Container(
                padding: const EdgeInsets.only(left: 12, top: 20, bottom: 20),
                child: GeneralNewAppBar(
                    rightIcon: Resources.homeIconSvg,
                    title: Strings.labelProfile,
                    titleColor: Colors.white,
                    callBack: () {
                      _navigation.navigateTo(
                          route: BottomBar(
                              bottomBarType: bottom_bar.BottomBarType.home));
                    }),
              ),
              const SizedBox(
                height: 8,
              ),

              ///Account Options
              _storage.readString(key: 'auth_token').isEmpty
                  ? const SizedBox()
                  : Column(
                      children: [
                        _Header(
                          appTheme: appTheme,
                          title: Strings.labelHeaderAccount,
                        ),
                        ListView.separated(
                          itemCount: accountList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0, vertical: 12),
                              child: InkWell(
                                onTap: () async {
                                  if (accountList.elementAt(index) ==
                                      Strings.labelPersonalDetails) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpScreen(
                                                true,
                                              )),
                                    );
                                  } else if (accountList.elementAt(index) ==
                                      Strings.labelProfile) {
                                    // await signUpQuestionnaireViewModel.getFoodieAnswers();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignUpQuestionireScreen(true)),
                                    );
                                  } else if (accountList.elementAt(index) ==
                                      Strings.labelReviews) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ReviewsScreen()),
                                    );
                                  } else if (accountList.elementAt(index) ==
                                      Strings.updatePassword) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const UpdatePassword()),
                                    );
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GeneralText(
                                      accountList.elementAt(index),
                                      style: appTheme.typographies
                                          .interFontFamily.headline6
                                          .copyWith(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                    ),
                                    SvgPicture.asset(Resources.arrowProfileSVG),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              color: const Color(0xfff1c452).withOpacity(0.3),
                            );
                          },
                        ),
                      ],
                    ),
              const SizedBox(
                height: 7,
              ),
              _Header(
                appTheme: appTheme,
                title: Strings.labelHeaderOthers,
              ),
              ListView.separated(
                itemCount: othersList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        if (othersList.elementAt(index) ==
                            Strings.labelLogOut) {
                          developer.log(' Clicked on logout ');
                          viewModel.logout(context);
                        } else if (othersList.elementAt(index) ==
                            Strings.labelPrivacyPolicy) {
                          Future.delayed(const Duration(seconds: 3), () {});
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PrivacyPolicy('privacy')),
                          );
                        } else if (othersList.elementAt(index) ==
                            Strings.labelTermsCond) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PrivacyPolicy('terms')),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GeneralText(
                              othersList.elementAt(index),
                              style: appTheme
                                  .typographies.interFontFamily.headline6
                                  .copyWith(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                            ),
                            SvgPicture.asset(Resources.arrowProfileSVG),
                          ],
                        ),
                      ));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: const Color(0xfff1c452).withOpacity(0.3),
                  );
                },
              ),
              Divider(
                color: const Color(0xfff1c452).withOpacity(0.3),
              ),
              _storage.readString(key: 'auth_token').isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(
                        top: 25,
                      ),
                      child: _loginButtonTitle(appTheme: appTheme),
                    )
                  : const SizedBox(),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _loginButtonTitle({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      width: 180,
      title: Strings.login.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        _navigation.navigateTo(route: SignInRoute());
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
    required this.appTheme,
    required this.title,
  }) : super(key: key);

  final IAppThemeData appTheme;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(top: 10, bottom: 10, start: 23),
      color: HexColor.fromHex("#2c292b"),
      child: Row(
        children: [
          GeneralText(
            title,
            style: appTheme.typographies.interFontFamily.headline6.copyWith(
                fontSize: 20,
                color: HexColor.fromHex('#f1c452'),
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
