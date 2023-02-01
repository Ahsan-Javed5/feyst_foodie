import 'package:flutter/material.dart';
import 'package:chef/theme/app_theme_widget.dart';
import 'package:chef/ui_kit/widgets/general_text.dart';

import 'dart:developer' as developer;

enum Gender {
  male,
  female,
}

class GeneralGender extends StatefulWidget {
  const GeneralGender({
    required String text,
    required Gender gender,
    required Gender selectedItem,
    required Function(String) onTap,
    IconData? icon,
    Key? key,
  })  : _text = text,
        _gender = gender,
        _selectedItem = selectedItem,
        _icon = icon,
        _onTap = onTap,
        super(key: key);
  final String _text;
  final Gender _gender;
  final Gender _selectedItem;
  final IconData? _icon;
  final Function(String) _onTap;

  @override
  _GeneralGenderState createState() => _GeneralGenderState();
}

class _GeneralGenderState extends State<GeneralGender> {
  late String selectedValue;

  static const _boxHeight = 35.0;
  static const _boxBottomHeight = 40.0;
  static const _verticalPadding = 20.0;

  @override
  void initState() {
    selectedValue = widget._selectedItem.name ?? '';
    developer.log(' Selected Value is ' + '${selectedValue}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;

    return InkWell(
        onTap: () {
          widget._onTap.call(selectedValue);
        },
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: GeneralText(
              widget._text,
              textAlign: TextAlign.center,
              style: appTheme.typographies.interFontFamily.headline2.copyWith(
                  //   color: widget._selectedItem == widget._gender ? Colors.black : Colors.white,
                  color: widget._selectedItem.name == selectedValue
                      ? Colors.black
                      : Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(
                border: Border.all(
                    color: appTheme.colors
                        .textFieldBorderColor // green as background color

                    ),
                borderRadius: BorderRadius.circular(10), // radius of 10
                //   color: widget._selectedItem == widget._gender

                color: widget._selectedItem.name == selectedValue
                    ? appTheme.colors.textFieldBorderColor
                    : appTheme.colors.primaryBackground)));
  }
}
