import 'package:flutter/material.dart';

import 'package:dropdown_search/dropdown_search.dart';

import 'package:chef/services/services.dart';
import 'package:chef/constants/constants.dart';

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
    double margin = 0.0,
    String? Function(List<String>?)? validator,
    Key? key,
  })  : _items = items,
        _name = name,
        _isSearchable = isSearchable,
        _isMultiSelect = isMultiSelect,
        _onChange = onChange,
        _borderColor = borderColor,
        _isMandatory = isMandatory,
        _margin = margin,
        _selectedItems = selectedItems,
        _selectedItem = selectedItem,
        _validator = validator,
        super(key: key);

  final String _name;
  // final List<dynamic> _items;
  final List<DropdownMenuItem<String>> _items;
  final bool _isSearchable;
  final bool _isMultiSelect;
  final bool _isMandatory;
  final Color? _borderColor;
  final FieldOnChange _onChange;
  final double _margin;
  final List<String>? _selectedItems;
  final String? _selectedItem;
  final String? Function(List<String>?)? _validator;

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
    return SizedBox(
        // Container(
        height: 55.0,
        //   width: 200.0,
        child: DecoratedBox(
            decoration: BoxDecoration(
              // gradient: LinearGradient(colors: [
              //   Colors.redAccent,
              //   Colors.blueAccent,
              //   Colors.purpleAccent
              //   //add more colors
              // ]),
              //  border: Border.all((widget._borderColor)!, width: 3),
              border: Border.all(
                  color: widget._borderColor ?? Color.fromRGBO(0, 0, 0, 0.57),
                  width: 3),
              //backgroundColor: appTheme.colors.textFieldFilledColor,
              borderRadius: BorderRadius.circular(10),

              // boxShadow: <BoxShadow>[
              //   BoxShadow(
              //       color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
              //       blurRadius: 5) //blur radius of shadow
              // ]
            ),
            child: Padding(
              // padding: EdgeInsets.all(widget._margin),
              padding: const EdgeInsets.only(left: 13, right: 30, top: 3),
              child: widget._items.isNotEmpty
                  ? DropdownButton(
                      value: 'Scientist',
                      // autoValidateMode: AutovalidateMode.always,
                      items: widget._items,
                      // popupProps: PopupPropsMultiSelection.menu(
                      //   showSearchBox: widget._isSearchable,
                      // ),

                      //selectedItems: widget._selectedItems ?? <String>[],
                      // validator: widget._isMandatory
                      //     ? widget._validator ??
                      //         (List<String>? items) {
                      //           if (items == null || items.isEmpty) {
                      //             return Strings.requiredField;
                      //           } else {
                      //             return null;
                      //           }
                      //         }
                      //     : null,
                      onChanged: (values) {
                        widget._onChange.call(
                          key: widget._name,
                          value: values.toString(),
                        );
                      },
                      iconEnabledColor: Colors.white, //Icon color
                      style: const TextStyle(
                          //te
                          color: Colors.white, //Font color
                          fontSize: 20 //font size on dropdown button
                          ),
                      elevation: 40,
                      dropdownColor:
                          Colors.redAccent, //dropdown background color
                      underline: Container(), //remove underline
                      isExpanded: true,
                    )
                  : Container(),
            )));
  }

  String? validatorFunctionMultiple(List<String?>? str) {
    if (str!.isEmpty) {
      return Api.requiredField;
    }
    return null;
  }
}
