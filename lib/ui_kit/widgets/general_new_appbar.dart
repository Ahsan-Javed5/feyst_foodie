import 'package:chef/helpers/helpers.dart';
import 'package:chef/screens/bottom_bar/bottom_bar.dart' as bottom_bar;
import '/setup.dart';

class GeneralNewAppBar extends StatelessWidget {
  final String? title;
  final Color? titleColor;
  final String? rightIcon;
  final Function()? callBack;
  const GeneralNewAppBar(
      {Key? key, this.title, this.titleColor, this.rightIcon, this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    final _navigationService = locateService<INavigationService>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: DeviceHelper.width * 0.015,
        ),
        // Image.asset(Resources.appBackIcon,height: 35,),
        InkWell(
          onTap: callBack ??
              () {
                Navigator.pop(context);
              },
          //     () {
          //    //Navigator.pop(context);
          //   //_navigationService.navigateTo(route:BottomBar());
          //
          //   // _navigationService.replace(context);
          //
          //   // _navigationService.replace(route: BottomBar());
          //   //    Navigator.p
          // },
          child: SvgPicture.asset(
            Resources.appBackIconSVG,
            height: DeviceHelper.height * 0.0425,
          ),
        ),
        if (title != null) ...[
          const Spacer(),
          GeneralText(
            title ?? '',
            textAlign: TextAlign.center,
            style: appTheme.typographies.interFontFamily.headline5.copyWith(
                color: titleColor, fontWeight: FontWeight.bold, fontSize: 23),
          ),
        ],
        if (rightIcon != null) ...[
          const Spacer(),
          InkWell(
            onTap: () => _navigationService.navigateTo(
              route:
                  BottomBarRoute(bottomBarType: bottom_bar.BottomBarType.home),
            ),
            child: SvgPicture.asset(
              rightIcon!,
              height: DeviceHelper.height * 0.0345,
            ),
          ),
          SizedBox(
            width: DeviceHelper.width * 0.035,
          ),
        ]
      ],
    );
  }
}
