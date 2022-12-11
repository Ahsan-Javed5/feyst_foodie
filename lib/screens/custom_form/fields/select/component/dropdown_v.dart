import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chef/base/base.dart';
import 'package:chef/ui_kit/exto_ui_kit.dart';
import 'package:chef/services/services.dart';
import 'package:chef/models/models.dart';
import 'package:chef/screens/custom_form/fields/select/component/dropdown_m.dart';
import 'package:chef/screens/custom_form/fields/select/component/dropdown_vm.dart';

class DropdownView extends BaseView<DropdownViewModel> {
  DropdownView({
    required FieldProperties properties,
    required FieldOnChange onChange,
    List<String>? selectedItems,
    String? selectedItem,
    Key? key,
  })  : _properties = properties,
        _onChange = onChange,
        _selectedItems = selectedItems,
        _selectedItem = selectedItem,
        super(key: key);

  final FieldProperties _properties;
  final FieldOnChange _onChange;
  final List<String>? _selectedItems;
  final String? _selectedItem;
  static const _defaultSize = 50.0;

  @override
  Widget buildScreen({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    viewModel.loadDropdownDataSet(
      context: context,
      properties: _properties,
    );
    const loadingIndicator = SizedBox(
      width: _defaultSize,
      height: _defaultSize,
      child: ExtoLoading(),
    );
    return BlocBuilder<DropdownViewModel, DropdownState>(
      bloc: viewModel,
      builder: (_, state) {
        return (state is Loading)
            ? loadingIndicator
            : _buildDropdown(
                state: state as Loaded,
              );
      },
    );
  }

  Widget _buildDropdown({
    required Loaded state,
  }) {
    final dropdownItems = <String>[];
    if (state.itemsData.isNotEmpty) {
      for (final item in state.itemsData) {
        dropdownItems.add(item.label);
      }
    }
    return ExtoLabelContainer(
      isReadOnly: _properties.isReadOnly,
      isMandatory: _properties.isMandatory,
      hideLabel: _properties.hideLabel,
      label: _properties.label,
      helpText: _properties.helpText,
      child: ExtoDropdown(
        items: dropdownItems,
        isMultiSelect: _properties.isMultiSelect,
        isSearchable: _properties.isSearchable,
        onChange: _onChange,
        name: _properties.name,
        isMandatory: _properties.isMandatory,
        selectedItems: _selectedItems,
        selectedItem:
            dropdownItems.isNotEmpty && dropdownItems.contains(_selectedItem)
                ? _selectedItem
                : '',
      ),
    );
  }
}
