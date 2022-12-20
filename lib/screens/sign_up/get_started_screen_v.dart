import 'package:chef/helpers/helpers.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

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
            const Spacer(),
            _getStartedTitle(appTheme: appTheme),
            const SizedBox(
              height: 12,
            ),
            _getStartedSubTitle(appTheme: appTheme),
            const SizedBox(
              height: 230,
            ),
            _getStartedButtonTitle(appTheme: appTheme),
            const SizedBox(
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
  }
}
