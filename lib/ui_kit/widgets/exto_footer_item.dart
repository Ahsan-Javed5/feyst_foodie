import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:chef/constants/resources.dart';
import 'package:chef/services/services.dart';
import 'package:chef/setup.dart';
import 'package:chef/theme/theme.dart';
import 'package:chef/ui_kit/exto_ui_kit.dart';

class ExtoFooterItem extends StatelessWidget {
  const ExtoFooterItem({
    required String title,
    required String subTitle,
    Key? key,
  })  : _title = title,
        _subtitle = subTitle,
        super(key: key);

  final String _title;
  final String _subtitle;

  static const _mobileRadius = 20.0;
  static const _tabRadius = 22.0;

  @override
  Widget build(BuildContext context) {
    final _screenSize = locateService<IDeviceService>().screenSizeData();
    final _appTheme = AppTheme.of(context).theme;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _appTheme.colors.workspaceIcon,
        radius: _screenSize.screenType == ScreenType.small
            ? _mobileRadius
            : _tabRadius,
        child: SvgPicture.asset(Resources.userProfileIcon),
      ),
      title: ExtoText(
        _title,
        typography: TypographyFamily.label6,
      ),
      subtitle: ExtoText(
        _subtitle,
        typography: TypographyFamily.label7,
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
