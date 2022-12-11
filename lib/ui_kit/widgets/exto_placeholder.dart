import 'package:flutter/material.dart';

import 'package:chef/helpers/helpers.dart';
import 'package:chef/theme/theme.dart';
import 'package:chef/ui_kit/exto_ui_kit.dart';

class ExtoPlaceholder extends StatelessWidget {
  const ExtoPlaceholder({
    required String title,
    Color? color,
    Key? key,
  })  : _title = title,
        _color = color,
        super(key: key);

  final String _title;
  final Color? _color;

  double get _size => 52.0;

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: ExtoText(
          _title.getShortName(),
          style: appTheme.typographies.interFontFamily.label2.copyWith(
            color: appTheme.colors.secondaryBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
