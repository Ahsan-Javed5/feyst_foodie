import 'package:flutter/material.dart';

import 'package:chef/helpers/enum_helper.dart';
import 'package:chef/ui_kit/general_ui_kit.dart';
import 'package:chef/services/services.dart';

class CheckBoxListItem extends StatefulWidget {
  const CheckBoxListItem({
    required String id,
    required String label,
    required String value,
    required FieldOnChange onChange,
    bool isHidden = false,
    bool isDisabled = false,
    Key? key,
  })  : _label = label,
        _id = id,
        _value = value,
        _isHidden = isHidden,
        _isDisabled = isDisabled,
        _onchange = onChange,
        super(key: key);

  final String _id;
  final String _value;
  final String _label;
  final bool _isHidden;
  final bool _isDisabled;

  final FieldOnChange _onchange;

  @override
  State<CheckBoxListItem> createState() => _CheckBoxListItemState();
}

class _CheckBoxListItemState extends State<CheckBoxListItem> {
  var _selectedOptionValue = SelectableStatus.unchecked;
  static const _padding = 8.0;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget._isDisabled,
      child: Visibility(
        visible: !widget._isHidden,
        child: Padding(
          padding: const EdgeInsets.all(_padding),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.33,
            child: GeneralSelectable.checkbox(
              onTap: (selectable) {
                setState(() {
                  if (selectable.status == SelectableStatus.checked) {
                    _selectedOptionValue = SelectableStatus.unchecked;
                  } else {
                    _selectedOptionValue = SelectableStatus.checked;
                  }
                  widget._onchange.call(
                    key: widget._id,
                    value: EnumHelpers.humanize(_selectedOptionValue),
                  );
                });
              },
              selectable: SelectableModel(
                id: widget._value,
                label: widget._label,
                value: widget._value,
                status: _selectedOptionValue,
                checkedColor: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
