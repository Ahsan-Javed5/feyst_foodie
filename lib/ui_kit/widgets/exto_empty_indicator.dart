import 'package:flutter/material.dart';
import 'package:chef/constants/strings.dart';
import 'package:chef/theme/app_theme_data/app_theme_data.dart';
import 'package:chef/theme/app_theme_widget.dart';
import 'package:chef/ui_kit/widgets/exto_text.dart';

class ExtoEmptyIndicator extends StatelessWidget {
  const ExtoEmptyIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return Center(
      child: ExtoText(
        Strings.emptyData,
        typography: TypographyFamily.headline4,
        color: appTheme.colors.defaultText,
      ),
    );
  }
}
