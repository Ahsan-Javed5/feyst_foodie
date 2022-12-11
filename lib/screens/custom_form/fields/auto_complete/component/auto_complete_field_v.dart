import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chef/theme/theme.dart';
import 'package:chef/base/base.dart';
import 'package:chef/services/services.dart';
import 'package:chef/ui_kit/exto_ui_kit.dart';
import 'package:chef/screens/custom_form/fields/auto_complete/component/auto_complete_field_vm.dart';
import 'package:chef/screens/custom_form/fields/auto_complete/component/auto_complete_field_m.dart';
import 'package:chef/models/custom_forms/external_fields/external_field.dart';
import 'package:chef/models/referencetable_response.dart';

import 'package:chef/constants/strings.dart';

import 'package:chef/models/custom_forms/custom_form.dart';

class AutoCompleteFieldView extends BaseView<AutoCompleteFieldViewModel> {
  AutoCompleteFieldView({
    required FieldProperties properties,
    required FieldOnChange onChange,
    required String dataSourceId,
    required String labelValue,
    Key? key,
  })  : _properties = properties,
        _onChange = onChange,
        _dataSourceId = dataSourceId,
        _labelValue = labelValue,
        super(key: key);

  final FieldProperties _properties;
  final FieldOnChange _onChange;
  final String _dataSourceId;
  final String _labelValue;
  static const _defaultSize = 50.0;
  static String selectedRefIDFieldValue = '';
  @override
  Widget buildScreen({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    viewModel.loadFields(
      context: context,
      dataSourceId: _dataSourceId,
    );

    const loadingIndicator = SizedBox(
      width: _defaultSize,
      height: _defaultSize,
      child: ExtoLoading(),
    );

    final appTheme = AppTheme.of(context).theme;

    return BlocBuilder<AutoCompleteFieldViewModel, AutoCompleteFieldState>(
      bloc: viewModel,
      builder: (_, state) {
        return (state is Loading)
            ? loadingIndicator
            : _buildRecordList(
                appTheme: appTheme,
                fields: (state as Loaded).referenceTableRecord,
                context: context,
                state: state,
              );
      },
    );
  }

  Widget _buildRecordList({
    required IAppThemeData appTheme,
    required ReferenceTableRecord fields,
    required AutoCompleteFieldState state,
    required BuildContext context,
  }) {
    return ExtoDropdown(
      items: viewModel.getData(fields, _labelValue),
      isSearchable: true,
      name: Strings.referenceIDTitleName,
      onChange: ({
        required String key,
        required dynamic value,
      }) {
        final selectedReferenceTableField = ExtFieldSend(
          title: value,
          value: value,
          primaryFieldValue: value,
        );

        selectedRefIDFieldValue = selectedReferenceTableField.value.isNotEmpty
            ? selectedReferenceTableField.value
            : '';

        if (selectedRefIDFieldValue.isNotEmpty) {
          _onChange.call(
            key: _properties.name,
            value: {
              Strings.referenceIDSubmitLabel: selectedRefIDFieldValue,
              Strings.referenceIDSubmitValue: selectedRefIDFieldValue,
              Strings.referenceIDSubmitRefId: _properties.dataSourceId,
            },
          );
        }
      },
    );
  }
}
