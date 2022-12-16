import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chef/base/base.dart';
import 'package:chef/constants/constants.dart';
import 'package:chef/theme/app_theme_data/app_theme_data.dart';
import 'package:chef/theme/app_theme_widget.dart';
import 'package:chef/models/custom_forms/data_set.dart' as data_set;
import 'package:chef/ui_kit/general_ui_kit.dart';
import 'package:chef/services/services.dart';
import 'package:chef/screens/custom_form/fields/radio_button/radio_list_m.dart';
import 'package:chef/screens/custom_form/fields/radio_button/radio_list_vm.dart';
import 'package:chef/screens/custom_form/widgets/exto_field_option.dart';

class RadioListView extends BaseView<RadioListViewModel> {
  RadioListView({
    required String label,
    required String name,
    required String orientation,
    required bool isMandatory,
    required bool isReadonly,
    required bool hasLabel,
    required FieldOnChange onChange,
    required String datasetId,
    List<String>? selectedValue,
    Key? key,
  })  : _label = label,
        _name = name,
        _orientation = orientation,
        _isMandatory = isMandatory,
        _isReadonly = isReadonly,
        _hasLabel = hasLabel,
        _onChange = onChange,
        _selectedValue = selectedValue as List<String>,
        _datasetId = datasetId,
        super(key: key);

  final String _name;
  final String _label;
  final String _orientation;
  final bool _isMandatory;
  final bool _isReadonly;
  final bool _hasLabel;
  final FieldOnChange _onChange;
  final List<String>? _selectedValue;
  final String _datasetId;

  static const _defaultSize = 50.0;
  static const _padding = 8.0;

  @override
  Widget buildScreen({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    viewModel.loadRadioButtons(context, _datasetId);
    final appTheme = AppTheme.of(context).theme;
    const loadingIndicator = SizedBox(
      width: _defaultSize,
      height: _defaultSize,
      child: GeneralLoading(),
    );
    return BlocBuilder<RadioListViewModel, RadioListState>(
      bloc: viewModel,
      builder: (_, state) {
        return (state is Loading)
            ? loadingIndicator
            : _buildRadioButton(
                context: context,
                appTheme: appTheme,
                state: state as Loaded,
              );
      },
    );
  }

  Widget _buildRadioButton({
    required BuildContext context,
    required IAppThemeData appTheme,
    required Loaded state,
  }) {
    final orientation = FieldRendererHelpers.specifyOrientation(_orientation);
    return AbsorbPointer(
      absorbing: _isReadonly,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(
            appTheme: appTheme,
            context: context,
          ),
          GeneralRadioGroup<String>(
            orientation: orientation,
            initialValue:
                _selectedValue!.isNotEmpty ? _selectedValue![0] : null,
            name: 'best_language',
            onChanged: (selectable) {
              _selectedValue!.clear();
              _selectedValue!.add(selectable!);
              _onChange.call(
                key: _name,
                value: _selectedValue![0],
              );
            },
            validator: (value) =>
                value == null || value.isEmpty ? Strings.requiredField : null,
            items: state.data.data.items
                .map(
                  (selectable) => ExtoFieldOption<String>(
                    optionData: FieldOptionModel(
                      id: selectable.label,
                      label: selectable.label,
                      value: selectable.value,
                      isDisable: selectable.disabled,
                      isHidden: selectable.hidden,
                    ),
                    child: _buildRadioItem(selectable, context),
                  ),
                )
                .toList(growable: false),
            controlAffinity: ControlAffinity.trailing,
          ),
        ],
      ),
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

  Widget _buildRadioItem(data_set.Item item, BuildContext context) {
    return AbsorbPointer(
      absorbing: item.disabled,
      child: Padding(
        padding: const EdgeInsets.all(_padding),
        child: Text(item.value),
      ),
    );
  }
}
