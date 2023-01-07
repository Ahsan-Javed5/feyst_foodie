import 'package:chef/helpers/helpers.dart';

class SignUpQuestionireScreen extends StatefulWidget {
  @override
  _SignUpQuestionireScreenState createState() =>
      _SignUpQuestionireScreenState();
}

class _SignUpQuestionireScreenState extends State<SignUpQuestionireScreen> {
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
              child: Image.asset(Resources.getSignUpQuestionireBgPng),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 7),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      ChipsWidget(
                        appTheme: appTheme,
                        title: 'casual',
                        selected: true,
                      ),
                      ChipsWidget(
                        appTheme: appTheme,
                        title: 'passionate',
                      ),
                      ChipsWidget(
                        appTheme: appTheme,
                        title: 'Adventurous',
                      ),
                      ChipsWidget(
                        appTheme: appTheme,
                        title: 'Taste Explorer',
                        selected: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 27,
                ),
                GeneralText(
                  Strings.questionireLabel3,
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
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
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
                      selected: true,
                    ),
                    ChipsWidget(
                      appTheme: appTheme,
                      title: 'Historical Monument',
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
                          selected: true,
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
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.symmetric( horizontal: 35),
                  height: 70,
                  padding: const EdgeInsets.symmetric( horizontal: 22),
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
                      Image.asset(Resources.userRoundIconPNG,
                      height: 25,)
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUpLetsStartScreen()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 32),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: SvgPicture.asset(
                        Resources.getSignInRightArrow,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChipsWidget extends StatelessWidget {
  const ChipsWidget({
    Key? key,
    required this.appTheme,
    required this.title,
    this.selected = false,
  }) : super(key: key);

  final IAppThemeData appTheme;
  final String title;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: GeneralText(
          title,
          textAlign: TextAlign.center,
          style: appTheme.typographies.interFontFamily.headline4.copyWith(
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
