import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chef/theme/theme.dart';
import 'package:chef/ui_kit/widgets/scroll_edge_listener.dart';
import 'package:chef/base/base.dart';
import 'package:chef/services/services.dart';
import 'package:chef/ui_kit/exto_ui_kit.dart';
import 'package:chef/models/custom_forms/external_fields/external_field.dart';
import 'package:chef/screens/custom_form/fields/external_field/component/external_field_m.dart';
import 'package:chef/screens/custom_form/fields/external_field/component/external_field_vm.dart';

class ExternalFieldView extends BaseView<ExternalFieldViewModel> {
  ExternalFieldView({
    required String extId,
    Key? key,
  })  : _extId = extId,
        super(key: key);

  final String _extId;

  static const _defaultSize = 50.0;

  @override
  Widget buildScreen({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    viewModel.loadFields(
      context: context,
      extId: _extId,
    );

    const loadingIndicator = SizedBox(
      width: _defaultSize,
      height: _defaultSize,
      child: ExtoLoading(),
    );

    final appTheme = AppTheme.of(context).theme;

    return BlocBuilder<ExternalFieldViewModel, ExternalFieldState>(
      bloc: viewModel,
      builder: (_, state) {
        return (state is Loading)
            ? loadingIndicator
            : _buildRecordList(
                appTheme: appTheme,
                fields: (state as Loaded).extFieldDisplay,
                context: context,
                state: state,
              );
      },
    );
  }

  Widget _buildRecordList({
    required IAppThemeData appTheme,
    required ExtFieldDisplay fields,
    required ExternalFieldState state,
    required BuildContext context,
  }) {
    return Stack(
      children: [
        ScrollEdgeListener(
          listener: (page) {
            viewModel.loadRecords(
              context: context,
              page: page,
              extId: _extId,
            );
          },
          child: ListView.builder(
            itemCount: fields.title.length,
            itemBuilder: (builderContext, index) {
              return GestureDetector(
                onTap: () {
                  final selectedExtField = ExtFieldSend(
                    title: fields.title[index],
                    subtitle: fields.subtitle[index],
                    value: fields.value[index],
                    primaryFieldValue:
                        (state as Loaded).extFieldData.valuePrimaryField,
                  );
                  viewModel.onExFieldSelection(selectedExtField);
                },
                child: ExtoCardItem(
                  title: fields.value[index],
                  subtitle: fields.subtitle[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
