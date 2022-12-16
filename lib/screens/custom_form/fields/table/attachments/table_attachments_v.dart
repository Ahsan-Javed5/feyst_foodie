import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chef/base/base_view.dart';
import 'package:chef/constants/strings.dart';
import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/models.dart';
import 'package:chef/services/device/device_service.dart';
import 'package:chef/ui_kit/general_ui_kit.dart';
import 'package:chef/screens/custom_form/widgets/custom_field_sidebar/custom_field_sidebar_v.dart';
import 'package:chef/screens/custom_form/fields/table/attachments/table_attachments_m.dart';
import 'package:chef/screens/custom_form/fields/table/attachments/table_attachments_vm.dart';

class TableAttachmentsView extends BaseView<TableAttachmentsViewModel> {
  TableAttachmentsView({
    required this.linkedId,
    Key? key,
  }) : super(key: key);

  final String linkedId;
  static const _bottomPadding = 12.0;
  static const _decimal = 2;

  @override
  Widget buildScreen({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    viewModel.loadAttachmentList(
      context: context,
      linkedId: linkedId,
    );
    return BlocBuilder<TableAttachmentsViewModel, TableAttachmentsState>(
      bloc: viewModel,
      builder: (_, state) => state.when(
        loading: (attachmentList) => _loading(screenSizeData),
        loaded: (attachmentList) => _buildSuccess(
          attachmentList: attachmentList,
          screenSizeData: screenSizeData,
          context: context,
        ),
      ),
    );
  }

  Widget _loading(ScreenSizeData screenSizeData) => SizedBox(
        height: screenSizeData.size.height * 0.5,
        child: const GeneralLoading(),
      );

  Widget _buildSuccess({
    required List<Attachment> attachmentList,
    required ScreenSizeData screenSizeData,
    required BuildContext context,
  }) {
    return SizedBox(
      height: screenSizeData.size.height * 0.5,
      width: screenSizeData.size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _createAttachments(
                  context,
                  attachmentList,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: _bottomPadding,
          ),
          GeneralButton(
            title: Strings.upload,
            onTap: () => viewModel.uploadAttachment(
              context: context,
              linkedId: linkedId,
            ),
            isEnable: true,
            isBusy: false,
            buttonType: ButtonType.button,
          )
        ],
      ),
    );
  }

  List<Widget> _createAttachments(
    BuildContext context,
    List<Attachment> attachList,
  ) {
    final list = <Widget>[];
    for (var item in attachList) {
      final fileSize = FileHelper.getFileSizeString(
        bytes: item.size,
        decimals: _decimal,
      );
      list.add(
        GestureDetector(
          onTap: () => viewModel.downloadAttachment(context, item.id),
          child: AttachmentTile(
            attachment: item,
            fileSize: fileSize,
          ),
        ),
      );
    }
    return list;
  }
}
