import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chef/constants/constants.dart';
import 'package:chef/ui_kit/widgets/exto_home_item.dart';
import 'package:chef/screens/home/home_screen_m.dart';
import 'package:chef/screens/home/home_screen_vm.dart';
import 'package:chef/services/services.dart';
import 'package:chef/ui_kit/exto_ui_kit.dart';
import 'package:chef/base/base.dart';

class HomeScreen extends BaseView<HomeScreenViewModel> with ScreenLayoutBase {
  HomeScreen({Key? key}) : super(key: key);
  final scaffoldKeyHome = GlobalKey<ScaffoldState>();
  static const _sizedBoxSpaces = 8.0;
  static const _allSizePadding = 8.0;

  @override
  Widget body(
    BuildContext context,
    ScreenSizeData screenSizeData,
  ) {
    return BlocBuilder<HomeScreenViewModel, HomeScreenState>(
      bloc: viewModel,
      builder: (_, state) {
        return WillPopScope(
          onWillPop: () => viewModel.logoutPopUp(context),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(_allSizePadding),
                child: Column(
                  children: [
                    ExtoHomeItem(
                      icon: Icons.dashboard_outlined,
                      text: Strings.dashboard,
                      onTap: () {
                        viewModel.navigateToDashboardScreen();
                      },
                    ),
                    const SizedBox(
                      height: _sizedBoxSpaces,
                    ),
                    ExtoHomeItem(
                      icon: Icons.dynamic_form_outlined,
                      text: Strings.customForm,
                      onTap: () {
                        viewModel.navigateToModulesScreen();
                      },
                    ),
                  ],
                ),
              ),
              if (state is Loading) const Center(child: ExtoLoading()),
            ],
          ),
        );
      },
    );
  }

  @override
  Future<void> suffixIconTap(BuildContext context) async {}

  @override
  void onSearchChange(String value) {}
}
