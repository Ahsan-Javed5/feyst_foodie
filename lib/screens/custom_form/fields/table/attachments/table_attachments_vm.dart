import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:open_file/open_file.dart';
import 'package:open_settings/open_settings.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:chef/base/base_viewmodel.dart';
import 'package:chef/constants/constants.dart';
import 'package:chef/models/custom_forms/upload_attachment.dart';
import 'package:chef/models/models.dart';
import 'package:chef/services/application_state.dart';
import 'package:chef/services/network/network_service.dart';
import 'package:chef/services/storage/storage_service.dart';
import 'package:chef/ui_kit/helpers/toaster_helper.dart';
import 'package:chef/screens/custom_form/fields/table/attachments/table_attachments_m.dart';

@injectable
class TableAttachmentsViewModel extends BaseViewModel<TableAttachmentsState> {
  TableAttachmentsViewModel({
    required INetworkService network,
    required ApplicationService appService,
    required IStorageService storageService,
  })  : _network = network,
        _appService = appService,
        _storageService = storageService,
        super(const Loading([]));

  final INetworkService _network;
  final ApplicationService _appService;
  final IStorageService _storageService;

  void downloadAttachment(BuildContext context, String documentId) async {
    emit(Loading(state.attachmentList));

    final path = Api.apiVersion +
        Api.apiDocuments +
        '${Api.apiDocumentsDownloadSwitch}/$documentId';

    try {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        final response = await _network.gaurdedGet(path: path);
        final filename = getDocumentTitle(documentId, state.attachmentList);
        final savedFile = await _saveFile(response, filename);
        final length = await savedFile.length();
        if (length <= 0) {
          Toaster.errorToast(
            context: context,
            message: Strings.downloadFileError,
          );
        }
      } else if (status.isDenied) {
        Toaster.errorToast(
          context: context,
          message: Strings.needPermissions,
        );
      } else if (status.isPermanentlyDenied) {
        Toaster.errorToast(
          context: context,
          message: Strings.openSettings,
          actions: [
            ToastAction.ok(
              onTap: () => OpenSettings.openAppSetting(),
            )
          ],
        );
      }
      emit(Loaded(state.attachmentList));
    } catch (e) {
      Toaster.errorToast(
        context: context,
        message: e.toString(),
      );
    }
  }

  Future<File> _saveFile(Response response, String filename) async {
    var path = Strings.downloadBasePath + filename;
    var file = File(path);

    if (!await file.exists()) {
      file = await file.writeAsBytes(response.bodyBytes);
    }
    OpenFile.open(path);
    return file;
  }

  String getDocumentTitle(String documentId, List<Attachment> attachmentList) {
    var name = '';
    for (var item in attachmentList) {
      if (item.id == documentId) name = item.name;
    }
    return name;
  }

  void loadAttachmentList({
    required BuildContext context,
    required String linkedId,
  }) async {
    var parentId = _appService.state.workflow?.record?.recordNumber;
    var parentRefId = _appService.state.workflow?.record?.refID;
    final exitData = <Attachment>[];

    try {
      final projectId =
          _storageService.readString(key: PreferencesKeys.projectId);
      final header = {
        Api.headerProjectKey: projectId,
      };

      final apiResponse = await _network.gaurdedGet(
        path: Api.apiVersion +
            Api.apiDocuments +
            '?&parentId=$parentId&'
                'linkedID=$linkedId&'
                'parentRefID=$parentRefId',
        header: header,
      );
      final forms = jsonDecode(apiResponse.body);
      final data = forms[PreferencesKeys.data];
      for (var item in data) {
        exitData.add(
          Attachment.fromJson(item),
        );
      }
      emit(Loaded(exitData));
    } catch (error) {
      Toaster.errorToast(
        context: context,
        message: error.toString(),
      );
      emit(const Loaded([]));
    }
  }

  void uploadAttachment({
    required BuildContext context,
    required String linkedId,
  }) async {
    var moduleName = _appService.state.workflow?.moduleName;
    var parentId = _appService.state.workflow?.record?.recordNumber;
    var linkedRefId = _appService.state.workflow?.record?.refID;
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      try {
        emit(Loading(state.attachmentList));
        final file = File(result.files.single.path!);
        final projectId =
            _storageService.readString(key: PreferencesKeys.projectId);
        final workspaceId =
            _storageService.readString(key: PreferencesKeys.sWorkspaceId);
        final _header = {
          Api.headerProjectKey: projectId,
          Api.headerWorkspaceKey: workspaceId,
        };

        const url =
            Api.apiVersion + Api.apiDocuments + Api.apiDocumentsUploadSwitch;

        var metaData = {
          'docNumber': '',
          'docTitle': result.files.single.name,
          'category': '',
          'nativeTag': linkedId,
          'description': '',
          'userTags': []
        };

        final formData = {
          Api.uploadFile: file.path,
          Api.uploadModule: moduleName,
          Api.uploadLinkedRefID: linkedRefId,
          Api.uploadLinkedID: linkedId,
          Api.uploadParentId: parentId,
          Api.uploadMeta: jsonEncode(metaData)
        };

        final response = await _network.upload(
          path: url,
          formData: formData,
          header: _header,
        );
        if (response.statusCode == 201) {
          final uploadedAttachment =
              UploadAttachment.fromJson(jsonDecode(response.body));

          final successMessage = uploadedAttachment.message;
          Toaster.successToast(
            context: context,
            message: successMessage,
          );
        } else {
          Toaster.errorToast(
            context: context,
            message: response.reasonPhrase!,
          );
        }
      } catch (e) {
        Toaster.showToast(
          context: context,
          message: e.toString(),
          toastType: ToastType.error,
        );
      }

      loadAttachmentList(
        context: context,
        linkedId: linkedId,
      );
    }
  }
}
