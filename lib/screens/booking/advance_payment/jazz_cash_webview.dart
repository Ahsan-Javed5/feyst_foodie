import 'package:chef/constants/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../constants/strings.dart';
import '../../../models/booking/advance_pending_response.dart';
import '../../../services/application_state.dart';
import '../../../setup.dart';
import '../../../ui_kit/widgets/custom_dialog.dart';
import 'food_item_advance_payment_vm.dart';

class JazzCashWebView extends StatefulWidget {
  const JazzCashWebView({Key? key, required this.bookindData})
      : super(key: key);
  final AdvancePendingResponse bookindData;

  @override
  _JazzCashWebViewState createState() => _JazzCashWebViewState();
}

class _JazzCashWebViewState extends State<JazzCashWebView> {
  late InAppWebViewController webView;
  var url;
  double progress = 0;
  bool isLoading = false;
  final _appService = locateService<ApplicationService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final header = {
      'Authorization': 'Bearer ${_appService.state.userInfo?.t.authToken}',
      //'Content-Type': 'application/json'
    };
    final body = Padding(
      padding: const EdgeInsets.only(
        top: 30,
      ),
      child: InAppWebView(
        initialUrlRequest: widget.bookindData.t.bookingStatus.toUpperCase() ==
                Strings.acceptData
            ? URLRequest(
                url: Uri(
                  path:
                      '${Api.baseURLForJazzCash}experience-booking/confirm-booking/${widget.bookindData.t.id}',
                  scheme: 'https',
                ),
                headers: header,
              )
            : URLRequest(
                url: Uri(
                    path:
                        '${Api.baseURLForJazzCash}experience-booking/complete-booking/${widget.bookindData.t.id}',
                    scheme: 'https'),
                headers: header,
              ),

        //initialUrlRequest: URLRequest(url: Uri(path: 'www.google.com',),),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
              //  debuggingEnabled: true,
              ),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          webView = controller;
        },
        onLoadStart: (InAppWebViewController controller, var url) {
          if (url.toString().contains('feyst://paymentredirect/status=')) {
            isLoading = true;
            var parts = url.toString().split('=');
            parts[1] == 'SUCCESS' ? success(context) : failed(context);
          }
          setState(() {
            this.url = url;
          });
        },
        onLoadStop: (InAppWebViewController controller, var url) async {
          setState(() {
            this.url = url;
          });
        },
        onProgressChanged: (InAppWebViewController controller, int progress) {
          var a;
          setState(() {
            a = controller.getUrl();
            print(a.toString());
            this.progress = progress / 100;
          });
        },
      ),
    );

    return Scaffold(
      body: isLoading ? const Center(child: CircularProgressIndicator()) : body,
    );
  }

  success(context) async {
    print('jazzcash success function call');
    final _foodItemAdvance = locateService<FoodItemAdvancePaymentViewModel>();
    if (widget.bookindData.t.bookingStatus.toUpperCase() ==
        Strings.billGenerated) {
      await _foodItemAdvance.completeBookingStatus(
          context, widget.bookindData.t.brandName,
          bookingId: widget.bookindData.t.id);
    } else {
      await _foodItemAdvance.updateBookingStatus(
          context, widget.bookindData.t.brandName,
          bookingId: widget.bookindData.t.id);
    }
    isLoading = false;
  }

  failed(context) {
    //Navigator.pop(context);
    print('jazzcash failed function call');
    CustomDialog.getDialog(
      ctx: context,
      title: 'We are sorry',
      titleColor: Colors.white,
      descColor: const Color(0xFFfee4a4),
      description: 'Your transaction is not completed',
      iconUrl: 'assets/images/cancel_icon.png',
      onTap: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
  }
}
