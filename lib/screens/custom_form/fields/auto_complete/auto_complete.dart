import 'package:flutter/material.dart';

import 'package:chef/models/models.dart';
import 'package:chef/services/services.dart';
import 'package:chef/ui_kit/exto_ui_kit.dart';
import 'package:chef/screens/custom_form/fields/auto_complete/component/auto_complete_field_v.dart';

class AutoCompleteField extends StatefulWidget {
  const AutoCompleteField({
    required FieldProperties properties,
    required FieldOnChange onChange,
    String? initValue,
    Key? key,
  })  : _properties = properties,
        _onChange = onChange,
        _initValue = initValue ?? '',
        super(key: key);
  final FieldProperties _properties;
  final FieldOnChange _onChange;
  final String _initValue;
  @override
  State<AutoCompleteField> createState() => _AutoCompleteFieldState();
}

class _AutoCompleteFieldState extends State<AutoCompleteField> {
  var selectedRefIDFieldValue = '';

  @override
  void initState() {
    selectedRefIDFieldValue = widget._initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExtoLabelContainer(
      isReadOnly: widget._properties.isReadOnly,
      isMandatory: widget._properties.isMandatory,
      hideLabel: widget._properties.hideLabel,
      label: widget._properties.label,
      helpText: widget._properties.helpText,
      child: InkWell(
        child: AutoCompleteFieldView(
          properties: widget._properties,
          onChange: widget._onChange,
          dataSourceId: widget._properties.dataSourceId,
          labelValue: (widget._properties.optField?.label?.name?.toString())!,
        ),
      ),
    );
  }
}
