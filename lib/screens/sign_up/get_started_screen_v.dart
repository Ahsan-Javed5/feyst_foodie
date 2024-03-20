import 'package:auto_route/annotations.dart';
import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/guest/guest_user_response.dart';
import 'package:chef/setup.dart';
import 'package:video_player/video_player.dart';

@RoutePage()
class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );
  late VideoPlayerController videoController;
  final _network = locateService<INetworkService>();
  final _storage = locateService<IStorageService>();

  @override
  void initState() {
    guestFoodie();
    videoController = VideoPlayerController.asset('assets/videos/Clipped.m4v')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    videoController.play();
    videoController.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
  }

  @override
  void didChangeDependencies() async {
    await PackageInfo.fromPlatform().then((value) {
      _packageInfo = value;
      setState(() {});
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return Scaffold(
      backgroundColor: appTheme.colors.primaryBackground,
      body: Stack(
        children: [
          VideoPlayer(videoController),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
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
                Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      Strings.appVersion,
                      style: appTheme.typographies.interFontFamily.headline6,
                    )),
              ],
            ) /* add child content here */,
          ),
        ],
      ),
    );
  }

  void guestFoodie() async {
    try {
      final url =
          InfininURLHelpers.getRestApiURL(Api.baseURL + Api.anonymousLogin);

      final response = await _network.post(
        path: url,
        header: {
          Api.headerAcceptKey: Api.headerAcceptTypeValue,
          'Content-Type': 'application/json'
        },
      ).whenComplete(() {});

      if (response != null) {
        GuestUserResponse guestUserResponse =
            guestUserResponseFromJson(response.body);

        //Toaster.infoToast(context: context, message: guestUserResponseToJson(data).message);

        await _storage.writeString(
            key: 'guest_token',
            data: guestUserResponse.t!.authToken.toString());
        print('guest user token');
        print(_storage.readString(key: 'guest_token'));

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => SignUpQuestionireScreen(
        //         false,
        //       )),
        // );
      } else {
        Toaster.infoToast(
            context: context,
            message: Strings.somethingWentWrong);
      }
    } catch (error) {
      Toaster.errorToast(context: context, message: '$error');
    }
  }

  Widget _getStartedTitle({required IAppThemeData appTheme}) {
    return GeneralText(
      Strings.getStartedTitle,
      textAlign: TextAlign.center,
      style: appTheme.typographies.interFontFamily.headline7.copyWith(
        height: 1.5,
        shadows: <Shadow>[
          Shadow(
            offset: const Offset(10.0, 5.0),
            blurRadius: 10.0,
            color: Colors.black.withOpacity(0.4),
          ),
        ],
      ),
    );
  }

  Widget _getStartedSubTitle({required IAppThemeData appTheme}) {
    return GeneralText(
      Strings.getStartedSubtitle,
      textAlign: TextAlign.center,

      style: appTheme.typographies.interFontFamily.headline7.copyWith(
        color: Colors.white,
        height: 1.5,
        fontWeight: FontWeight.w500,
        fontSize: 16,
        shadows: <Shadow>[
          Shadow(
            offset: const Offset(10.0, 5.0),
            blurRadius: 10.0,
            color: Colors.black.withOpacity(0.4),
          ),
        ],
      ),
      // style: appTheme.typographies.interFontFamily.headline6.copyWith(
      //   color: Colors.white,
      //   fontSize: 15,
      //   shadows: <Shadow>[
      //     Shadow(
      //       offset: Offset(10.0, 5.0),
      //       blurRadius: 10.0,
      //       color: Colors.black.withOpacity(0.4),
      //     ),
      //   ],
      // ),
    );
  }

  Widget _getStartedButtonTitle({required IAppThemeData appTheme}) {
    return GeneralButton.button(
      title: Strings.getStartedButtonTitle.toUpperCase(),
      styleType: ButtonStyleType.fill,
      onTap: () {
        locateService<INavigationService>().navigateTo(route: BottomBarRoute());
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => BottomBar(),
        //     //  HomeScreen(),
        //   ),
        // );
        //    viewModel.goToForgotPasswordScreen();
      },
    );
  }
}
