import 'package:flutter/material.dart';

import 'package:dropdown_search/dropdown_search.dart';

import 'package:chef/services/services.dart';
import 'package:chef/constants/constants.dart';

class ExtoDropdown<T> extends StatefulWidget {
  const ExtoDropdown({
    required List<String> items,
    required String name,
    required FieldOnChange onChange,
    List<String>? selectedItems,
    String? selectedItem,
    bool isSearchable = false,
    bool isMultiSelect = false,
    bool isMandatory = false,
    double margin = 0.0,
    String? Function(List<String>?)? validator,
    Key? key,
  })  : _items = items,
        _name = name,
        _isSearchable = isSearchable,
        _isMultiSelect = isMultiSelect,
        _onChange = onChange,
        _isMandatory = isMandatory,
        _margin = margin,
        _selectedItems = selectedItems,
        _selectedItem = selectedItem,
        _validator = validator,
        super(key: key);

  final String _name;
  final List<String> _items;
  final bool _isSearchable;
  final bool _isMultiSelect;
  final bool _isMandatory;
  final FieldOnChange _onChange;
  final double _margin;
  final List<String>? _selectedItems;
  final String? _selectedItem;
  final String? Function(List<String>?)? _validator;

  @override
  _ExtoDropdownState createState() => _ExtoDropdownState();
}

class _ExtoDropdownState extends State<ExtoDropdown> {
  late String selectedValue;

  @override
  void initState() {
    selectedValue = widget._selectedItem ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget._margin),
      child: widget._isMultiSelect
          ? DropdownSearch<String>.multiSelection(
              autoValidateMode: AutovalidateMode.always,
              items: widget._items,
              popupProps: PopupPropsMultiSelection.menu(
                showSearchBox: widget._isSearchable,
              ),
              selectedItems: widget._selectedItems ?? <String>[],
              validator: widget._isMandatory
                  ? widget._validator ??
                      (List<String>? items) {
                        if (items == null || items.isEmpty) {
                          return Strings.requiredField;
                        } else {
                          return null;
                        }
                      }
                  : null,
              onChanged: (values) {
                widget._onChange.call(
                  key: widget._name,
                  value: values.toString(),
                );
              },
            )
          : DropdownSearch<String>(
              items: widget._items,
              popupProps: PopupProps.menu(
                showSearchBox: widget._isSearchable,
                disabledItemFn: (item) => item.startsWith('I'),
              ),
              selectedItem: selectedValue,
              validator: widget._isMandatory
                  ? (String? item) {
                      if (item == null || item.isEmpty) {
                        return Strings.requiredField;
                      } else {
                        return null;
                      }
                    }
                  : null,
              onChanged: (value) {
                widget._onChange.call(
                  key: widget._name,
                  value: value,
                );
              },
            ),
    );
  }

  String? validatorFunctionMultiple(List<String?>? str) {
    if (str!.isEmpty) {
      return Api.requiredField;
    }
    return null;
  }
}
