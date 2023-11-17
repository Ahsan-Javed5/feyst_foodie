import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../helpers/device_helper.dart';
import '../../ui_kit/widgets/general_new_appbar.dart';
import '/theme/app_theme_widget.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key,this.longitude, this.latitude,}) : super(key: key);
  final dynamic longitude;
  final dynamic latitude;

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  var darkMapStyle;

  @override
  void initState() {
    _loadMapStyles();
    super.initState();
  }

  Future _loadMapStyles() async {
    darkMapStyle =
    await rootBundle.loadString('assets/json/dark_mode_style.json');
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black26,
      //   centerTitle: true,
      //   iconTheme: const IconThemeData(
      //     color: Colors.white,
      //   ),
      //   title: const Text('Location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white,),),
      // ),
      body: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: appTheme.colors.primary,
                    blurRadius: 400.0,
                    spreadRadius: 70,
                  ),
                ],
              ),
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.latitude, widget.longitude,),
                  zoom: 14.4746,
                ),
                zoomControlsEnabled: true,
                markers: <Marker>{
                  Marker(
                      markerId: const MarkerId('SomeId'),
                      position: LatLng(widget.latitude, widget.longitude,),
                      infoWindow: const InfoWindow(title: '')),
                },
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  controller.setMapStyle(darkMapStyle);
                },
              ),
            ),
          Positioned(
            top: DeviceHelper.height * 0.08,
            left: DeviceHelper.width * 0.05,
            child: Align(
                alignment: Alignment.topLeft, child: GeneralNewAppBar(
              callBack: (){
                setState(() {
                  Navigator.pop(context);
                });
              },
            )),
          ),
        ],
      ),
    );
  }
}
