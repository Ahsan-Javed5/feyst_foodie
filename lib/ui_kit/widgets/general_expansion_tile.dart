import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:chef/constants/constants.dart';
import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/models.dart';
import 'package:chef/services/services.dart';
import 'package:chef/setup.dart';
import 'package:chef/theme/app_theme_data/app_theme_data.dart';
import 'package:chef/theme/app_theme_widget.dart';
import 'package:chef/ui_kit/general_ui_kit.dart';

typedef OnCustomerSelectCallback = Function(Customer);

class GeneralExpansionTile extends StatelessWidget {
  const GeneralExpansionTile({
    required String title,
    required String subTitle,
    required OnCustomerSelectCallback onCustomerSelect,
    required List<Customer> customers,
    bool isSelected = false,
    String? heroText,
    Color? leadingWidgetBackground,
    Key? key,
  })  : _title = title,
        _subtitle = subTitle,
        _customers = customers,
        _isSelected = isSelected,
        _onCustomerSelect = onCustomerSelect,
        _heroText = heroText,
        _leadingWidgetBackground = leadingWidgetBackground,
        super(key: key);

  final String _title;
  final String _subtitle;
  final List<Customer> _customers;
  final OnCustomerSelectCallback _onCustomerSelect;
  final bool _isSelected;
  final String? _heroText;
  final Color? _leadingWidgetBackground;

  static const _tabIconSize = 16.0;

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;
    final _screenType =
        locateService<IDeviceService>().screenSizeData().screenType;
    final _isTablet = _screenType == ScreenType.medium;
    return Container(
      color: appTheme.colors.secondaryBackground,
      child: ExpansionTile(
        collapsedBackgroundColor: appTheme.colors.secondaryBackground,
        leading: GeneralPlaceholder(
          title: _heroText ?? _title,
          color: _leadingWidgetBackground,
        ),
        title: GeneralText(
          _title,
          typography: TypographyFamily.label6,
        ),
        subtitle: GeneralText(
          _subtitle,
          typography: TypographyFamily.label7,
        ),
        trailing: SvgPicture.asset(
          Resources.expandIcon,
          height: _isTablet ? _tabIconSize : null,
        ),
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _customers.length,
            itemBuilder: (context, index) {
              if (_customers.isEmpty) {
                return const SizedBox();
              } else {
                return InkWell(
                  onTap: () => _onCustomerSelect(_customers[index]),
                  child: GeneralExpansionTileItem(
                    title: _customers[index].name,
                    subTitle: _customers[index].description,
                    isSelected: _isSelected,
                    leadingWidgetBackground: appTheme.colors.stringColor(
                      _customers[index].id.lastNDigits(),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
