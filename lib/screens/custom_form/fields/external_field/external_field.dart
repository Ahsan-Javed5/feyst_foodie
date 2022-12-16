import 'package:flutter/material.dart';

import 'package:chef/models/models.dart';
import 'package:chef/screens/custom_form/fields/external_field/component/external_field_v.dart';
import 'package:chef/services/services.dart';
import 'package:chef/theme/app_theme_widget.dart';
import 'package:chef/ui_kit/general_ui_kit.dart';
import 'package:chef/ui_kit/helpers/dialog_helper.dart';

class ExternalField extends StatefulWidget {
  const ExternalField({
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
  State<ExternalField> createState() => _ExternalFieldState();
}

class _ExternalFieldState extends State<ExternalField> {
  var selectedExtFieldValue = '', selectedExtPrimaryFieldValue = '';

  @override
  void initState() {
    selectedExtFieldValue = widget._initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context).theme;

    return GeneralLabelContainer(
      isReadOnly: widget._properties.isReadOnly,
      isMandatory: widget._properties.isMandatory,
      hideLabel: widget._properties.hideLabel,
      label: widget._properties.label,
      helpText: widget._properties.helpText,
      child: InkWell(
        child: GeneralTextInput(
          isEnable: !widget._properties.isReadOnly,
          controller: TextController(text: selectedExtFieldValue),
          suffixIcon: Icons.search,
          onSuffixIconClick: () async {
            displayExternalField();
          },
          onChanged: (value) async {
            displayExternalField();
          },
          validator: widget._properties.isMandatory
              ? FieldRendererHelpers.validatorFunction
              : null,
          backgroundColor: !widget._properties.isReadOnly
              ? null
              : appTheme.colors.disabledText,
        ),
      ),
    );
  }

  Future<dynamic> _showModalBottomSheet(context) async {
    return await DialogHelper.showBottomSheetDialog(
      context: context,
      body: Container(
        height: 400,
        width: double.infinity,
        color: Colors.grey.shade200,
        alignment: Alignment.center,
        child: ExternalFieldView(
          extId: widget._properties.extField!.id!,
        ),
      ),
    );
  }

  Future<void> displayExternalField() async {
    final extField = await _showModalBottomSheet(context);
    extField != null
        ? setState(() {
            selectedExtFieldValue = extField!.value;
            selectedExtPrimaryFieldValue = extField!.primaryFieldValue;
          })
        : setState(() {
            selectedExtFieldValue = '';
            selectedExtPrimaryFieldValue = '';
          });
    if (selectedExtFieldValue.isNotEmpty) {
      widget._onChange.call(
        key: widget._properties.name,
        value: {selectedExtPrimaryFieldValue: selectedExtFieldValue},
      );
    }
  }
}
