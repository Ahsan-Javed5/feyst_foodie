import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chef/base/base.dart';
import 'package:chef/constants/strings.dart';
import 'package:chef/models/models.dart';
import 'package:chef/services/services.dart';
import 'package:chef/ui_kit/exto_ui_kit.dart';
import 'package:chef/ui_kit/helpers/dialog_helper.dart';
import 'package:chef/screens/custom_form/fields/check_list/attachments/check_list_attachments_v.dart';
import 'package:chef/screens/custom_form/fields/check_list/component/check_list_m.dart';
import 'package:chef/screens/custom_form/fields/check_list/component/check_list_vm.dart';
import 'package:chef/screens/custom_form/fields/check_list/widgets/check_list_item.dart'
    as widget;

class CheckListView extends BaseView<CheckListViewModel> {
  CheckListView({
    required FieldOnChange onChange,
    required String checkListID,
    required String recordId,
    bool isInEditMode = false,
    List? selectedValue,
    Key? key,
  })  : _onChange = onChange,
        _checkListID = checkListID,
        _recordId = recordId,
        _isInEditMode = isInEditMode,
        _selectedValue = selectedValue,
        super(key: key);

  final FieldOnChange _onChange;
  final String _checkListID;
  final List? _selectedValue;
  final String? _recordId;
  final bool _isInEditMode;

  @override
  Widget buildScreen({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    return BlocBuilder<CheckListViewModel, CheckListState>(
      bloc: viewModel
        ..loadCheckList(
          context: context,
          checkListID: _checkListID,
          recordId: _recordId!,
          isInEditMode: _isInEditMode,
          existingCheckList: _selectedValue,
        ),
      builder: (_, state) => state.when(
        loading: _loading,
        loaded: (checkList) => _buildSuccess(
          checkList: checkList,
          screenSizeData: screenSizeData,
        ),
        error: _error,
      ),
    );
  }

  Widget _loading() => const SizedBox(height: 100, child: ExtoLoading());

  Widget _error() => const SizedBox();

  Widget _buildSuccess({
    required CheckList checkList,
    required ScreenSizeData screenSizeData,
  }) {
    viewModel.addChecklistToRenderer(
      onChange: _onChange,
      mainCheckList: checkList,
    );

    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: checkList.items?.length,
      itemBuilder: (context, index) {
        var item = checkList.items![index];
        return widget.CheckListItem(
          title: '',
          id: (item.id)!,
          subtitle: item.description ?? '',
          options: (item.options)!,
          uiType: (item.uiType) != null ? item.uiType!.name : UiType.text.name,
          items: item.items,
          parentItem: item,
          actions: FieldRendererHelpers.specifyActions(item),
          itemAttachmentOnTap: (fieldId) => DialogHelper.show(
            context: context,
            title: Strings.checkListAttachments,
            body: CheckListAttachmentsView(
              checkList: checkList,
              fieldId: fieldId,
            ),
            isDismissible: false,
            maxHeight: screenSizeData.size.height * 0.6,
          ),
          onChange: ({
            required String key,
            required dynamic value,
          }) =>
              viewModel.updateCheckList(
            mainCheckList: checkList,
            key: key,
            value: value.toString(),
            item: item,
            onChange: _onChange,
          ),
        );
      },
    );
  }
}
