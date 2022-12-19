// import 'package:flutter/material.dart';
//
//
// class BottomBar extends StatefulWidget {
//   const BottomBar({Key? key}) : super(key: key);
//
//   @override
//   State<BottomBar> createState() => _BottomBarState();
// }
//
// class _BottomBarState extends State<BottomBar> with WidgetsBindingObserver {
//
//   final GlobalKey<ScaffoldState>? drawerKey = GlobalKey();
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return
//      Scaffold(bottomNavigationBar:  _bottomNavigationContainer(context)
//      );
//   }
//
//   Widget _bottomNavigationContainer(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       color: ZainColors.instance.appWhite,
//       padding:
//       EdgeInsets.symmetric(horizontal: DynamicSize.exactWidth(10, context)),
//       height: DynamicSize.exactHeight(
//           ScreenSize.deviceSize(context) == DeviceSize.small ? 75 : 70,
//           context),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           _itemBar(
//               context,
//               'home.png',
//               getIt<Localization>()
//                   .localization(getIt<AppRoutes>().navigatorKey.currentContext!)
//                   .mtLocalized('bottomBarScreen_home'),
//               BottomBarType.home),
//           // SizedBox(
//           //   width: DynamicSize.exactWidth(37, context),
//           // ),
//           _itemBar(
//               context,
//               'transaction.png',
//               getIt<Localization>()
//                   .localization(getIt<AppRoutes>().navigatorKey.currentContext!)
//                   .mtLocalized('bottomBarScreen_transactions'),
//               BottomBarType.transactions),
//           // SizedBox(
//           //   width: DynamicSize.exactWidth(37, context),
//           // ),
//           _itemBar(
//               context,
//               'favourites.png',
//               getIt<Localization>()
//                   .localization(getIt<AppRoutes>().navigatorKey.currentContext!)
//                   .mtLocalized('bottomBarScreen_favourites'),
//               BottomBarType.notifications),
//           // SizedBox(
//           //   width: DynamicSize.exactWidth(37, context),
//           // ),
//           _itemBar(
//               context,
//               'account.png',
//               getIt<Localization>()
//                   .localization(getIt<AppRoutes>().navigatorKey.currentContext!)
//                   .mtLocalized('bottomBarScreen_account'),
//               BottomBarType.account),
//         ],
//       ),
//     );
//   }
//
//   Widget _itemBar(BuildContext context, String imagePath, String title,
//       BottomBarType type) {
//     return InkWell(
//       onTap: () {
//
//       },
//       child: Column(
//         children: [
//           AnimatedContainer(
//               duration: const Duration(milliseconds: 400),
//               curve: Curves.easeInToLinear,
//               height: 3,
//               width: DynamicSize.exactWidth(50, context),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50), // radius of 10
//                   color: _screenViewModel.selectedType == type
//                       ? ZainColors.instance.appBackGroundColor
//                       : Colors.transparent // green as background color
//               )),
//           SizedBox(
//             height: DynamicSize.exactHeight(10, context),
//           ),
//           Image.asset(
//             AssetsConstants().dashboard + imagePath,
//             color: _screenViewModel.selectedType == type
//                 ? ZainColors.instance.appBackGroundColor
//                 : ZainColors.instance.appDarkGrey,
//           ),
//           SizedBox(
//             height: DynamicSize.exactHeight(3, context),
//           ),
//           Text(title).fontSize(12).giloryMedium(
//             color: _screenViewModel.selectedType == type
//                 ? ZainColors.instance.appBackGroundColor
//                 : ZainColors.instance.appDarkGrey,
//           ),
//         ],
//       ),
//     );
//   }
//
//
//
//
//
// }
