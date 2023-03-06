import 'package:chef/helpers/helpers.dart';
import 'package:chef/screens/sign_up/questionire/sign_up_questionire_screen_vm.dart';




class SignUpQuestionireScreen extends BaseView<SignUpQuestionnaireScreenViewModel> {
  SignUpQuestionireScreen({Key? key}) : super(key: key);


  @override
  Widget buildScreen({required BuildContext context, required ScreenSizeData screenSizeData}) {
    final appTheme = AppTheme.of(context).theme;

    return Scaffold(
      backgroundColor: appTheme.colors.primaryBackground,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 18.0, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignUpLetsStartScreen()),
                );
              },
              child: SvgPicture.asset(
                Resources.getSignInRightArrow,
              ),
            ),
          ],
        ),
      ),


      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 260,
              width: double.infinity,
              child: Image.asset(Resources.getSignUpQuestionireBgPng),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
                child: Container(
                  alignment: Alignment.center,
                  //  padding: const EdgeInsets.only(left: 29),
                  child: Column(
                    children: [
                      GeneralText(
                        Strings.questionireLabel,
                        textAlign: TextAlign.center,
                        style: appTheme.typographies.interFontFamily.headline4
                            .copyWith(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 27,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GeneralText(
                            Strings.questionireLabel2,
                            textAlign: TextAlign.center,
                            style: appTheme.typographies.interFontFamily.headline4
                                .copyWith(
                                color: const Color(0xfffbeccb),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children:

                              getChipsWigetsList(viewModel,appTheme)

                             /* ChipsWidget(
                                appTheme: appTheme,
                                title: 'casual',
                                // selected: true,
                              ),
                              ChipsWidget(
                                appTheme: appTheme,
                                title: 'passionate',
                                selected: true,
                              ),
                              ChipsWidget(
                                appTheme: appTheme,
                                title: 'Adventurous',
                              ),
                              ChipsWidget(
                                appTheme: appTheme,
                                title: 'Taste Explorer',
                                //  selected: true,
                              ),*/
                            ,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 51,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GeneralText(
                            Strings.questionireLabel3,
                            textAlign: TextAlign.center,
                            style: appTheme.typographies.interFontFamily.headline6
                                .copyWith(
                                color: const Color(0xfffbeccb),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              ChipsWidget(
                                appTheme: appTheme,
                                title: 'Hill View',
                              ),
                              ChipsWidget(
                                appTheme: appTheme,
                                title: 'Rooftop',
                                selected: true,
                              ),
                              ChipsWidget(
                                appTheme: appTheme,
                                title: 'Terrace',
                              ),
                              ChipsWidget(
                                appTheme: appTheme,
                                title: 'Garden',
                                //  selected: true,
                              ),
                              ChipsWidget(
                                appTheme: appTheme,
                                title: 'Historical Monument',
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 27,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GeneralText(
                            Strings.questionireLabel4,
                            textAlign: TextAlign.center,
                            style: appTheme.typographies.interFontFamily.headline6
                                .copyWith(
                                color: const Color(0xfffbeccb),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              ChipsWidget(
                                appTheme: appTheme,
                                title: 'Meaty',
                              ),
                              ChipsWidget(
                                appTheme: appTheme,
                                title: 'Seafood',
                                selected: true,
                              ),
                              ChipsWidget(
                                appTheme: appTheme,
                                title: 'Veggie',
                              ),
                              ChipsWidget(
                                appTheme: appTheme,
                                title: 'Sweet',
                                //selected: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 27,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GeneralText(
                            Strings.questionireLabel5,
                            textAlign: TextAlign.center,
                            style: appTheme.typographies.interFontFamily.headline6
                                .copyWith(
                                color: const Color(0xfffbeccb),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              ChipsWidget(
                                appTheme: appTheme,
                                title: 'Sports',
                              ),
                              ChipsWidget(
                                appTheme: appTheme,
                                title: 'Music',
                                selected: true,
                              ),
                              ChipsWidget(
                                appTheme: appTheme,
                                title: 'Traveling',
                              ),
                              ChipsWidget(
                                appTheme: appTheme,
                                title: 'Movies',
                                selected: true,
                              ),
                              ChipsWidget(
                                appTheme: appTheme,
                                title: 'Current Affairs',
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 35),
                        height: 70,
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(12))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GeneralText(
                              Strings.labelProfilePicture,
                              textAlign: TextAlign.center,
                              style: appTheme.typographies.interFontFamily.headline4
                                  .copyWith(
                                  color: appTheme.colors.primaryBackground,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            Image.asset(
                              Resources.userProfilePicPng,
                              height: 47,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  List<ChipsWidget> getChipsWigetsList(SignUpQuestionnaireScreenViewModel viewModel, IAppThemeData appTheme) {
     List<ChipsWidget> list = [];
     list.add(ChipsWidget(
       appTheme: appTheme,
       title: 'passionate',
       selected: true,
     ));list.add(ChipsWidget(
       appTheme: appTheme,
       title: 'passionate',
       selected: true,
     ));list.add(ChipsWidget(
       appTheme: appTheme,
       title: 'passionate',
       selected: true,
     ));list.add(ChipsWidget(
       appTheme: appTheme,
       title: 'passionate',
       selected: true,
     ));list.add(ChipsWidget(
       appTheme: appTheme,
       title: 'passionate',
       selected: true,
     ));
    return  list;
  }
}

class ChipsWidget extends StatelessWidget {
  const ChipsWidget({
    Key? key,
    required this.appTheme,
    required this.title,
    this.selected = false,
    this.widthContainer = 160,
  }) : super(key: key);

  final IAppThemeData appTheme;
  final String title;
  final bool selected;
  final double widthContainer;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        width: widthContainer,
        child: GeneralText(
          title.capitalize(),
          textAlign: TextAlign.center,
          style: appTheme.typographies.interFontFamily.headline6.copyWith(
              color: selected ? Colors.black : Colors.white,
              fontSize: 15,
              fontWeight: selected ? FontWeight.bold : FontWeight.w500),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: appTheme.colors.textFieldBorderColor,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(
            30,
          ),
          color: selected
              ? appTheme.colors.textFieldBorderColor
              : Colors.transparent,
        ));
  }
}
