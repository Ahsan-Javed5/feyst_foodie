import 'package:flutter/material.dart';

import 'package:chef/ui_kit/exto_ui_kit.dart';

class RadioUi extends StatelessWidget {
  const RadioUi({
    required List<SelectableModel> options,
    required Function({
      required String optionValue,
      required int selectedIndex,
    })
        onOptionSelect,
    this.selectedIndex,
    Key? key,
  })  : _options = options,
        _onOptionSelect = onOptionSelect,
        super(key: key);

  final List<SelectableModel> _options;
  final Function({
    required String optionValue,
    required int selectedIndex,
  }) _onOptionSelect;
  final int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [...buildOptions()],
    );
  }

  List<Widget> buildOptions() {
    final options = <Widget>[];
    for (var index = 0; index < _options.length; index++) {
      final option = _options[index];
      options.add(
        Expanded(
          child: ExtoSelectable.radio(
            onTap: (selectable) {
              _onOptionSelect(
                optionValue: selectable.value,
                selectedIndex: index,
              );
            },
            selectable: SelectableModel(
              id: option.value,
              label: option.label,
              value: option.value,
              status: selectedIndex == null
                  ? option.status
                  : index == selectedIndex
                      ? SelectableStatus.checked
                      : SelectableStatus.unchecked,
              checkedColor: option.checkedColor,
            ),
          ),
        ),
      );
    }
    return options;
  }
}
