import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../constants/resources.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/device_helper.dart';
import '../../ui_kit/widgets/general_new_appbar.dart';


class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy(this.routeText, {Key? key}) : super(key: key);
  final String routeText;

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    setState(() {
      isLoading = true;
    });
    return Scaffold(
      backgroundColor: HexColor.fromHex("#212129"),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: DeviceHelper.height * 0.065,
            ),
            Container(
              padding: EdgeInsets.only(
                left: DeviceHelper.height * 0.015,
                top: DeviceHelper.height * 0.0025,
                bottom: DeviceHelper.height * 0.025,
              ),
              child: GeneralNewAppBar(
                rightIcon: Resources.homeIconSvg,
                title: widget.routeText == 'terms' ? 'Terms &\nConditions':'Privacy Policy',
                titleColor: Colors.white,
                callBack: (){
                  Navigator.pop(context);
                 // _navigation.navigateTo(route:BottomBar(bottomBarType: bottom_bar.BottomBarType.home));
                },
              ),
            ),
            SizedBox(
              //margin: EdgeInsets.only(left: 15, right: 15, top: 15,),
              height: DeviceHelper.height * (widget.routeText == 'terms' ? 0.812 : 0.862),
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                    url: Uri.parse(widget.routeText=='terms' ? 'http://localhost:8080/assets/terms.html':'http://localhost:8080/assets/privacy.html')),
              ),
            ),
          ]),
    );
  }
}