import 'package:flutter/material.dart';

import 'package:dropdown_search/dropdown_search.dart';

import 'package:chef/services/services.dart';
import 'package:chef/constants/constants.dart';
import 'package:flutter_svg/svg.dart';

class GeneralDropdown<T> extends StatefulWidget {
  const GeneralDropdown({
    required List<DropdownMenuItem<String>> items,
    required String name,
    required FieldOnChange onChange,
    Color? borderColor,
    List<String>? selectedItems,
    String? selectedItem,
    bool isSearchable = false,
    bool isMultiSelect = false,
    bool isMandatory = false,
    bool isExpanded = true,
    double margin = 0.0,
    String? Function(List<String>?)? validator,
    double borderWidth = 2.0,
    Key? key,
  })  : _items = items,
        _name = name,
        _isSearchable = isSearchable,
        _isMultiSelect = isMultiSelect,
        _onChange = onChange,
        _borderColor = borderColor,
        _isMandatory = isMandatory,
        _isExpanded = isExpanded,
        _margin = margin,
        _selectedItems = selectedItems,
        _selectedItem = selectedItem,
        _validator = validator,
        _borderWidth = borderWidth,
        super(key: key);

  final String _name;
  // final List<dynamic> _items;
  final List<DropdownMenuItem<String>> _items;
  final bool _isSearchable;
  final bool _isMultiSelect;
  final bool _isMandatory;
  final bool _isExpanded;
  final Color? _borderColor;
  final FieldOnChange _onChange;
  final double _margin;
  final List<String>? _selectedItems;
  final String? _selectedItem;
  final String? Function(List<String>?)? _validator;
  final double _borderWidth;

  @override
  _GeneralDropdownState createState() => _GeneralDropdownState();
}

class _GeneralDropdownState extends State<GeneralDropdown> {
  late String selectedValue;

  @override
  void initState() {
    selectedValue = widget._selectedItem ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: widget._borderColor ?? const Color.fromRGBO(0, 0, 0, 0.57),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButton(
            items: widget._items,
            isExpanded: true,
            value: 'Scientist',
            focusColor: Colors.white,
            iconSize: 36,
            style: const TextStyle(
              color: Colors.white, //Font color
              fontSize: 20, //font size on dropdown button
            ),
            underline: Container(),
            iconEnabledColor: widget._borderColor,
            dropdownColor: const Color.fromRGBO(0, 0, 0, 0.57),
            onChanged: (value) {},
          ),
        ));
  }

  String? validatorFunctionMultiple(List<String?>? str) {
    if (str!.isEmpty) {
      return Api.requiredField;
    }
    return null;
  }
}
