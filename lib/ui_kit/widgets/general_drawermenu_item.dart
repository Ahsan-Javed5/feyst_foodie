import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:chef/screens/navdrawer/navdrawer_v.dart';
import 'package:chef/theme/theme.dart';
import 'package:chef/ui_kit/widgets/general_text.dart';

class GeneralDrawerItem extends StatelessWidget {
  const GeneralDrawerItem({
    required DrawerItem drawerItem,
    bool isSelected = false,
    Key? key,
  })  : _drawerItem = drawerItem,
        _isSelected = isSelected,
        super(key: key);

  final DrawerItem _drawerItem;
  final bool _isSelected;

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return Container(
      decoration: _isSelected
          ? appTheme.selectedMenuItemDecoration
          : appTheme.unselectedMenuItemDecoration,
      child: ListTile(
        tileColor: _isSelected
            ? appTheme.colors.selectMenuItemBackground
            : appTheme.colors.secondaryBackground,
        minLeadingWidth: 1,
        leading: _leadingWidget(appTheme),
        title: GeneralText(
          _drawerItem.title,
          typography: TypographyFamily.label8,
        ),
      ),
    );
  }

  Widget _leadingWidget(
    IAppThemeData appTheme,
  ) {
    final _color = _isSelected ? appTheme.colors.selectedItemBackground : null;
    if (_drawerItem.iconAsset == null) {
      return Icon(
        _isSelected
            ? _drawerItem.selectedIconData
            : _drawerItem.unselectedIconData,
        color: _color,
      );
    }
    return SvgPicture.asset(
      _drawerItem.iconAsset!,
      height: 20,
      width: 20,
      color: _color,
    );
  }
}
