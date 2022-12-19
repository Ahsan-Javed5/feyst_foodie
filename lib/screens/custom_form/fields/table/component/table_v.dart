import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chef/base/base.dart';
import 'package:chef/ui_kit/general_ui_kit.dart';
import 'package:chef/services/services.dart';
import 'package:chef/models/models.dart';
import 'package:chef/screens/custom_form/fields/custom_fields.dart';
import 'package:chef/screens/custom_form/fields/table/component/table_m.dart';
import 'package:chef/screens/custom_form/fields/table/component/table_vm.dart';

class TableView extends BaseView<TableViewModel> {
  TableView({
    required FieldOnChange onChange,
    required FieldProperties properties,
    required String recordId,
    bool isInEditMode = false,
    Key? key,
  })  : _onChange = onChange,
        _properties = properties,
        _recordId = recordId,
        _isInEditMode = isInEditMode,
        super(key: key);

  final FieldOnChange _onChange;
  final FieldProperties _properties;
  final String? _recordId;
  final bool? _isInEditMode;

  @override
  Widget buildScreen({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    return BlocBuilder<TableViewModel, TableState>(
      bloc: viewModel
        ..loadFormOfTable(
          context,
          _recordId,
          _isInEditMode,
        ),
      builder: (_, state) {
        return (state is Loading)
            ? const GeneralLoading()
            : ExtoTable(
                properties: _properties,
                onChange: _onChange,
                fields: (state as Loaded).subTableData,
              );
      },
    );
  }
}
