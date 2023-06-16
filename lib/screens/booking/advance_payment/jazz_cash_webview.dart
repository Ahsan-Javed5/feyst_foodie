import 'package:chef/constants/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../../setup.dart';
import 'food_item_advance_payment_vm.dart';

class JazzCashWebView extends StatefulWidget {
  const JazzCashWebView({Key? key, required this.bookingId}) : super(key: key);
  final bookingId;

  @override
  _JazzCashWebViewState createState() => _JazzCashWebViewState();
}

class _JazzCashWebViewState extends State<JazzCashWebView> {
  late InAppWebViewController webView;
  var url;
  double progress = 0;
  bool isLoading = false;

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
    final appBar = AppBar(
      elevation: 1.0,
      backgroundColor: Colors.orangeAccent,
      title: const Text('JazzCash Payment'),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );

    final body = Padding(
      padding: const EdgeInsets.only(top: 30,),
      child: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri(path: '${Api.baseURLForJazzCash}experience-booking/confirm-booking/${widget.bookingId}',scheme: 'https'),),
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
          if(url.toString().contains('feyst://paymentredirect/status=')){
            isLoading = true;
            var parts  = url.toString().split('=');
            parts[1] == 'SUCCESS' ? success(): failed();
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
      body: isLoading ? const Center(child: CircularProgressIndicator()):body,
    );
  }

  success() async {
    final _foodItemAdvance =
    locateService<FoodItemAdvancePaymentViewModel>();
    await _foodItemAdvance.updateBookingStatus(bookingId: widget.bookingId);
    isLoading = false;
  }

  failed(){}
}