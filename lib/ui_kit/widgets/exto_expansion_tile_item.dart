import 'package:flutter/material.dart';
import 'package:chef/ui_kit/exto_ui_kit.dart';
import 'package:chef/theme/app_theme_widget.dart';
import 'package:chef/theme/app_theme_data/app_theme_data.dart';

class ExtoExpansionTileItem extends StatelessWidget {
  const ExtoExpansionTileItem({
    required String title,
    required String subTitle,
    bool isSelected = false,
    String? heroText,
    Color? leadingWidgetBackground,
    Key? key,
  })  : _title = title,
        _subtitle = subTitle,
        _isSelected = isSelected,
        _heroText = heroText,
        _leadingWidgetBackground = leadingWidgetBackground,
        super(key: key);

  final String _title;
  final String _subtitle;
  final bool _isSelected;
  final String? _heroText;
  final Color? _leadingWidgetBackground;

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return Container(
      color: appTheme.colors.defaultBackground,
      child: ListTile(
        tileColor: _isSelected
            ? appTheme.colors.selectMenuItemBackground
            : appTheme.colors.secondaryBackground,
        leading: ExtoPlaceholder(
          title: _heroText ?? _title,
          color: _leadingWidgetBackground,
        ),
        title: ExtoText(
          _title,
          typography: TypographyFamily.label6,
        ),
        subtitle: ExtoText(
          _subtitle,
          typography: TypographyFamily.label7,
        ),
      ),
    );
  }
}
