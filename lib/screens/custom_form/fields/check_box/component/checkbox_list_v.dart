import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chef/base/base.dart';
import 'package:chef/constants/constants.dart';
import 'package:chef/theme/app_theme_data/app_theme_data.dart';
import 'package:chef/theme/app_theme_widget.dart';
import 'package:chef/ui_kit/exto_ui_kit.dart';
import 'package:chef/services/services.dart';
import 'package:chef/screens/custom_form/fields/check_box/component/checkbox_list_vm.dart';
import 'package:chef/screens/custom_form/fields/check_box/component/checkbox_list_m.dart';

class CheckBoxListView extends BaseView<CheckBoxListViewModel> {
  CheckBoxListView({
    required String label,
    required String name,
    required String orientation,
    required bool isMandatory,
    required bool isReadonly,
    required bool hasLabel,
    required FieldOnChange onChange,
    required String datasetId,
    List<String>? selectedIDs,
    Key? key,
  })  : _label = label,
        _name = name,
        _orientation = orientation,
        _isMandatory = isMandatory,
        _isReadonly = isReadonly,
        _hasLabel = hasLabel,
        _onchange = onChange,
        _datasetId = datasetId,
        _selectedIDs = selectedIDs as List<String>,
        super(key: key);

  final String _label;
  final String _name;
  final String _orientation;
  final bool _isMandatory;
  final bool _isReadonly;
  final bool _hasLabel;
  final FieldOnChange _onchange;
  final String _datasetId;
  final List<String> _selectedIDs;
  static const _defaultSize = 50.0;

  @override
  Widget buildScreen({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    viewModel.loadCheckBoxes(context, _datasetId);
    final appTheme = AppTheme.of(context).theme;
    const loadingIndicator = SizedBox(
      width: _defaultSize,
      height: _defaultSize,
      child: ExtoLoading(),
    );
    return BlocBuilder<CheckBoxListViewModel, CheckBoxListState>(
      bloc: viewModel,
      builder: (_, state) {
        return (state is Loading)
            ? loadingIndicator
            : _buildCheckBoxList(
                context: context,
                appTheme: appTheme,
                state: state as Loaded,
              );
      },
    );
  }

  Widget _buildCheckBoxList({
    required BuildContext context,
    required IAppThemeData appTheme,
    required Loaded state,
  }) {
    return AbsorbPointer(
      absorbing: _isReadonly,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(
            appTheme: appTheme,
            context: context,
          ),
          _buildCheckboxItems(
            appTheme: appTheme,
            state: state,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxItems({
    required IAppThemeData appTheme,
    required Loaded state,
  }) {
    final _orient = FieldRendererHelpers.specifyOrientation(_orientation);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: state.data.data.items.length,
      itemBuilder: (context, index) {
        final item = state.data.data.items[index];
        return ExtoCheckbox(
          name: item.value,
          initialValue: _selectedIDs.contains(item.value),
          orientation: _orient,
          onChanged: (isChecked) {
            if (isChecked!) {
              _selectedIDs.add(item.value);
            } else {
              _selectedIDs.removeWhere((element) => element == item.value);
            }

            _onchange.call(
              key: _name,
              value: _selectedIDs,
            );
          },
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.label,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: item.disabled ? appTheme.colors.disabledText : null,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLabel({
    required BuildContext context,
    required IAppThemeData appTheme,
  }) =>
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                if (_hasLabel)
                  TextSpan(
                    text: _label,
                  ),
                if (_isMandatory)
                  const TextSpan(
                    text: Strings.mandatoryIndicator,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
}
