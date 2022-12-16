import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:chef/base/base_view.dart';
import 'package:chef/helpers/helpers.dart';
import 'package:chef/models/models.dart';
import 'package:chef/services/device/device_service.dart';
import 'package:chef/ui_kit/general_ui_kit.dart';
import 'package:chef/screens/custom_form/widgets/custom_field_sidebar/custom_field_sidebar_v.dart';
import 'package:chef/screens/custom_form/fields/check_list/attachments/check_list_attachments_m.dart';
import 'package:chef/screens/custom_form/fields/check_list/attachments/check_list_attachments_vm.dart';

class CheckListAttachmentsView extends BaseView<CheckListAttachmentsViewModel> {
  CheckListAttachmentsView({
    required CheckList checkList,
    required String fieldId,
    Key? key,
  })  : _checkList = checkList,
        _fieldId = fieldId,
        super(key: key);

  final CheckList _checkList;
  final String _fieldId;

  static const _bottomPadding = 12.0;
  static const _decimal = 2;

  @override
  Widget buildScreen({
    required BuildContext context,
    required ScreenSizeData screenSizeData,
  }) {
    viewModel.loadAttachmentList(
      context: context,
      checkListId: _checkList.id ?? '',
      fieldId: _fieldId,
    );
    return BlocBuilder<CheckListAttachmentsViewModel,
        CheckListAttachmentsState>(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.browse_gallery_sharp),
                onPressed: () => viewModel.uploadAttachment(
                  context: context,
                  checkListId: _checkList.id ?? '',
                  fieldId: _fieldId,
                  imageSourceType: ImageSource.gallery,
                ),
              ),
              const SizedBox(width: 5),
              IconButton(
                icon: const Icon(Icons.camera),
                onPressed: () => viewModel.uploadAttachment(
                  context: context,
                  checkListId: _checkList.id ?? '',
                  fieldId: _fieldId,
                  imageSourceType: ImageSource.camera,
                ),
              )
            ],
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
