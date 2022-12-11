import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chef/base/base.dart';
import 'package:chef/constants/constants.dart';
import 'package:chef/helpers/helpers.dart';
import 'package:chef/services/services.dart';
import 'package:chef/theme/app_theme_widget.dart';
import 'package:chef/ui_kit/exto_ui_kit.dart';
import 'package:chef/screens/navdrawer/navdrawer_m.dart';
import 'package:chef/screens/navdrawer/navdrawer_vm.dart';

class NavDrawerView extends BaseView<NavDrawerViewModel> {
  NavDrawerView({Key? key}) : super(key: key);

  late final Map<DrawerItem, Function?> drawerItemsMap = {
    DrawerItem(
      id: NavigationDrawer.home,
      title: Strings.menuTitleHome,
      selectedIconData: Icons.home,
      unselectedIconData: Icons.home_outlined,
    ): viewModel.navigateToHome,
    DrawerItem(
      id: NavigationDrawer.module,
      title: Strings.menuTitleModules,
      unselectedIconData: Icons.dynamic_form_outlined,
      selectedIconData: Icons.dynamic_form,
    ): viewModel.navigateToModules,
    DrawerItem(
      id: NavigationDrawer.workspace,
      title: Strings.menuTitleWorkspaces,
      selectedIconData: Icons.work_outlined,
      unselectedIconData: Icons.work_outline_outlined,
    ): viewModel.navigateToWorkspace,
    DrawerItem(
      id: NavigationDrawer.projects,
      title: Strings.menuTitleProjects,
      selectedIconData: Icons.folder,
      unselectedIconData: Icons.folder_outlined,
    ): viewModel.navigateToProjects,
  };

  @override
  Widget buildScreen({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    viewModel.fetchData();
    final appTheme = AppTheme.of(context).theme;
    return BlocBuilder<NavDrawerViewModel, NavDrawerState>(
      bloc: viewModel,
      builder: (_, state) {
        return SafeArea(
          child: Drawer(
            child: Column(
              children: [
                Expanded(
                  flex: 9,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ExtoExpansionTile(
                          title: state.selectedCustomer!.name,
                          subTitle: state.selectedCustomer!.description,
                          customers: state.customersList!,
                          onCustomerSelect: (customer) =>
                              viewModel.updateCustomer(
                            context: context,
                            item: customer,
                          ),
                          leadingWidgetBackground: appTheme.colors.stringColor(
                            (state.selectedCustomer?.id.lastNDigits())!,
                          ),
                          isSelected: state.index == (viewModel.state.index),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: drawerItemsMap.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Visibility(
                                  child: ExtoDivider(
                                    height: 1.0,
                                    color: appTheme.colors.defaultBackground,
                                  ),
                                  visible: index == drawerItemsMap.length - 1,
                                ),
                                InkWell(
                                  onTap: () {
                                    viewModel.updateSelectedNavId(
                                      drawerItemsMap.keys.toList()[index].id,
                                    );

                                    drawerItemsMap[
                                            drawerItemsMap.keys.toList()[index]]
                                        ?.call();
                                  },
                                  child: ExtoDrawerItem(
                                    drawerItem:
                                        drawerItemsMap.keys.toList()[index],
                                    isSelected: drawerItemsMap.keys
                                            .toList()[index]
                                            .id ==
                                        (viewModel.state).index,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Column(
                    children: [
                      ExtoDivider(
                        height: 1.0,
                        color: appTheme.colors.defaultBackground,
                      ),
                      InkWell(
                        onTap: () => viewModel.navigateToProfile(
                          isMobile:
                              screenSizeData.screenType == ScreenType.small,
                        ),
                        child: ExtoFooterItem(
                          title: state.user!.fullname,
                          subTitle: state.user!.email,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DrawerItem {
  DrawerItem({
    required this.id,
    required this.title,
    this.selectedIconData,
    this.unselectedIconData,
    this.iconAsset,
  });
  final NavigationDrawer id;
  final String title;
  final IconData? selectedIconData;
  final IconData? unselectedIconData;
  final String? iconAsset;
}
